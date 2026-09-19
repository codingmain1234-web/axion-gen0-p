# AXION Gen0-P RTL tests

The cocotb suite checks reset and version reporting, all seven SIMD operations,
signed DOT4 accumulation, ReLU/saturation, full accumulator readback, `ena`
state freezing, deterministic random vectors and the built-in self-test.

Run it from this directory with:

```sh
make clean
make
```

Icarus Verilog and the packages in `requirements.txt` are required. The same
suite is also run by `.github/workflows/test.yaml`.
