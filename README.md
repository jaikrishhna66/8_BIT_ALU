# 🧠 8-Bit ALU in Verilog

This project is a Verilog-based implementation of an **8-bit Arithmetic Logic Unit (ALU)**. It performs a variety of arithmetic and logical operations based on the input control signal (`opcode`). The design is structured for simulation and synthesis on Xilinx FPGAs.

---

## ⚙️ Features

- **Inputs:**
  - `A` (8-bit)
  - `B` (8-bit)
  - `opcode` (4-bit control signal)

- **Outputs:**
  - `Y` (16-bit result)
  - `carry_out`, `overflow` (optional status flags)

- **Supported Operations:**

| Opcode | Operation       |
|--------|------------------|
| 0000   | Addition          |
| 0001   | Subtraction       |
| 0010   | Multiplication    |
| 0011   | Division          |
| 0100   | Modulo Division   |
| 0101   | AND               |
| 0110   | OR                |
| 0111   | XOR               |
| 1000   | NOT of A          |
| 1001   | Left Shift        |
| 1010   | Right Shift       |
| 1011   | Relation of A,B   |
| 1100   | 2'sComplement:A   |
| 1101   | Concatenate B,A   |
| 1110   | Concatenate A,B   |
| 1111   | Addition of A with A  |
---

## 📁 File Structure

| File Name           | Description                          |
|---------------------|--------------------------------------|
| `alu.v`             | Main Verilog ALU module              |
| `alu_tb.v`          | Testbench with all operation cases   |
| `README.md`         | Project documentation (this file)    |
| `alu_schematic.pdf` | Schematic diagram of ALU (optional)  |
| `alu_waveform.pdf`  | Waveform simulation results          |

---

## 🛠️ Tools Used

- **HDL:** Verilog
- **Simulation:** ModelSim / Vivado Simulator
- **Synthesis:** Xilinx Vivado
- **Target FPGA:** XC7A50TCSG324-1 (Artix-7)

---

## 🧪 How to Simulate

1. Open `alu.v` and `alu_tb.v` in your simulator
2. Run the simulation
3. Observe output for each opcode scenario

---


## 👨‍💻 Author

- **M Jaikrishna**
- B.Tech Final Year – Aspiring VLSI Design Engineer
- [GitHub Profile](https://github.com/jaikrishhna66)
- [Gmail id](mailto:jaikrishnamurali66@gmail.com)
- [Linkedin Handle](https://www.linkedin.com/in/jaikrishna0606/)
