
To make diskimage, just run script as the following. The script downloads required resources and builds them.
After that, you can get `initmem.bin`. Write the generated `initmem.bin` into a SD card.

```
./run.sh
```

In the script, it is assumed that RISC-V toolchain is installed at `/opt/tools/riscv`.
If you want to use your own RISC-V toolchain, such as `$HOME/tools/riscv`, run script as the following.

```
RISCV_TOOL=$HOME/tools/riscv/bin ./run.sh
```
