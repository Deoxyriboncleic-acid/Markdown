# Principle of the simulator

### The basic concept of the c language execution environment

1. freestanding environment
2. hosted environment

### example：

```c
#include <stdint.h>
void _start() {
  volatile uint8_t *p = (uint8_t *)(uintptr_t)0x10000000;
  *p = 'A';
  while (1);
}
```

```bash
riscv64-linux-gnu-gcc -ffreestanding -nostdlib -Wl,-Ttext=0x80000000 -O2 a.c
# QEMU emulator version 5.2.0 (Debian 1:5.2+dfsg-11+deb11u2)
qemu-system-riscv64 -nographic -M virt -bios none -kernel a.out
```

- `0x10000000` is **the serial port address** of the `virt` machine model in qemu-system-riscv64

- ##### PS：the [serial port](https://en.wikipedia.org/wiki/Serial_port) address

  > The serial port address refers to **the physical location** or **number of serial communication interface or device** in the computer.
  >
  > It usually has two aspects, the **physical address** of the serial port and the **logical address** of the serial port.
  >
  > The **physical address** refers to the position or number of the serial port on the computer motherboard. It is usually directly determined by hardware devices such as the computer motherboard and CPU. Different computers or motherboards may have different physical addresses.
  >
  > The l**ogical address** refers to the address used by the application program to **communicate with the operating system and the driver program to access the serial port**. It is usually a virtual address, **allocated by the operating system**, and used to represent the serial port device. The operating system and the driver access and control the serial device through the logical address, and the application program accesses the data of the serial device through the logical address.



#### How the program ends execution？

The effect of program termination in a freestanding environment is **implementation-defined**.

In the `virt` machine model in qemu-system-riscv64, writing a special "password" to a special address can end the operation of QEMU.

```c
#include <stdint.h>
void _start() {
  volatile uint8_t *p = (uint8_t *)(uintptr_t)0x10000000;
  *p = 'A';
  volatile uint32_t *exit = (uint32_t *)(uintptr_t)0x100000;
  *exit = 0x5555; // magic number
  _start();
}
```

## Self-made a freestanding runtime environment

#### Require

- Program execution starts at address 0

- Supports two commands

  > - addi
  > - ebreak
  >
  > > - When register a0=0, output the lower 8-bit characters of register a1
  > > - When the register a0=1, the operation ends

```c
static void ebreak(long arg0, long arg1) {
  asm volatile("addi a0, x0, %0;"
               "addi a1, x0, %1;"
               "ebreak" : : "i"(arg0), "i"(arg1));
}
static void putch(char ch) { ebreak(0, ch); }
static void halt(int code) { ebreak(1, code); while (1); }

void _start() {
  putch('A');
  halt(0);
}
```

```bash
riscv64-linux-gnu-gcc -march=rv64g -ffreestanding -nostdlib -static -Wl,-Ttext=0 \
  -O2 -o prog a.c
llvm-objdump -M no-aliases -d prog
```

But how to make this program work?

- We need to implement this runtime environment

### Important: The ISA manual defines a state machine

## Instruction Set Simulator = ISA state machine implemented in C code

|                        |              program               |      abstract computer       |             CPU              |
| :--------------------: | :--------------------------------: | :--------------------------: | :--------------------------: |
|         state          |            `{<V, PC>}`             |          `{<R, M>}`          | `{sequential logic circuit}` |
| state transition rules | Semantics of C Language Statements | Semantics of the instruction | combinational logic circuit  |
|           FM           |     C Language Standard Manual     |    Instruction Set Manual    | Architecture design document |

- Realize Registers and Memory with C Language Variables
- Realize the Semantics of Instructions with C Language Statements
  - Instructions use symbolic representation -> assembly simulator
    - For example, the MIPS simulator [SPIM](https://spimsimulator.sourceforge.net/), some compilation theory course experiments will use it to run MIPS assembly code
  - Instructions are expressed in codes -> traditional (binary) instruction set simulators
    - Contains most instruction set simulators, such as QEMU, Spike, FCEUX, NEMU, etc.

### YEMU V1.0

```c
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
uint64_t R[32], PC;
uint8_t M[64] = {
  0x13, 0x05, 0x00, 0x00, 0x93, 0x05, 0x10, 0x04, 0x73, 0x00, 0x10, 0x00,
  0x13, 0x05, 0x10, 0x00, 0x93, 0x05, 0x00, 0x00, 0x73, 0x00, 0x10, 0x00,
  0x6f, 0x00, 0x00, 0x00,
};
bool halt = false;

void inst_cycle() {
  uint32_t inst = *(uint32_t *)&M[PC];
  if (((inst & 0x7f) == 0x13) && ((inst >> 12) & 0x7) == 0) { // addi
    if (((inst >> 7) & 0x1f) != 0) {
      R[(inst >> 7) & 0x1f] = R[(inst >> 15) & 0x1f] +
        (((inst >> 20) & 0x7ff) - ((inst & 0x80000000) ? 4096 : 0));
    }
  } else if (inst == 0x00100073) { // ebreak
    if (R[10] == 0) { putchar(R[11] & 0xff); }
    else if (R[10] == 1) { halt = true; }
    else { printf("Unsupported ebreak command\n"); }
  } else { printf("Unsupported instuction\n"); }
  PC += 4;
}

int main() {
  PC = 0; R[0] = 0; // can be omitted since uninitialized global variables are initialized with 0
  while (!halt) { inst_cycle(); }
  return 0;
}
```

#### PS：Specific implementation reasons RTFM

```bash
llvm-objcopy -j .text -O binary prog prog.bin
gcc -o yemu yemu.c && ./yemu prog.bin
```

