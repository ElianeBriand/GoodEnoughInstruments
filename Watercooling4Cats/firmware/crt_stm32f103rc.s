/*
    This file is part of the watercooling4cat firmware.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/ 

.syntax unified
.cpu cortex-m3
.fpu softvfp
.thumb

/* *********** Segment adresses ***********
    Defined in linker script
*/

/* Start adress of the .data section in the flash (initial value of the data segment) */
.word  _data_flash

/* Start adress of the .data section in the RAM (where the data segment will reside at runtime) */  
.word  _data_ram_start
/* End adress of the .data section in the RAM (where the data segment will reside at runtime) */
.word  _data_ram_end


/* Start adress of the .bss section in the RAM */  
.word  _bss_ram_start
/* End adress of the .bss section in the RAM */  
.word  _bss_ram_end


/*    *********** Reset handler ***********

    Entry point as defined in the linker script.
    
    - Copy .data segment from flash to RAM 
    - Zero-initialize .bss segment
    - Call stm32f103rc_system_init to perform the rest of the init in C
    - Call main
    - Loop forever if main returns

*/
.section  .text.reset_routine
    .weak  reset_routine
    .type  reset_routine, %function
reset_routine:
    /* This is unnecessary *except* when jumping to here w/ debuggers*/
    ldr  sp, = _stack_end 
    
    movs  r1, #0
    b  copy_data_seg_loop

copy_data_piece:
    ldr  r3, =_data_flash
    ldr  r3, [r3, r1]
    str  r3, [r0, r1]
    adds  r1, r1, #4
    
copy_data_seg_loop:
    ldr  r0, =_data_ram_start
    ldr  r3, =_data_ram_end
    adds  r2, r0, r1
    cmp  r2, r3
    bcc  copy_data_piece
    ldr  r2, =_bss_ram_start
    b  zeroes_bss_seg_loop

zeroes_bss_piece:
    movs  r3, #0
    str  r3, [r2], #4
  
zeroes_bss_seg_loop:
    ldr  r3, = _bss_ram_end
    cmp  r2, r3
    bcc  zeroes_bss_piece
    
    bl  stm32f103rc_system_init    /* jump to the system init C routine in deps/system_stm32f103rc.c */
    bl  main                       /* jump to main in main.c */
    /* If this returns, loop forever */
inf_loop_reset_routine:
    b  inf_loop_reset_routine
    
.size  reset_routine, .-reset_routine


/*    *********** Default interrupt handler ***********

    Just loops forever

*/

.section  .text.default_isr_handler,"ax",%progbits
default_isr_handler:
default_isr_handler_inf_loop:
  b  default_isr_handler_inf_loop

.size  default_isr_handler, .-default_isr_handler


/*   *********** Minimal ISR table ***********
     Mix of cortex M3 interrupt & stm32f103rc specific.
     Description taken from the reference manual
*/


/* Apparently this is needed for boot in RAM mode for STM32F10x High Density devices ??
    (" @0x1E0. This is for boot in RAM mode for STM32F10x High Density devices.") */
.equ  BootRAM,        0xF1E0F85F 

.section  .isr_vector,"a",%progbits
  .type  min_isr_table, %object
  .size  min_isr_table, .-min_isr_table
