.syntax unified
.cpu cortex-m3
.thumb

.data
var1:
    .space 4 @ Reserve 4 bytes for memory block “var1”
var2:
    .space 1 @ Reserve 1 byte for memory block “var2”

.text
.type Reset_Handler, %function
.global Reset_Handler
Reset_Handler:
@BASE 0x4002 1000 - 0x4002 13FF Reset and clock control RCC
@BASE 0x4001 1000 - 0x4001 13FF GPIO Port C

@nop do nothing
@ldr r0, =0x00000010 @load GPIOC clk enable, bit IOPCEN 4 GPIOC
@ldr r1, =0x40021018 @load RCC base address + RCC offset 0x18, @ Set IOPAEN bit in RCC_APB2ENR to 1 to enable GPIOC
@str r0, [r1] @enable GPIOC clock
.equ RCC_APB2ENR, 0x40021018
RCC_APB2ENR_IOPCEN = 16 @IO port C clock enable, 16
ldr r1, =RCC_APB2ENR
ldr r0, [r1]
orr r0, r0, RCC_APB2ENR_IOPCEN
str r0, [r1]

@ldr r0, =0x44244444 @push-pull and output 2Mhz, Reset value: 0x4444 4444
@ldr r1, =0x40011004 @0x4001 1000 GPIO Port C + offset 0x04 GPIOx_CRH
@str r0, [r1]

ldr r1, =0x40011004 @0x4001 1000 GPIO Port C + offset 0x04 GPIOx_CRH
ldr r0, [r1]
ldr r2, =0xFF0FFFFF @and mask
and r0, r2
ldr r2, =0x00200000 @or mask 
orr r0, r2
str r0, [r1]

@GPIOx_ODR Address offset: 0x0C Reset value: 0x0000 0000
@ldr r0, =0x00000000 @ low output ODR13 LED, on bluepill should be low
@ldr r1, =0x4001100C
@str r0, [r1] @ turn on LED

blinkLoop:

@Port bit set/reset register (GPIOx_BSRR) Address offset: 0x10
ldr r1, =0x40011010
ldr r0, =0x20000000  @ reset 29-th bit, pc13 out to 0, led on
str r0, [r1]

ldr r2, =0x100000
delay:
subs r2, #1
bne delay

@Port bit set/reset register (GPIOx_BSRR) Address offset: 0x10
ldr r0, =0x00002000  @ set 13-th bit, pc13 out to 1, led off
str r0, [r1]

ldr r2, =0x100000
delay2:
subs r2, #1
bne delay2

b blinkLoop
@b . @endless loop


