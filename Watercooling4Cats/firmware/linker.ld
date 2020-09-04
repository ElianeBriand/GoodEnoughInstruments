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

/* For STM32F103RCT */

MEMORY
{
  FLASH  (rx)   : ORIGIN = 0x08000000, LENGTH = 256K
  RAM    (xrw)  : ORIGIN = 0x20000000, LENGTH = 48K
}

SECTIONS
{
    .isr_vector :
    {
        KEEP(*(.isr_vector))
    } > FLASH

    .text :
    {
        . = ALIGN(4);
        *(.text)
        *(.text*)
        *(.rodata)
        *(.rodata*)
        . = ALIGN(4);
    } > FLASH
    
    _data_flash = .;
    
    .data : AT ( _data_flash )
    {
        . = ALIGN(4);
        _data_ram_start = .;
        *(.data)
        *(.data*)
        . = ALIGN(4);
        _data_ram_end = .;
    } > RAM

    .bss :
    {
        . = ALIGN(4);
        _bss_ram_start = .;
        *(.bss)
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _bss_ram_end = .;
    } > RAM
    
    
    /* Change to this, especially downsizing, should be reflected in FreeRTOSConfig.h*/
    _heap_size = 25K; 
    _stack_size = 3K;
    
    
    /* Define symbols for stack & heap, but also allow the linker to warn if not 
       enough RAM to fit .data, .bss, stack and heap with given sizes. */
    .heap_stack :
    {
        . = ALIGN(8);
        _heap_begin = .;
        . = . + _heap_size;
        _heap_end = .;
        . = . + 8; /* Some (theoretically) unecessary leeway */
        . = ALIGN(8);
        _stack_begin = .;
        . = . + _stack_size;
        _stack_end = .;
        . = ALIGN(8);
    } > RAM
    
    /* Alias for FreeRTOS */
    ucHeap = _heap_begin;
    
    
}

ENTRY(reset_routine); /* defined in crt_stm32f103rc.s */