min_isr_table:
  .word  _stack_end                     /* 0x0000_0000 | Reserved */
  .word  reset_routine                  /* 0x0000_0004 | Reset */
  .word  isr_nmi                        /* 0x0000_0008 | Non-maskable interrupt */
  .word  isr_hard_fault                 /* 0x0000_000C | "All class of fault" */
  .word  isr_mem_mgmt                   /* 0x0000_0010 | Memory managment */
  .word  isr_bus_fault                  /* 0x0000_0014 | Prefetch fault, memory access fault */
  .word  isr_usage_fault                /* 0x0000_0018 | Undefined instruction or illegal state */
  .word  0                              /* 0x0000_001C | Reserved */
  .word  0                              /* 0x0000_0020 | Reserved */
  .word  0                              /* 0x0000_0024 | Reserved */
  .word  0                              /* 0x0000_0028 | Reserved */
  .word  vPortSVCHandler  /*FreeRTOS*/  /* 0x0000_002C | System service call via SWI instruction (SoftWare Interrupt) */
  .word  isr_debug_monitor              /* 0x0000_0030 | Debug monitor */
  .word  0                              /* 0x0000_0034 | Reserved */
  .word  xPortPendSVHandler /*FreeRTOS*//* 0x0000_0038 | Pendable request for system service */
  .word  xPortSysTickHandler            /* 0x0000_003C | System tick timer */
  .word  isr_window_watchdog            /* 0x0000_0040 | Window watchdog */
  .word  0                              /* 0x0000_0044 | PVD through EXTI line (Programmable Voltage Detector, EXTernal Interrupt)*/
  .word  0                              /* 0x0000_0048 | Tamper */
  .word  isr_rtc_global                 /* 0x0000_004C | RTC global (Real Time Clock) */
  .word  isr_flash_global               /* 0x0000_0050 | Flash global */
  .word  isr_rcc_global                 /* 0x0000_0054 | RCC global (Reset and Clock Controller) */
  .word  isr_exti_0                     /* 0x0000_0058 | EXTI line 0 (EXTernal Interrupt) */
  .word  isr_exti_1                     /* 0x0000_005C | EXTI line 1 (EXTernal Interrupt) */
  .word  isr_exti_2                     /* 0x0000_0060 | EXTI line 2 (EXTernal Interrupt) */
  .word  isr_exti_3                     /* 0x0000_0064 | EXTI line 3 (EXTernal Interrupt) */
  .word  isr_exti_4                     /* 0x0000_0068 | EXTI line 4 (EXTernal Interrupt) */
  .word  isr_dma_1_ch1_global           /* 0x0000_006C | DMA 1 Channel 1 global (Direct Memory Access) */
  .word  isr_dma_1_ch2_global           /* 0x0000_0070 | DMA 1 Channel 2 global (Direct Memory Access) */
  .word  isr_dma_1_ch3_global           /* 0x0000_0074 | DMA 1 Channel 3 global (Direct Memory Access) */
  .word  isr_dma_1_ch4_global           /* 0x0000_0078 | DMA 1 Channel 4 global (Direct Memory Access) */
  .word  isr_dma_1_ch5_global           /* 0x0000_007C | DMA 1 Channel 5 global (Direct Memory Access) */
  .word  isr_dma_1_ch6_global           /* 0x0000_0080 | DMA 1 Channel 6 global (Direct Memory Access) */
  .word  isr_dma_1_ch7_global           /* 0x0000_0084 | DMA 1 Channel 7 global (Direct Memory Access) */
  .word  isr_adc_1_2                    /* 0x0000_0088 | ADC 1 & ADC2 global */
  .word  0                              /* 0x0000_008C | USB High Priority or CAN TX interrupts */
  .word  0                              /* 0x0000_0090 | USB Low Priority or CAN RX0 interrupts */
  .word  0                              /* 0x0000_0094 | CAN RX1 interrupt */
  .word  0                              /* 0x0000_0098 | CAN SCE interrupt */
  .word  isr_exti_9_5                   /* 0x0000_009C | EXTI line 9 -> 5 */
  .word  isr_tim1_break                 /* 0x0000_00A0 | TIM1 break */
  .word  isr_tim1_update                /* 0x0000_00A4 | TIM1 update */
  .word  isr_tim1_trig_comm             /* 0x0000_00A8 | TIM1 trigger & commutation */
  .word  isr_tim1_capt_comp             /* 0x0000_00AC | TIM1 Capture Compare */
  .word  isr_tim2_global                /* 0x0000_00B0 | TIM2 global */
  .word  isr_tim3_global                /* 0x0000_00B4 | TIM3 global */
  .word  isr_tim4_global                /* 0x0000_00B8 | TIM4 global */
  .word  isr_i2c_1_ev                   /* 0x0000_00BC | I2C 1 event */
  .word  isr_i2c_1_err                  /* 0x0000_00C0 | I2C 1 error */
  .word  isr_i2c_2_ev                   /* 0x0000_00C4 | I2C 2 event */
  .word  isr_i2c_2_err                  /* 0x0000_00C8 | I2C 2 error */
  .word  isr_spi_1_global               /* 0x0000_00CC | SPI 1 global */
  .word  isr_spi_2_global               /* 0x0000_00D0 | SPI 2 global */
  .word  isr_usart_1_global             /* 0x0000_00D4 | USART 1 global */
  .word  isr_usart_2_global             /* 0x0000_00D8 | USART 2 global */
  .word  isr_usart_3_global             /* 0x0000_00DC | USART 3 global */
  .word  isr_exti_10_to_15_global       /* 0x0000_0XE0 | EXTI line 10 to 15 globam */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  0                              /* 0x0000_0XXX | TODO: complete using reference manual (circa pg 205) */
  .word  BootRAM   

  
