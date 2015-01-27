# nimkernel

This is a small 32bit (i586) kernel written using the Nim programming language.

I have been wanting to do this for a while but it wasn't until people in the #nim IRC
channel inquired about Nim OS dev and the
[rustboot](https://github.com/charliesome/rustboot) kernel inspired me that I finally did it.

It doesn't do much, but it doesn't need to. Its purpose is to provide a starting
point for anyone wishing to write an OS in Nim.

It still manages to do a little more than fill a screen with a certain color.
Nimkernel implements:

* A ``writeString`` function which shows a string on screen in a specified
  position.
* A ``rainbow`` function which shows a string with a rainbow-like text
  foreground color differentiation in a specified position.
* Some simple error handling by implementing Nim system.nim's ``panic``
  function.
* Support for 16 colors with a brilliant type safe API!

![](http://picheta.me/private/images/nimkernel2.png)

**Note**: The error at the bottom is intentional, it is used to show that
the error handling works properly.

## Setup

You are required to have:

* QEMU
* a C and asm cross-compiler for i586
* Nim from git HEAD
* nimble (*)

\* You can always grab the nake library manually from [here](https://github.com/fowlmouth/nake).

### Linux

I have performed this setup on a Arch Linux machine, but all other distros
should work too.

#### Building a cross compiler

For more information take a look at the [OSDev article](http://wiki.osdev.org/GCC_Cross-Compiler).

You will need to download the source of binutils and gcc.

First ``cd`` into a suitable directory in which you would like to download, unzip
and build the cross compiler. Then perform the following actions:

```bash
$ wget ftp://sourceware.org/pub/binutils/snapshots/binutils-2.23.52.tar.bz2
$ tar -xf binutils-2.23.52.tar.bz2
$ mkdir build 
$ ./binutils-2.23.52/configure --target=i586-elf --prefix=$PWD/build/ --disable-nls
$ make
$ make install
```

Note: I did not use the binutils suggested by the osdev article as they did
not build for me, YMMV.

You may then grab the GCC source and build it:

```bash
$ wget ftp://ftp.gnu.org/gnu/gcc/gcc-4.8.1/gcc-4.8.1.tar.bz2
$ tar -xf gcc-4.8.1.tar.bz2
$ ./gcc-4.8.1/configure --target=i586-elf --prefix=$PWD/build/ --disable-nls --enable-languages=c --without-headers
$ make all-gcc
$ make install-gcc
```

You should then have a i586-elf-gcc and i586-elf-as executable in $PWD/build/bin/ or somewhere thereabouts.
You should then add it to your PATH permanently or temporarily by doing:

```bash
export PATH=$PATH:$PWD/build/bin
```

#### Nim setup

Follow the instructions in the [Nim repo](https://github.com/Araq/nim) to bootstrap Nim and put it in your PATH.

Do the same for [nimble](https://github.com/nim-lang/nimble) and install
``nake`` by executing ``nimble install nake`` or
alternatively just save [nake](https://github.com/fowlmouth/nake/raw/master/nake.nim)
into the root dir of this repo.

You can then compile the nakefile and therefore compile nimkernel:

```bash
$ nim c nakefile
$ ./nakefile run
```

This will automatically build and run the kernel using QEMU.

## License

Nimkernel is licensed under the MIT license.

 

