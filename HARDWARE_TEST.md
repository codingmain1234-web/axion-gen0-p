# AXION Gen0-P Hardware Test

## Bring-up

1. Start with a slow clock, assert `rst_n=0` for at least two rising edges,
   release reset, and confirm `uo_out=0`, `uio_out=0`, `uio_oe=0`.
2. Send `3E`; expect version byte `A0`.
3. Send `50`, return the command to `00`, wait three rising edges, then send
   `3D`; expect `A5`.
4. Increase the clock to 10MHz and repeat. Test 20MHz only after 10MHz passes.

## Manual vector test

Load A=`[1,2,3,4]` with commands `10`–`13`. Load B=`[5,6,7,8]` with
commands `14`–`17`. Each command carries its byte on `ui_in` and is asserted
for one rising edge.

- Send `20`, then read with `30`–`33`: expect `[6,8,10,12]`.
- Send `22`, then read with `30`–`33`: expect `[5,12,21,32]`.
- Send `40` followed by `28`, return to `00`, and wait two more rising edges:
  expect ReLU output 70.
- Read `38`–`3B`: expect `[46,00,00,00]` in hexadecimal.

## Signed and saturation tests

- Clear, load A=`[FC,0,0,0]` and B=`[02,0,0,0]`, then DOT4. ReLU must be
  `00`; accumulator bytes must be `[F8,FF,FF,FF]`, representing -8.
- Clear, load A=`[64,0,0,0]` and B=`[02,0,0,0]`, then DOT4. ReLU/saturation
  must be `7F`; accumulator bytes must represent decimal 200.

Never change supply voltage during initial bring-up. Record board and shuttle
identifiers, clock, temperature, command, input and observed output.
