# AXION Gen0-P Architecture

## Datapath

The design stores four unsigned/raw input bytes in each of the A and B banks.
The V-Core treats them as unsigned SIMD8 values. The SA-Core interprets the
same bytes as signed two's-complement INT8 values.

```text
A0..A3 ─> 4 shared signed multipliers ─┬─> low bytes ─> SIMD MUL result
B0..B3 ────────────────────────────────┴─> adder tree ─> pipeline register
                                                        └─> 32-bit accumulator
                                                            └─> ReLU/saturate
```

The four multipliers are physically shared by V-Core MUL-low and SA-Core
DOT4. DOT4 uses a one-stage registered sum before accumulation, preserving a
one-result-per-clock pipeline throughput while shortening the critical path.

## Command map

| Command | Function |
|---:|---|
| `00` | NOP / idle |
| `10`–`13` | Load `ui_in` into A lane 0–3 |
| `14`–`17` | Load `ui_in` into B lane 0–3 |
| `20` | Vector ADD |
| `21` | Vector SUB |
| `22` | Vector MUL, low eight bits per lane |
| `23` | Vector AND |
| `24` | Vector XOR |
| `25` | Vector unsigned MAX |
| `26` | Vector unsigned MIN |
| `28` | Signed DOT4 MAC |
| `30`–`33` | Select vector result lane 0–3 |
| `38`–`3B` | Select accumulator byte 0–3, little endian |
| `3C` | Select ReLU/saturated accumulator output |
| `3D` | Select BIST status |
| `3E` | Select version byte (`A0`) |
| `40` | Clear accumulator |
| `50` | Start built-in self-test |

All state-changing commands are sampled on a rising clock edge when `ena=1`.
The selected output remains visible after the command returns to zero.

## Built-in self-test

Command `50` loads A=`[1,2,3,4]` and B=`[5,6,7,8]`, clears the accumulator,
then performs ADD and DOT4 through the normal datapaths. Status values are:

- `00`: not run
- `01`: busy
- `A5`: pass
- `5A`: fail
