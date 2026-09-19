# AXION Gen0-P verified build

AXION Gen0-P v0.3 was verified on 2026-09-19 with the official Tiny Tapeout
TTGF26c/GF180 flow. The verified design commit is `5adb9a4`.

## Automation results

| Check | Result |
|---|---:|
| RTL cocotb | Pass |
| GDS build | Pass |
| Gate-level cocotb | Pass |
| Tiny Tapeout precheck | Pass |
| GDS viewer/render | Pass / inspected |
| Routing DRC | 0 errors |
| Magic DRC | 0 errors |
| LVS | 0 errors; netlists match |
| Antenna | 0 violations |

- RTL run: <https://github.com/codingmain1234-web/axion-gen0-p/actions/runs/35423530578>
- GDS/precheck/gate-level/viewer run: <https://github.com/codingmain1234-web/axion-gen0-p/actions/runs/35423530614>
- Interactive GDS viewer: <https://codingmain1234-web.github.io/axion-gen0-p/>

## Physical and timing results

| Metric | Result |
|---|---:|
| Process / target | GF180MCU / Tiny Tapeout TTGF26c |
| Tile allocation | `1x2` |
| Die bounding box | 346.64 × 325.36 µm |
| Die area | 112,783 µm² (0.112783 mm²) |
| Synthesized logic area | 72,514.0416 µm² |
| Placed standard cells | 4,664 |
| Final standard-cell area | 94,703.1 µm² |
| Final utilization | 87.7438% |
| Signoff clock | 16 MHz (62.5 ns) |
| Worst setup slack | +3.1570 ns |
| Setup WNS / TNS / violations | 0 ns / 0 ns / 0 |
| Worst hold slack | +0.4936 ns |
| Hold WNS / TNS / violations | 0 ns / 0 ns / 0 |
| Estimated total power | 2.032 mW |
| Final GDS size | 5,528,314 bytes |

Power is an implementation-flow estimate, not a post-silicon measurement.
The 20 MHz configuration was not signoff-clean at the slow 125°C corner, so
16 MHz is the guaranteed implementation target; 20 MHz remains optional lab
characterization only.

This verification produces a fabrication-ready candidate, but it does not
place or pay for a Tiny Tapeout manufacturing order.
