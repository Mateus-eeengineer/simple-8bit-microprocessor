[Read this in English](README.md)

---

# Microprocessador de 8 bits em VHDL

## 📖 Sobre o Projeto

Este repositório contém a implementação de um microprocessador simples de 8 bits, desenvolvido como projeto final para a disciplina de [Nome da Disciplina] na [Nome da sua Universidade] durante o [Seu Semestre, ex: 1º Semestre de 2024].

O objetivo do projeto foi projetar, implementar e simular um sistema computacional mínimo, composto por uma Unidade Lógica e Aritmética (ULA), uma Unidade de Memória e uma Unidade de Controle, capaz de executar um conjunto básico de instruções.

## ✨ Funcionalidades

O microprocessador implementado possui as seguintes funcionalidades:
- **Arquitetura de 8 bits:** Todos os registradores e o barramento de dados operam com 8 bits.
- **Memória RAM:** Uma memória de 64 posições de 8 bits (`ADDR_WIDTH = 6`, `DATA_WIDTH = 8`).
- **Operações Aritméticas:** Suporta as operações de Soma (`ADD`) e Subtração (`SUB`).
- **Operações Lógicas:** Suporta as operações `AND`, `OR` e `NOT`.
- **Acesso à Memória:** Permite carregar dados da memória para o acumulador (`LOAD`) e salvar dados do acumulador na memória (`STORE`).
- **Controlo de Fluxo:** Possui uma instrução de paragem (`HALT`) para finalizar a execução do programa.

## 🏛️ Arquitetura

O sistema é baseado numa arquitetura de acumulador simples. Os principais componentes são:
- **Unidade de Controle:** Implementada como uma Máquina de Estados Finitos (FSM) que orquestra o ciclo de busca, decodificação e execução das instruções.
- **Unidade Lógica e Aritmética (ULA):** Um bloco combinacional que realiza as operações aritméticas e lógicas.
- **Memória (RAM):** Um componente sequencial para armazenar tanto as instruções do programa quanto os dados.
- **Registradores:**
  - `acc` (Acumulador): Armazena o resultado das operações.
  - `ri` (Registrador de Instrução): Armazena a instrução atual.
  - `contador` (Contador de Programa): Aponta para o endereço da próxima instrução.

## 💻 Conjunto de Instruções (ISA)

As instruções possuem 8 bits, divididos em um opcode de 3 bits e um endereço/operando de 5 bits.

| Opcode | Mnemónico | Descrição                                        |
| :----: | :-------: | :----------------------------------------------- |
| `000`  |   `LOAD`  | Carrega um dado da memória para o acumulador.      |
| `001`  |  `STORE`  | Salva o valor do acumulador numa posição de memória. |
| `010`  |   `ADD`   | Soma o valor do acumulador com um dado da memória. |
| `011`  |   `SUB`   | Subtrai um dado da memória do valor do acumulador. |
| `100`  |   `AND`   | Realiza um `AND` lógico entre o acumulador e um dado. |
| `101`  |   `OR`    | Realiza um `OR` lógico entre o acumulador e um dado.  |
| `110`  |   `NOT`   | Inverte os bits do acumulador.                   |
| `111`  |   `HALT`  | Para a execução do processador.                  |

## 🛠️ Ferramentas Utilizadas

- **Linguagem:** VHDL (Padrão 2008)
- **Simulação:** ModelSim - Altera

## 🚀 Como Utilizar

Para simular este projeto:
1.  Clone o repositório:
    ```bash
    git clone [URL-do-seu-repositório]
    ```
2.  Abra o ModelSim.
3.  No console do ModelSim, navegue até o diretório do projeto.
4.  Execute o script de simulação:
    ```tcl
    do test.do
    ```
5.  A janela de ondas (Wave) será aberta e a simulação será executada, mostrando o funcionamento do processador.

## 👤 Autor

- **Nome:** [Seu Nome Completo]
- **GitHub:** [@SeuUsuario]
- **LinkedIn:** [URL-do-seu-LinkedIn]
