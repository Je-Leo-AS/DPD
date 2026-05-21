# Post-Place-and-Route Timing Simulation using Questa/ModelSim

This repository contains a VHDL implementation of a DPD (Digital Predistortion) architecture synthesized and implemented using Xilinx ISE 14.7.

To validate the design with realistic FPGA timing delays, a **post-place-and-route timing simulation** was performed using:

- Xilinx ISE 14.7
- Netgen
- Questa/ModelSim (Intel FPGA Starter Edition)

The simulation includes:

- LUT delays
- Routing delays
- DSP delays
- Flip-flop delays
- Timing information extracted from the routed FPGA design

This provides a simulation much closer to real FPGA hardware behavior compared to behavioral VHDL simulation.

---

# 1. Generate Post-PAR Timing Files in Xilinx ISE

After synthesis, map, and place-and-route complete successfully, generate the timing simulation files.

In Xilinx ISE:

```text
Processes -> Implement Design ->
Generate Post-Place & Route Simulation Model
````

This generates:

```text
netgen/par/DPD_timesim.v
netgen/par/DPD_timesim.sdf
```

These files contain:

* Gate-level netlist
* Real FPGA timing delays

---

# 2. Copy Files to Simulation Folder

Example:

```bash
mkdir questa_sim
cd questa_sim

cp ../netgen/par/DPD_timesim.v .
cp ../netgen/par/DPD_timesim.sdf .

cp ../functions.vhd .
cp ../tb_main.vhd .
```

Also copy `glbl.v` from the Xilinx installation:

```bash
cp /opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/glbl.v .
```

---

# 3. Install Questa/ModelSim

This project was simulated using:

```text
Questa Altera Starter FPGA Edition 2025.2
```

Example installation on Arch Linux:

```bash
yay -S quartus-free-questa
```

---

# 4. Configure License

A valid Intel/Questa Starter license is required.

Example environment variables:

```bash
export PATH=/opt/intelFPGA/25.1/questa_fse/bin:$PATH

export MGLS_LICENSE_FILE=$HOME/licenses/LR-XXXXX_License.dat

export SALT_LICENSE_SERVER=$MGLS_LICENSE_FILE

unset LM_LICENSE_FILE
```

---

# 5. Fix SDF Path inside Netlist

The generated `DPD_timesim.v` may contain:

```verilog
$sdf_annotate("netgen/par/DPD_timesim.sdf");
```

If the simulation files were copied to another directory, update the path:

```bash
sed -i 's|netgen/par/DPD_timesim.sdf|DPD_timesim.sdf|g' DPD_timesim.v
```

---

# 6. Create Questa Libraries

Start Questa:

```bash
vsim
```

Inside the TCL console:

```tcl
vlib work
vmap work work

vlib simprims_ver
vlib unisims_ver
vlib unimacro_ver
```

---

# 7. Compile Xilinx Libraries

## UNISIMS

```tcl
vlog -work unisims_ver \
/opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/unisims/*.v
```

## SIMPRIMS

```tcl
vlog -work simprims_ver \
/opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/simprims/*.v
```

## UNIMACRO

```tcl
vlog -work unimacro_ver \
/opt/Xilinx/14.7/ISE_DS/ISE/verilog/src/unimacro/*.v
```

---

# 8. Compile Project

```tcl
vlog DPD_timesim.v
vlog glbl.v

vcom -93 functions.vhd
vcom -2008 tb_main.vhd
```

---

# 9. Run Timing Simulation

Console-only mode is recommended for large post-route simulations.

```bash
vsim -c -t 1ps work.tb work.glbl \
-L simprims_ver \
-L unisims_ver \
-L unimacro_ver \
-do "run -all; quit"
```

---

# 10. Simulation Output

The testbench generates output `.txt` files automatically.

Example:

```text
simulation_output.txt
```

These files can then be compared against:

* Python floating-point model
* Fixed-point Python implementation
* Behavioral VHDL simulation

---

# Notes

* This is a **gate-level timing simulation**.
* Real FPGA routing delays are included through SDF annotation.
* Simulation is significantly slower than behavioral simulation.
* GUI waveform visualization is not recommended for large designs.

---

# Validation Flow

```text
Python Model
      ↓
VHDL RTL
      ↓
Xilinx ISE Synthesis
      ↓
Map / Place-and-Route
      ↓
Netgen Timing Netlist + SDF
      ↓
Questa Timing Simulation
      ↓
TXT Output Comparison
```

---

# Tested Environment

* Arch Linux
* Xilinx ISE 14.7
* Questa Altera Starter FPGA Edition 2025.2
* Virtex-5 FPGA