/* Aliasing the handler in the table to the default handler with weak symbols
     -> defining these symbol elsewhere (like in C code) will allow to replace this default handler
*/

.weak  isr_nmi
.thumb_set isr_nmi, default_isr_handler

.weak  isr_hard_fault
.thumb_set isr_hard_fault, default_isr_handler

.weak  isr_mem_mgmt
.thumb_set isr_mem_mgmt, default_isr_handler

.weak  isr_bus_fault
.thumb_set isr_bus_fault, default_isr_handler

.weak  isr_usage_fault
.thumb_set isr_usage_fault, default_isr_handler

.weak  isr_svc
.thumb_set isr_svc, default_isr_handler

.weak  isr_debug_monitor
.thumb_set isr_debug_monitor, default_isr_handler

.weak  isr_pendsv
.thumb_set isr_pendsv, default_isr_handler

.weak  isr_systick
.thumb_set isr_systick, default_isr_handler

.weak  isr_window_watchdog
.thumb_set isr_window_watchdog, default_isr_handler

.weak  isr_rtc_global
.thumb_set isr_rtc_global, default_isr_handler
            
.weak  isr_flash_global
.thumb_set isr_flash_global, default_isr_handler

.weak  isr_rcc_global
.thumb_set isr_rcc_global, default_isr_handler

.weak  isr_exti_0
.thumb_set isr_exti_0, default_isr_handler

.weak  isr_exti_1
.thumb_set isr_exti_1, default_isr_handler

.weak  isr_exti_2
.thumb_set isr_exti_2, default_isr_handler

.weak  isr_exti_3
.thumb_set isr_exti_3, default_isr_handler

.weak  isr_exti_4
.thumb_set isr_exti_4, default_isr_handler

.weak  isr_dma_1_ch1_global
.thumb_set isr_dma_1_ch1_global, default_isr_handler

.weak  isr_dma_1_ch2_global
.thumb_set isr_dma_1_ch2_global, default_isr_handler

.weak  isr_dma_1_ch3_global
.thumb_set isr_dma_1_ch3_global, default_isr_handler

.weak  isr_dma_1_ch4_global
.thumb_set isr_dma_1_ch4_global, default_isr_handler

.weak  isr_dma_1_ch5_global
.thumb_set isr_dma_1_ch5_global, default_isr_handler

.weak  isr_dma_1_ch6_global
.thumb_set isr_dma_1_ch6_global, default_isr_handler

.weak  isr_dma_1_ch7_global
.thumb_set isr_dma_1_ch7_global, default_isr_handler

.weak  isr_adc_1_2
.thumb_set isr_adc_1_2, default_isr_handler

.weak  isr_exti_9_5
.thumb_set v, default_isr_handler

.weak  isr_tim1_break
.thumb_set isr_tim1_break, default_isr_handler

.weak  isr_tim1_update
.thumb_set isr_tim1_update, default_isr_handler

.weak  isr_tim1_trig_comm
.thumb_set isr_tim1_trig_comm, default_isr_handler

.weak  isr_tim1_capt_comp
.thumb_set isr_tim1_capt_comp, default_isr_handler

.weak  isr_tim2_global
.thumb_set isr_tim2_global, default_isr_handler

.weak  isr_tim3_global
.thumb_set isr_tim3_global, default_isr_handler

.weak  isr_tim4_global
.thumb_set isr_tim4_global, default_isr_handler

.weak  isr_i2c_1_ev
.thumb_set isr_i2c_1_ev, default_isr_handler

.weak  isr_i2c_1_err
.thumb_set isr_i2c_1_err, default_isr_handler

.weak  isr_i2c_2_ev
.thumb_set isr_i2c_2_ev, default_isr_handler

.weak  isr_i2c_2_err
.thumb_set isr_i2c_2_err, default_isr_handler

.weak  isr_spi_1_global
.thumb_set isr_spi_1_global, default_isr_handler

.weak  isr_spi_2_global
.thumb_set isr_spi_2_global, default_isr_handler

.weak  isr_usart_1_global
.thumb_set isr_usart_1_global, default_isr_handler

.weak  isr_usart_2_global
.thumb_set isr_usart_2_global, default_isr_handler

.weak  isr_usart_3_global
.thumb_set isr_usart_3_global, default_isr_handler

.weak  isr_exti_10_to_15_global
.thumb_set isr_exti_10_to_15_global, default_isr_handler

