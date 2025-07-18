#You have to fill the two following lines with the vhdl adress and name
vcom -work work 
vsim work.


add wave -noupdate -divider "Controle"
add wave clk reset state
add wave -noupdate -divider "Registradores"
add wave acc result contador
add wave -noupdate -divider "Memória"
add wave ram_addr ram_data_out we_ram
add wave -noupdate -divider "Conteúdo_Memória"
add wave -radix hex {/microprocessor/RAM_INST/ram}
add wave -noupdate -divider "ULA"
add wave /microprocessor/ula_result /microprocessor/opcode /microprocessor/operand_reg

force clk 0 0, 1 50ps -repeat 100ps

force reset 1
run 100ps
force reset 0
run 50ps

force -deposit {/microprocessor/RAM_INST/ram[0]} 00010100
force -deposit {/microprocessor/RAM_INST/ram[1]} 01010101
force -deposit {/microprocessor/RAM_INST/ram[2]} 01110110
force -deposit {/microprocessor/RAM_INST/ram[3]} 10010111
force -deposit {/microprocessor/RAM_INST/ram[4]} 10111000
force -deposit {/microprocessor/RAM_INST/ram[5]} 11000000
force -deposit {/microprocessor/RAM_INST/ram[6]} 00111001
force -deposit {/microprocessor/RAM_INST/ram[7]} 00011010
force -deposit {/microprocessor/RAM_INST/ram[8]} 11100000

force -deposit {/microprocessor/RAM_INST/ram[20]} 00000101
force -deposit {/microprocessor/RAM_INST/ram[21]} 00000011
force -deposit {/microprocessor/RAM_INST/ram[22]} 00000010
force -deposit {/microprocessor/RAM_INST/ram[23]} 00001111
force -deposit {/microprocessor/RAM_INST/ram[24]} 11110000
force -deposit {/microprocessor/RAM_INST/ram[26]} 11111111

run 1000ps
echo "Estado atual: [examine state]"
echo "ACC: [examine acc]"


run 1000ps
echo "Estado atual: [examine state]"
echo "ACC: [examine acc]"

run 1000ps
echo "Estado atual: [examine state]"
echo "ACC: [examine acc]"

run 2000ps
if {[examine state] != "S_HALT"} {
    echo "ERRO: Estado final = [examine state] (deveria ser S_HALT)"
} else {
    echo "SUCESSO: Estado HALT alcançado"
}

if {[examine acc] != "11111111"} {
    echo "ERRO: ACC = [examine acc] (deveria ser 11111111)"
} else {
    echo "SUCESSO: ACC correto (11111111)"
}

if {[examine -radix unsigned {/microprocessor/RAM_INST/ram[25]}] != 9} {
    echo "ERRO: mem25 = [examine -radix unsigned {/microprocessor/RAM_INST/ram[25]}] (deveria ser 9)"
} else {
    echo "SUCESSO: mem25 correta (9)"
}

WaveRestoreZoom 0ps 5000ps