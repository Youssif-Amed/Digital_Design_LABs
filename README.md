# 🚀 Digital Design LABs

Welcome to **Digital Design LABs** — a curated and evolving lab notebook showcasing my exploration of digital logic, modular hardware systems, and verification using Verilog/SystemVerilog.

From the fundamentals to near-IP-ready designs, this repo is structured for clarity, reusability, and growth — backed by simulation (QuestaSim), synthesis (Vivado), and future-ready ideas like AMBA and UVM-based flows.

> *"Not just code — this is a launchpad for real-world digital systems."*

---

## 📌 Highlighted Modules

### 🔁 Modified ALSU (Arithmetic Logic Shift Unit)
- **File:** [`Modified ALSU.v`](./Modified%20ALSU-IP%20catalog-7Seg/Modified%20ALSU.v)
- **Category:** Multi-functional Arithmetic System  
- Performs arithmetic, logic, and shift operations. Designed modularly for IP-style reuse, it also integrates 7-segment display output. This is a bridge toward SoC-style functionality.

---

### 🚗 Car Controller — FSM-Based Self-Driving Logic
- **File:** [`control_unit_Moore_FSM_Self_driving.v`](./Car_Controller_FSM/control_unit_Moore_FSM_Self_driving.v)  
- **Testbench:** [`control_unit_Moore_FSM_Self_driving_tb.v`](./Car_Controller_FSM/control_unit_Moore_FSM_Self_driving_tb.v)  
- A clean Moore FSM implementation simulating self-driving car logic. Great foundation for embedded control, robotics, and automation simulation.

---

### 🧠 Single-Port Synchronous RAM
- **File:** [`Single_port_syn_Ram.v`](./single%20port%20synchronousWriteRead_Pipelining/Single_port_syn_Ram.v)  
- **Testbench:** [`Single_port_syn_Ram_tb.v`](./single%20port%20synchronousWriteRead_Pipelining/Single_port_syn_Ram_tb.v)  
- Pipelined, synthesis-ready RAM module. Designed for integration into system-level testbenches and future bus protocol environments like APB or AXI.

---

## 📁 All Verilog Modules (Grouped by Difficulty)

### 🟢 Beginner-Friendly Modules
```markdown
- [ALU_1bit.v](./ALU_1bit.v)
- [Adder_4bit.v](./Adder_4bit.v)
- [Comparator.v](./Comparator.v)
- [Decoder_2x4.v](./Decoder_2x4.v)
- [Even_parity_gen.v](./Even_parity_gen.v)
- [Prime_check.v](./Prime_check.v)
- [D_FF_Asyn_rstn.v](./Asynchronous%20D%20FlipFlop/D_FF_Asyn_rstn.v)
- [T_FF_Asyn_rstn.v](./Asynchronous%20T%20FlipFlop/T_FF_Asyn_rstn.v)
- [D_latch_Active_clrn.v](./D%20Latch%20with%20active%20low%20Clear/D_latch_Active_clrn.v)
- [Ripple_counter_4bit.v](./Ripple%20Counter%204Bit/Ripple_counter_4bit.v)
- [Gray_counter.v](./Gray%20Counter/Gray_counter.v)
- [Generate_gray_onehot.v](./Generate_GRAYandONEHOT/Generate_gray_onehot.v)
- [Encoder_4bit.v](./Encoder_4bit/Encoder_4bit.v)
- [DEMUX_1_to_4.v](./Demux_1x4/DEMUX_1_to_4.v)
```

---

### 🟡 Intermediate Designs
```markdown
- [Struc_counter_4bit.v](./Counter_4Bit_2Different%20Ways/Struc_counter_4bit.v)
- [Behav_counter_4bit.v](./Counter_4Bit_2Different%20Ways/Behav_counter_4bit.v)
- [ALU_dis_7seg.v](./ALU_7Seg_display/ALU_dis_7seg.v)
- [N-bit_Adder.v](./N-bit%20Adder/N-bit_Adder.v)
- [parameterized_adder.v](./Parameterized%20Adder/parameterized_adder.v)
- [Par_shift_reg.v](./Parameterized%20Shift%20register/Par_shift_reg.v)
- [Ram.v](./Ram/Ram.v)
- [Linear_feedback_shift_reg.v](./Linear%20feedback%20shift%20register/Linear_feedback_shift_reg.v)
- [gray_counter_Moore_FSM.v](./Gray%20Counter/gray_counter_Moore_FSM.v)
- [Vending_machine.v](./Vending%20machine/Vending_machine.v)
- [control_unit_Moore_FSM_Self_driving.v](./Car_Controller_FSM/control_unit_Moore_FSM_Self_driving.v)
- [DSP48A1_simple.v](./Simple_DSP/DSP48A1_simple.v)
- [Single_port_syn_Ram.v](./single%20port%20synchronousWriteRead_Pipelining/Single_port_syn_Ram.v)
```

---

### 🔴 Advanced Systems & IP-Level Designs
```markdown
- [N-bit_ALU.v](./N-bit%20ALU/N-bit_ALU.v)
- [ALSU.v](./ALSU/ALSU.v)
- [Modified ALSU.v](./Modified%20ALSU-IP%20catalog-7Seg/Modified%20ALSU.v)
- [peline_stage_mod.v](./single%20port%20synchronousWriteRead_Pipelining/peline_stage_mod.v)
- [Design5_SLE.v](./SLE/Design5_SLE.v)
- [par_shift_reg.v](./Parameterized%20Shift%20register/par_shift_reg.v)
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
