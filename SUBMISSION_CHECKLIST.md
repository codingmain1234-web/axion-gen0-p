# AXION Gen0-P submission checklist

## Completed locally

- [x] Four-lane SIMD8 V-Core RTL implemented
- [x] Four-lane signed INT8 DOT4 SA-Core RTL implemented
- [x] 32-bit accumulator, ReLU/saturation and byte readback implemented
- [x] Built-in self-test implemented
- [x] Python reference model: 100,000 deterministic random cases passed
- [x] Verilog parsed and synthesized by Yosys
- [x] Yosys structural check: 0 reported problems, no inferred latches
- [x] JSON and YAML project files parsed successfully

## Required before ordering silicon

- [ ] Push this directory as its own GitHub repository
- [ ] GitHub RTL/cocotb workflow passes
- [ ] Official Tiny Tapeout TTGF26c GDS build passes
- [ ] Design fits the requested GF180 `1x2` tile
- [ ] Static timing passes at the 20 MHz target
- [ ] Tiny Tapeout precheck passes
- [ ] Gate-level cocotb test passes
- [ ] DRC/LVS and generated GDS reports are clean
- [ ] GDS viewer inspection is complete
- [ ] Start post-silicon bring-up below 10 MHz before testing 20 MHz

Do not place a fabrication order while any required item above remains open.
