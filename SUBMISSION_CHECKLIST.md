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

- [x] Push this directory as its own GitHub repository
- [x] GitHub RTL/cocotb workflow passes
- [x] Official Tiny Tapeout TTGF26c GDS build passes
- [x] Design fits the requested GF180 `1x2` tile
- [x] Static timing passes at the 16 MHz target
- [x] Tiny Tapeout precheck passes
- [x] Gate-level cocotb test passes
- [x] DRC/LVS and generated GDS reports are clean
- [x] GDS viewer inspection is complete

Verified on 2026-09-19 using GitHub Actions run `35423530614` for design
commit `5adb9a4`. See `BUILD_STATUS.md` for the measured results.

## After silicon arrives

- [ ] Start post-silicon bring-up below 10 MHz before testing 16 MHz
