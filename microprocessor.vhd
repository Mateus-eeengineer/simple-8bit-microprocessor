--UFMS 2025

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

---------------------------------------------------------------------------------
-- Entidade da memoria RAM de porta única
---------------------------------------------------------------------------------
entity memoria is
	generic 
	(
		DATA_WIDTH : integer := 8;
		ADDR_WIDTH : integer := 6
	);
	port 
	(
		clk		: in std_logic;
		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
		data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
	);
end entity;

architecture rtl of memoria is
	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array(2**ADDR_WIDTH-1 downto 0) of word_t;
	signal ram : memory_t;
	signal addr_reg : natural range 0 to 2**ADDR_WIDTH-1;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we = '1') then
				ram(addr) <= data;
			end if;
			addr_reg <= addr;
		end if;
	end process;
	q <= ram(addr_reg);
end rtl;

-------------------------------------------------------------------------------
-- Arquitetura do Microprocessador (Versão Simplificada)
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessor is
    port (
        clk     : in std_logic;
        reset   : in std_logic;
        result  : out std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of microprocessor is
    -- Declaração do componente de memóira
    component memoria
        generic ( DATA_WIDTH : integer := 8; ADDR_WIDTH : integer := 6 );
        port ( clk : in std_logic; addr : in natural range 0 to 2**ADDR_WIDTH - 1; data : in std_logic_vector((DATA_WIDTH-1) downto 0); we : in std_logic; q : out std_logic_vector((DATA_WIDTH-1) downto 0) );
    end component;

    -- =======================================================================
    -- SINAIS E REGISTRADORES INTERNOS
    -- =======================================================================
    
    -- Registradores do Processador
    signal pc     : natural range 0 to 63 := 0;  -- pc de Programa (PC)
    signal acc          : std_logic_vector(7 downto 0) := (others => '0'); -- Acumulador (ACC)
    signal ir           : std_logic_vector(7 downto 0) := (others => '0'); -- Registrador de Instrução (ir)
    signal operand_reg  : std_logic_vector(7 downto 0) := (others => '0'); -- Guarda o operando vindo da memóira

    -- Sinais de comunicação com a Memóira
    signal we_ram       : std_logic := '0';
    signal ram_addr     : natural range 0 to 63 := 0;
    signal ram_data_in  : std_logic_vector(7 downto 0) := (others => '0');
    signal ram_data_out : std_logic_vector(7 downto 0) := (others => '0');
    
    -- Sinais da Unidade de Controle
    type state_type is (S_RESET, S_FETCH, S_FETCH_WAIT, S_DECODE, S_MEM_WAIT, S_MEM_READ, S_EXECUTE, S_HALT);
    signal state    : state_type := S_RESET;
    signal opcode   : std_logic_vector(2 downto 0);
    signal addr_part: natural range 0 to 31;
    signal ula_result: std_logic_vector(7 downto 0);

    -- =======================================================================
    -- CONSTANTES DE OPCODES (Conjunto de Instruções - ISA)
    -- =======================================================================
    constant OP_LOAD  : std_logic_vector(2 downto 0) := "000";
    constant OP_STORE : std_logic_vector(2 downto 0) := "001";
    constant OP_ADD   : std_logic_vector(2 downto 0) := "010";
    constant OP_SUB   : std_logic_vector(2 downto 0) := "011";
    constant OP_AND   : std_logic_vector(2 downto 0) := "100";
    constant OP_OR    : std_logic_vector(2 downto 0) := "101";
    constant OP_NOT   : std_logic_vector(2 downto 0) := "110";
    constant OP_HALT  : std_logic_vector(2 downto 0) := "111";

begin
    -- Instância da Memóira RAM
    RAM_INST: memoria
        port map ( clk => clk, addr => ram_addr, data => ram_data_in, we => we_ram, q => ram_data_out );

    -- =======================================================================
    -- LÓGICA COMBINACIONAL
    -- =======================================================================

    -- Decodificador de Instrução
    opcode    <= ir(7 downto 5);
    addr_part <= to_integer(unsigned(ir(4 downto 0)));

    -- Unidade Lógica e Airtmética (ULA)
    ula_process: process(opcode, acc, operand_reg)
    begin
        case opcode is
            when OP_ADD   => ula_result <= std_logic_vector(unsigned(acc) + unsigned(operand_reg));
            when OP_SUB   => ula_result <= std_logic_vector(unsigned(acc) - unsigned(operand_reg));
            when OP_AND   => ula_result <= acc and operand_reg;
            when OP_OR    => ula_result <= acc or operand_reg;
            when OP_NOT   => ula_result <= not acc;
            when others   => ula_result <= (others => '0');
        end case;
    end process;
    
    -- A saída do circuito é sempre o valor do acumulador
    result <= acc;

    -- =======================================================================
    -- PROCESSO PirNCIPAL (UNIDADE DE CONTROLE E REGISTRADORES)
    -- =======================================================================
    main_process: process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state     <= S_RESET;
                pc  <= 0;
                acc       <= (others => '0');
                we_ram    <= '0';
            else
                we_ram <= '0'; -- Garante que a escirta seja desativada por padrão

                case state is
                    when S_RESET =>
                        pc <= 0;
                        acc      <= (others => '0');
                        state    <= S_FETCH;
						  when S_FETCH =>
                        ram_addr <= pc;
                        state <= S_FETCH_WAIT; 

                    when S_FETCH_WAIT =>
                        -- Apenas espera um ciclo para o dado da memóira ficar pronto
                        state <= S_DECODE;

                    when S_DECODE =>
                        ir <= ram_data_out;
                        pc <= pc + 1;
                        
                        case ram_data_out(7 downto 5) is
                            when OP_LOAD | OP_ADD | OP_SUB | OP_AND | OP_OR =>
                                ram_addr <= to_integer(unsigned(ram_data_out(4 downto 0)));
                                state    <= S_MEM_WAIT;
                            
                            when OP_STORE | OP_NOT =>
                                state <= S_EXECUTE;
                            
                            when OP_HALT =>
                                state <= S_HALT;
                            
                            when others => state <= S_HALT;
                        end case;

                    when S_MEM_WAIT =>                        
                        state       <= S_MEM_READ;						  

                    when S_MEM_READ =>
                        operand_reg <= ram_data_out;
                        state       <= S_EXECUTE;
								
						  when S_EXECUTE =>
                        case opcode is
                            when OP_LOAD  => acc <= operand_reg;
                            when OP_STORE => ram_addr <= addr_part; ram_data_in <= acc; we_ram <= '1';
                            when OP_ADD   => acc <= ula_result;
                            when OP_SUB   => acc <= ula_result;
                            when OP_AND   => acc <= ula_result;
                            when OP_OR    => acc <= ula_result;
                            when OP_NOT   => acc <= ula_result;
                            when others   => null;
                        end case;
                        state <= S_FETCH;

                    when S_HALT =>
                        state <= S_HALT;
                end case;
            end if;
        end if;
    end process;
    
end rtl;