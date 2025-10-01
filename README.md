# DPD - Digital Predistortion

## Overview
This project implements a **Digital Predistortion (DPD)** system, combining Python for modeling and simulation with VHDL for hardware design. The goal is to mitigate non-linear distortions in power amplifiers, commonly used in communication systems, by applying predistortion techniques.

## Features
- **Python Modeling**: Includes scripts for simulating DPD algorithms, enabling performance analysis and optimization.
- **VHDL Implementation**: Hardware description for FPGA or ASIC deployment, ensuring real-time processing.
- **Modular Design**: Separates algorithm development (Python) from hardware synthesis (VHDL) for flexibility.
- **Testbenches**: VHDL testbenches for verifying hardware functionality.

## Repository Structure
- `/python`: Contains Python scripts for DPD algorithm modeling and simulation.
- `/vhdl`: VHDL source files for hardware implementation.
- `/docs`: Documentation, including setup instructions and algorithm details.
- `/tests`: Testbenches and test scripts for validation.

## Requirements
- **Python**:
  - Python 3.8+
  - Libraries: NumPy, Matplotlib, SciPy
- **VHDL**:
  - Synthesis tools: Xilinx Vivado, Intel Quartus, or similar
  - Simulation tools: ModelSim or GHDL
- **Hardware** (optional): FPGA board for deployment (e.g., Xilinx Zynq, Intel Cyclone)

## Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/Je-Leo-AS/DPD.git
   cd DPD
   ```
2. **Set up Python environment**:
   ```bash
   pip install -r python/requirements.txt
   ```
3. **Set up VHDL tools**:
   - Install a VHDL synthesis tool (e.g., Vivado or Quartus).
   - Ensure simulation tools are configured for VHDL testbenches.

## Usage
- **Python Simulation**:
  Run the main script to simulate the DPD algorithm:
  ```bash
  python python/dpd_simulation.py
  ```
  This generates plots and metrics for algorithm performance.
- **VHDL Synthesis**:
  1. Open the VHDL project in your synthesis tool.
  2. Synthesize the design in `/vhdl`.
  3. Run simulations using testbenches in `/tests`.
- **Hardware Deployment**:
  Deploy the synthesized VHDL design to an FPGA board for real-time DPD.

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact
For questions or feedback, reach out via [GitHub Issues](https://github.com/Je-Leo-AS/DPD/issues).