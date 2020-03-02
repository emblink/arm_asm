.syntax unified
.cpu cortex-m3
.thumb

.section .VectorTable, "a" @ a means that linker must reserve space for this section
.word _StackEnd
.word Reset_Handler
.space 0xe4
