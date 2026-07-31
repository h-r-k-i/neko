# An Operating System That Definitely Is Not Named Neko Trust Me I Would Never Do That

so basically what I did was take code from OSDev, add some ✨️razzle dazzle✨️ to make it my own (read: shit), only got all the way to a bootloader, and called it an entire OS.

![](https://media1.tenor.com/m/SmipoZPWb1AAAAAd/and-then-he-clicked-post.gif)

## Getting Started

I'm just gonna copy the format from my other README files because that works so why not do that too?

### Prerequisites

- Realistically speaking device-wise you only need a computer that can run QEMU but if you want to torment yourself like that then you need a 64-bit CPU and a motherboard that supports LBA indexing (most modern ones do). From early tests this OS can run itself off of a USB drive but I will not be testing past the bootloader stage because xHCI is... hard. And deeply scares me. It's recommended to use QEMU, although any emulator that supports 64-bit x86 should work (if you don't use QEMU God help you).
- Due to the nature of OSes you will need a cross-compiler to build the OS. If you don't know how to build a cross-compiler, search up "osdev xcc" and if that doesn't show anything "osdev cross compiler." It is not that hard; it just takes a while.
- Speaking of compilers, you specifically need a C compiler that can compile for 32-bit and 64-bit x86. I use GCC here. You will also need NASM and ld for linking. This isn't a hard requirement; just do `sudo apt install nasm`. NASM doesn't even need to be cross-compiled.
- You will need Make because God has abandoned us.

### Building
```bash

# clone repo
git clone https://github.com/h-r-k-i/neko.git
cd neko

# Build the "OS" (aka just the bootloader) (we'll add the kernel later) (and by we, I mean me)
make
```

### Running
```bash

# Run the OS in QEMU
make run

# If it works you'll see the text
# "test from neko kernel_main(). if this is shown, we are in neko 64-bit kernel space"
# on a black screen.
# If it doesn't work, God help you.
```

### Usage Example

uhhhhhh

give me a moment to set up a webserver so I can host an image of the OS booting. It should not take that long im just stupid

## Notes

what is there to say about it? It's a bad bootloader

## References

insert link to osdev and that one cornell page about writing a bootloader in C and i think also the intel manual

## License

This project is licensed under the [MIT License](LICENSE) but frankly why would you want to use this shit?

## Acknowledgements

this is bad and ahh and shid and crap and dookie