# Digital Design LABs 🧠⚙️

A personal collection of digital design modules and experiments written in Verilog/SystemVerilog. This repository captures my journey through learning and practicing digital logic design, ranging from fundamental components to more advanced functional blocks.

## 📁 Directory Structure

Each folder below contains a Verilog module along with its corresponding testbench (if available):

### 🔢 N-bit Arithmetic & Logic Units
- **N-bit_ALU/**  
  A parameterized ALU supporting multiple operations on variable-width operands.

- **N-bit_Adder/**  
  A scalable N-bit adder module with a matching testbench.

- **ALU_1bit.v**  
  A basic 1-bit arithmetic logic unit.

- **Adder_4bit.v**  
  A simple 4-bit ripple-carry adder.

### 🔁 Code Converters
- **Encoder_4bit/**  
  A 4-to-2 encoder design and its testbench.

- **Demux_1x4/**  
  1-to-4 demultiplexer with testbench.

- **Decoder_2x4.v**  
  A standard 2-to-4 decoder module.

### ⚙️ Display Control
- **ALU_7Seg_display/**  
  Combines a N-bit ALU with 7-segment display output logic.

### 🧠 Code Generators
- **Generate_GRAYandONEHOT/**  
  Module to convert binary input into Gray code or One-Hot representation.

- **Even_parity_gen.v**  
  Simple even parity bit generator for basic error checking.

- **Prime_check.v**  
  A module to check if a 4-bit input is a prime number.

### ⚖️ Comparators
- **Comparator.v**  
  A digital comparator to evaluate magnitude relations between two binary inputs.

---

## 🧪 Simulation

All testbenches are written in Verilog/SystemVerilog and compatible with simulators like **ModelSim**, **QuestaSim**, or **Vivado Simulator**.

---

## 🚧 More modules coming soon...

This is a growing project! I continuously add new building blocks and designs as I learn and explore more of the digital design world.

Feel free to explore, fork, and use any module for learning or project integration!
