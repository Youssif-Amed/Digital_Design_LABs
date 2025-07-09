# 🔧 Digital Design LABs

This repository collects all the SystemVerilog and Verilog modules I’ve developed during my digital design journey, covering both basic and advanced projects. These modules are organized for learning, reuse, and future enhancements, especially in areas like FPGA implementation and digital system simulation.

---

## 📂 Directory Structure

Each folder contains source files, testbenches, and simulation or synthesis artifacts. Below is the categorized map of the repo:

### 🧠 ALU & Related Modules
- [ALSU](./ALSU)
- [ALU_7seg_display](./ALU_7seg_display)
- [N-bit ALU](./N-bit%20ALU)
- [N-bit Adder](./N-bit%20Adder)

### 🔁 Flip-Flops and Latches
- [Asynchronous D FlipFlop](./Asynchronous%20D%20FlipFlop)
- [Asynchronous T FlipFlop](./Asynchronous%20T%20FlipFlop)
- [D Latch with Active Low Clear](./D%20Latch%20with%20active%20low%20Clear)

### ⏱️ Counters & Clocks
- [Counter_4Bit_2Different_Ways](./Counter_4Bit_2Different%20Ways)
- [Generate_CLKS_UsingCounter](./Generate_CLKS_UsingCounter)

### 🎛️ Control Modules
- [Car_Controller_FSM](./Car_Controller_FSM)
- [SLE](./SLE)
- [Vending machine](./Vending%20machine)

### 🧩 Encoders, Decoders & Demux
- [Encoder_4bit](./Encoder_4bit)
- [Decoder_2x4](./Decoder_2x4)
- [Demux_1x4](./Demux_1x4)

### 🧮 Math & Logic Blocks
- [Parameterized Adder](./Parameterized%20Adder)
- [Parameterized Shift Register](./Parameterized%20Shift%20register)
- [ALU_1bit](./ALU_1bit.v)
- [Adder_4bit](./Adder_4bit.v)
- [Comparator](./Comparator.v)
- [Even_parity_gen](./Even_parity_gen.v)
- [Prime_check](./Prime_check.v)

### 📦 Memory & FIFO
- [FIFO](./FIFO)
- [Ram](./Ram)

### ⚙️ Code Generators
- [Generate_GRAYandONEHOT](./Generate_GRAYandONEHOT)

---

## 📈 Development Tools

All modules were developed using:
- **QuestaSim / ModelSim** – Simulation and waveform analysis.
- **Vivado / Quartus** – For FPGA synthesis and implementation.

---

## ✍️ How to Use
1. Clone the repository.
2. Navigate to any module folder.
3. Compile and simulate using your preferred simulator.
4. Run the testbench or edit to explore the behavior.

---

## 🚀 Future Plans
- Add waveform images and timing diagrams.
- Connect modules to AMBA-based protocols (e.g., APB/AXI).
- Include FPGA implementation results and reports.

---

Enjoy exploring the designs — and feel free to contribute if you're also passionate about digital design!
