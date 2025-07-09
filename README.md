# 🚀 Digital Design LABs by Youssif Amed

Welcome to **Digital Design LABs** — a curated and evolving lab notebook showcasing my exploration of digital logic, modular hardware systems, and verification using Verilog/SystemVerilog.

From the fundamentals to near-IP-ready designs, this repo is structured for clarity, reusability, and growth — backed by simulation (QuestaSim), synthesis (Vivado), and future-ready ideas like AMBA and UVM-based flows.

> *"Not just code — this is a launchpad for real-world digital systems."*

---

## 📌 Highlighted Modules

### 🔁 Modified ALSU (Arithmetic Logic Shift Unit)
- **Folder:** [`Modified ALSU-IP catalog-7Seg`](./Modified%20ALSU-IP%20catalog-7Seg)
- Performs arithmetic, logic, and shift operations. Designed modularly for IP-style reuse, it also integrates 7-segment display output. This is a bridge toward SoC-style functionality.

---

### 🚗 Car Controller — FSM-Based Self-Driving Logic
- **Folder:** [`Car_Controller_FSM`](./Car_Controller_FSM)  
- A clean Moore FSM implementation simulating self-driving car logic. Great foundation for embedded control, robotics, and automation simulation.

---

### 🧠 Single-Port Synchronous RAM
- **Folder:** [`single port synchronousWriteRead_Pipelining`](./single%20port%20synchronousWriteRead_Pipelining)  
- Pipelined, synthesis-ready RAM module. Designed for integration into system-level testbenches and future bus protocol environments like APB or AXI.

---

## 📁 All Verilog Modules (Grouped by Difficulty)

### 🟢 Beginner-Friendly Modules
```markdown
- [ALU_1bit.v](./)
- [Adder_4bit.v](./)
- [Comparator.v](./)
- [Decoder_2x4.v](./)
- [Even_parity_gen.v](./)
- [Prime_check.v](./)
- [Asynchronous D FlipFlop](./Asynchronous%20D%20FlipFlop)
- [Asynchronous T FlipFlop](./Asynchronous%20T%20FlipFlop)
- [D Latch with active low Clear](./D%20Latch%20with%20active%20low%20Clear)
- [Ripple Counter 4Bit](./Ripple%20Counter%204Bit)
- [Gray Counter](./Gray%20Counter)
- [Generate_GRAYandONEHOT](./Generate_GRAYandONEHOT)
- [Encoder_4bit](./Encoder_4bit)
- [Demux_1x4](./Demux_1x4)
```

---

### 🟡 Intermediate Designs
```markdown
- [Counter_4Bit_2Different Ways](./Counter_4Bit_2Different%20Ways)
- [ALU_7Seg_display](./ALU_7Seg_display)
- [N-bit Adder](./N-bit%20Adder)
- [Parameterized Adder](./Parameterized%20Adder)
- [Parameterized Shift register](./Parameterized%20Shift%20register)
- [Ram](./Ram)
- [Linear feedback shift register](./Linear%20feedback%20shift%20register)
- [Gray Counter (FSM)](./Gray%20Counter)
- [Vending machine](./Vending%20machine)
- [Car_Controller_FSM](./Car_Controller_FSM)
- [Simple_DSP](./Simple_DSP)
- [single port synchronousWriteRead_Pipelining](./single%20port%20synchronousWriteRead_Pipelining)
```

---

### 🔴 Advanced Systems & IP-Level Designs
```markdown
- [N-bit ALU](./N-bit%20ALU)
- [ALSU](./ALSU)
- [Modified ALSU-IP catalog-7Seg](./Modified%20ALSU-IP%20catalog-7Seg)
- [single port synchronousWriteRead_Pipelining](./single%20port%20synchronousWriteRead_Pipelining)
- [SLE](./SLE)
- [Parameterized Shift register](./Parameterized%20Shift%20register)
```

---

## 🧪 Tools & Methodology

- **Languages:** Verilog, SystemVerilog  
- **Testbenches:** Paired with most modules  
- **Simulation:** QuestaSim  
- **Synthesis:** Vivado  
- **Design Style:** Modular, reusable, testable, FPGA-friendly

---

## 🛣 Roadmap

- ✅ Design AMBA-based bus modules (APB, AXI)
- ✅ Start using UVM methodology for verification
- 🚧 Build peripheral libraries for protocol testing
- 🚧 Full system-level verification environments

---

## 🙌 Let’s Connect

Open to collaboration, discussion, or mentorship?  
Connect with me on [LinkedIn](https://www.linkedin.com/in/youssif-amed/) or ⭐ star this repo to support the journey!

---

> *Crafted with logic, tested with purpose, built for innovation.*
