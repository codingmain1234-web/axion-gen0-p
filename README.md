# AXION Gen0-P

AXION Gen0-P is a performance-oriented first-silicon compute prototype for a
Tiny Tapeout GF180 shuttle. It keeps the project deliberately small while
upgrading the original single-lane experiment to four parallel INT8 lanes.

## Hardware

- One Vector Compute Engine (VCE)
- Four SIMD8 V-Core lanes
- ADD, SUB, MUL-low, AND, XOR, unsigned MAX and MIN
- Four signed INT8 multipliers in the SA-Core
- Shared multiplier bank for V-Core MUL-low and SA-Core DOT4
- DOT4 multiply-accumulate into a signed 32-bit accumulator
- Three-stage multiply/reduce/accumulate pipeline for the 16 MHz signoff target
- ReLU and signed INT8 saturation
- Full 32-bit accumulator byte readback
- Built-in self-test using the real ADD and DOT4 datapaths
- 16 MHz implementation target, with 10 MHz as the conservative bring-up rate
- Tiny Tapeout GF180 `1x2` tile target

The project is not a complete GPU. It validates the parallel arithmetic,
command interface, physical implementation and post-silicon test strategy that
later AXION generations can build on.

## Interface

`ui_in[7:0]` carries data, `uio_in[7:0]` carries a command, and
`uo_out[7:0]` returns the selected result. Commands are sampled on a rising
clock edge while `ena` is high. Drive command `0x00` when idle.

See [ARCHITECTURE.md](ARCHITECTURE.md) for the command map and
[HARDWARE_TEST.md](HARDWARE_TEST.md) for the bring-up sequence.

## Verification

```sh
python REFERENCE_MODEL.py
cd test
make
```

GitHub Actions run RTL tests and the official Tiny Tapeout GF180 GDS,
precheck, gate-level test and viewer flow.

## Source files

- `src/project.v` — Tiny Tapeout wrapper
- `src/axion_gen0p.v` — command engine, register banks and BIST
- `src/axion_vcore_simd4.v` — four-lane SIMD ALU
- `src/axion_sa_core_dot4.v` — signed DOT4 MAC and 32-bit accumulator
- `test/test.py` — cocotb verification
- `REFERENCE_MODEL.py` — executable Python reference model

This project is licensed under Apache-2.0.
