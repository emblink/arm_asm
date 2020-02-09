_stack_base = 0x20005000;

MEMORY
{
   FLASH (rx) : ORIGIN = 0x8000000, LENGTH = 0x10000
   RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 0x5000
}

SECTIONS
{
    .vectors : { KEEP(*(.vectors*)) } > FLASH
    .text : { *(.text*) } > FLASH
    .data : { *(data*) } > FLASH
    .bss : { *(bss*) } > RAM
}