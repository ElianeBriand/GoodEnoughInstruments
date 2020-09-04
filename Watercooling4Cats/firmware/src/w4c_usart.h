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

#ifndef W4C_USART_H
#define W4C_USART_H

#include <stdint.h>

#include "FreeRTOS.h"
#include "queue.h"

#define BAUDS_FREQ_MAGIC_VALUE_SERIAL 611546
#define BAUDS_FREQ_MAGIC_VALUE_REBOOT 7077888


#include <FreeRTOS.h>
#include <task.h>

/** Setup the USART 1 peripheral
 * 
 * GPIO bank A must be initialized.
 * 
 */
extern void setup_usart_1();

/** Prepare UART for bootloader use by restoring rate
 * 
 * Necessary under some conditions (???)
 */
extern void prepare_reboot_usart_1();

// Message will be internally copied to a new buffer
extern void print_serial(char* message); 
extern void print_serial_n(char* message, size_t length); // length includes \0

// These functions take ownership of message ptr, will free afterward
extern void print_serial_heap(char* message);
extern void print_serial_heap_n(char* message, size_t length); // length includes \0

// Non blocking print: can fail if the print queue is full
#define SERIAL_PRINT_SUCCESS 0
#define SERIAL_PRINT_FAIL 1
extern int print_serial_nonblocking(char* message); 

// Immediatly print the message to the serial port. 
// Will block until send is complete
// Will preempt previously entered message (with other print_serial_* functions)
extern void print_serial_immediate(const char* message); 

extern void usart_task(void* pvParameters );

#endif // W4C_USART_H
