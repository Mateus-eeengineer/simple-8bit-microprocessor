[Read this in Portuguese](README.pt.md)

---

# 8-bit Microprocessor (VHDL)

![Language](https://img.shields.io/badge/Language-VHDL-blue) ![Tools](https://img.shields.io/badge/Tools-ModelSim%20%7C%20Quartus-green)

## 📖 About The Project

This repository contains the implementation of a simple 8-bit microprocessor, developed as the final project for the Digital Circuits II course at the Federal University of Mato Grosso do Sul, and designed using VHDL-2008.

The project's goal was to design, implement, and simulate a minimal computing system, comprising an Arithmetic Logic Unit (ALU), a Memory Unit, and a Control Unit (FSM), capable of executing a basic set of instructions.

## ✨ Features

The implemented microprocessor has the following features:
- **Architecture:** Accumulator-based (Von Neumann).
- **RAM Memory:** A 64x8-bit memory (`ADDR_WIDTH = 6`, `DATA_WIDTH = 8`).
- **Instruction Set:** CISC-like subset (Arithmetic, Logic, Memory Access, and Control Flow).
- **Memory:** Synchronous Single-Port RAM (64 Bytes).
- **Clocking:** Single-cycle execution for ALU ops, Multi-cycle for Memory ops.
- **Flow Control:** Includes a `HALT` instruction to terminate program execution.

## 🏛️ Architecture

The design follows a modular structure separated into Entity and Architecture:

1.  **Control Unit:** An 8-state FSM (`FETCH`, `DECODE`, `EXECUTE`, etc.) handling the instruction lifecycle.
2.  **Datapath:**
    * **ALU:** Handles `ADD`, `SUB`, `AND`, `OR`, `NOT`.
    * **Registers:** `ACC` (Accumulator), `PC` (Program Counter), `IR` (Instruction Register).
3.  **Memory:** A behavioral inference of a Block RAM.

## 💻 Instruction Set Architecture (ISA)

The instructions are 8 bits long, divided into a 3-bit opcode and a 5-bit address/operand.

| Opcode | Mnemonic | Description                                        |
| :----: | :------: | :------------------------------------------------- |
| `000`  |  `LOAD`  | Loads data from memory into the accumulator.       |
| `001`  | `STORE`  | Stores the accumulator's value into a memory location. |
| `010`  |   `ADD`  | Adds the accumulator's value with data from memory.  |
| `011`  |   `SUB`  | Subtracts data from memory from the accumulator's value. |
| `100`  |   `AND`  | Performs a logical `AND` between the accumulator and data. |
| `101`  |   `OR`   | Performs a logical `OR` between the accumulator and data.  |
| `110`  |   `NOT`  | Inverts the bits of the accumulator.                 |
| `111`  |   `HALT` | Stops the processor's execution.                   |

## 🛠️ Tools Used

- **Language:** VHDL (2008 Standard)
- **Simulation:** ModelSim - Altera

## 🚀 How To Use

To simulate this project:
1.  Clone the repository:
    ```bash
    git clone https://github.com/Mateus-eeengineer/simple-microprocessor.git
    ```
2.  Open ModelSim.
3.  In the ModelSim console, navigate to the project directory.
4.  Execute the simulation script:
    ```tcl
    do microprocessor.do
    ```
5.  The Wave window will open, and the simulation will run, showing the processor's operation.

## 📊 Simulation & Results

### Waveform Analysis
The following waveform demonstrates the execution of a test program (LOAD -> ADD -> STORE). Note the `state` transitions and the `acc` register updating correctly at the end of each instruction cycle.

![Waveform Simulation](assets/waveform_print.png)  
*"Figure 1: Successful execution of the testbench, reaching HALT state with expected accumulator value."*

### Finite State Machine (FSM) Diagram
The control unit operates based on the following state transition diagram, ensuring proper timing for memory read/write operations.

![FSM Diagram](assets/fsm_diagram.png)
*"Figure 2: Diagram of the FSM's eight states that control the CPU behavior."
