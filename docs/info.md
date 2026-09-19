## How it works

AXION Gen0-P contains a four-lane SIMD V-Core and a four-lane signed INT8
SA-Core. Four A bytes and four B bytes are loaded through the eight-bit input
port. A vector command performs the selected operation on all four lanes in
parallel. A DOT4 command calculates `A0*B0 + A1*B1 + A2*B2 + A3*B3` and adds
the result to a signed 32-bit accumulator.

The normal AI output applies ReLU and saturates positive values to 127. The
full accumulator remains available as four individually selectable bytes. The
built-in self-test loads `[1,2,3,4]` and `[5,6,7,8]`, checks vector addition
and verifies that DOT4 produces 70 through the real datapaths.

## How to test

Apply active-low reset for at least two rising clock edges and then release it.
Commands are sampled on rising edges; return `uio_in` to `0x00` between
commands.

1. Send commands `0x10` through `0x13` with data 1, 2, 3 and 4.
2. Send commands `0x14` through `0x17` with data 5, 6, 7 and 8.
3. Send `0x20` for vector ADD.
4. Send `0x30` through `0x33`; the outputs must be 6, 8, 10 and 12.
5. Send `0x40` to clear the accumulator and `0x28` for DOT4 MAC.
6. The ReLU output must be 70. Commands `0x38` through `0x3b` must read
   accumulator bytes `0x46, 0x00, 0x00, 0x00`.
7. Send `0x50`, wait two more rising edges, then send `0x3d`. Output `0xa5`
   means the built-in self-test passed.

Start first-silicon testing at a slow clock and move to 10 MHz after basic
operation is confirmed. The implementation target is 20 MHz.

## External hardware

No external hardware is required beyond the Tiny Tapeout demo and breakout
boards and a USB-connected host running Tiny Tapeout Commander.
