.cpu cortex-m3
.thumb

.global default_handler
/**
 * @brief  This is the code that gets called when the processor receives an 
 *         unexpected interrupt. This simply enters an infinite loop, preserving
 *         the system state for examination by a debugger.
 * @param  None     
 * @retval None       
*/
.section .text.default_handler,"ax",%progbits
default_handler:
Infinite_Loop:
  b  Infinite_Loop
  .size  default_handler, .-default_handler

.section .vectors

.word _stack_base
.word main
.word default_handler
.word default_handler

.end
