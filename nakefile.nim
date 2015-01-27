import nake
import os

const
  CC = "i586-elf-gcc"
  asmC = "i586-elf-as"

task "clean", "Removes build files.":
  removeFile("boot.o")
  removeFile("main.bin")
  removeDir("nimcache")
  echo "Done."

task "build", "Builds the operating system.":
  echo "Compiling..."
  direShell "nim c -d:release --gcc.exe:$1 main.nim" % CC
  
  direShell asmC, "boot.s -o boot.o"
  
  echo "Linking..."
  
  direShell CC, "-T linker.ld -o main.bin -ffreestanding -O2 -nostdlib boot.o nimcache/main.o nimcache/stdlib_system.o nimcache/stdlib_unsigned.o nimcache/ioutils.o"
  
  echo "Done."
  
task "run", "Runs the operating system using QEMU.":
  if not existsFile("main.bin"): runTask("build")
  direShell "qemu-system-i386 -kernel main.bin"
