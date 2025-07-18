[Read this in Portuguese](README.pt.md)

---

# 8-bit Microprocessor in VHDL

## 📖 About The Project

This repository contains the implementation of a simple 8-bit microprocessor, developed as the final project for the Digital Circuits II course at the Federal University of Mato Grosso do Sul.

The project's goal was to design, implement, and simulate a minimal computing system, comprising an Arithmetic Logic Unit (ALU), a Memory Unit, and a Control Unit, capable of executing a basic set of instructions.

## ✨ Features

The implemented microprocessor has the following features:
- **8-bit Architecture:** All registers and the data bus operate on 8 bits.
- **RAM Memory:** A 64x8-bit memory (`ADDR_WIDTH = 6`, `DATA_WIDTH = 8`).
- **Arithmetic Operations:** Supports Addition (`ADD`) and Subtraction (`SUB`).
- **Logical Operations:** Supports `AND`, `OR`, and `NOT` operations.
- **Memory Access:** Allows loading data from memory into the accumulator (`LOAD`) and storing data from the accumulator into memory (`STORE`).
- **Flow Control:** Includes a `HALT` instruction to terminate program execution.

## 🏛️ Architecture

The system is based on a simple accumulator architecture. The main components are:
- **Control Unit:** Implemented as a Finite State Machine (FSM) that orchestrates the fetch-decode-execute cycle.
- **Arithmetic Logic Unit (ALU):** A combinational block that performs arithmetic and logical operations.
- **Memory (RAM):** A sequential component for storing both program instructions and data.
- **Registers:**
  - `acc` (Accumulator): Stores the result of operations.
  - `ri` (Instruction Register): Stores the current instruction.
  - `contador` (Program Counter): Points to the address of the next instruction.

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
    git clone https://github.com/Mateus-electronics/simple-microprocessor.git
    ```
2.  Open ModelSim.
3.  In the ModelSim console, navigate to the project directory.
4.  Execute the simulation script:
    ```tcl
    do microprocessor.do
    ```
5.  The Wave window will open, and the simulation will run, showing the processor's operation.

6.  ## A few words

The project was enough for my exam, and I almost got 100% on this specific question. But, there's a fundamental mistake that I couldn't get rid of, for some reason, there's a problem with how the memory is working (or the register) that reads wrong values for some operations that I can't remember right now, the microprocessor by itself works accordingly to the instruction given. Feel free to play with my code and help me find the problem.
