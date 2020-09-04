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

#include <stdint.h>
#include <stm32f103rc.h>

#include <FreeRTOS.h>
#include <task.h>

#include <highlevel_system_init.h>
#include <w4c_gpio.h>
#include <delay.h>
#include <safe_reboot.h>
#include <panic.h>
#include <w4c_usart.h>

uint32_t do_reboot = 0;

void led_blink_task(void* pvParameters );
void button_read_task(void* pvParameters );
void serial_heartbeat_task(void* pvParameters );

void main (void)
{
    
    // Non-urgent/essential system & peripheral init
    // GPIO, Systick etc
    high_level_system_init();
    
    setup_usart_1();
    
    peltier_cc_enable_setup_output();
    
    
    
    print_serial_immediate("Peripheral initialized\r\n");
    
    xTaskCreate( usart_task, 
                 "usart",
                 configMINIMAL_STACK_SIZE + 50,
                 NULL,
                 tskIDLE_PRIORITY + 2,
                 NULL );
    
    print_serial_immediate("usart_task created\r\n");
    
    xTaskCreate( button_read_task, 
                 "button_read",
                 configMINIMAL_STACK_SIZE + 10,
                 NULL,
                 tskIDLE_PRIORITY + 2,
                 NULL );
    
    print_serial_immediate("button_read_task created\r\n");
    
    xTaskCreate( led_blink_task,
                 "led_blink",
                 configMINIMAL_STACK_SIZE,
                 NULL, 
                 tskIDLE_PRIORITY + 1,
                 NULL );
    
    print_serial_immediate("led_blink_task created\r\n");
    
    
    xTaskCreate( serial_heartbeat_task,
                 "serial_heartbeat",
                 configMINIMAL_STACK_SIZE + 10,
                 NULL, 
                 tskIDLE_PRIORITY + 1,
                 NULL );
                 
    
    print_serial_immediate("Tasks created\r\n");
    print_serial_immediate("Calling vTaskStartScheduler\r\n");
    /* Start the scheduler. */
    vTaskStartScheduler();
    
    /* Will only get here if there was not enough heap space to create the
    idle task. */
    print_serial_immediate("Unexpected return from vTaskStartScheduler - panic() !\r\n");
    panic();
    return;
}




void led_blink_task(void* pvParameters ) {
    print_serial_immediate("[led_blink_task] Execution start\r\n");
    TickType_t xLastWakeTime;
    while (1) {
        
        xLastWakeTime = xTaskGetTickCount();
        led_on();
        vTaskDelayUntil( &xLastWakeTime, 500);
        
        
        xLastWakeTime = xTaskGetTickCount();
        led_off();
        vTaskDelayUntil( &xLastWakeTime, 500);
        
        print_serial_immediate("[led_blink_task] One cycle\r\n");
    }
}


void button_read_task(void* pvParameters ) {
    print_serial_immediate("[button_read_task] Execution start\r\n");
    uint8_t button_1_state, button_2_state;
    
    while (1) {
        
        button_1_state = button_1_read_state();
        button_2_state = button_2_read_state();
        
        if(button_1_state) {
            peltier_cc_enable_off();
            led_off();
            safe_reboot();
        }
        
        if(button_2_state) {
            
        }
        
        vTaskDelay(10);
    }
}



void serial_heartbeat_task(void* pvParameters ) {
    print_serial_immediate("[serial_heartbeat_task] Execution start\r\n");
    TickType_t xLastWakeTime;
    while (1) {
        xLastWakeTime = xTaskGetTickCount();
        print_serial(" -- MCU heartbeat --\r\n");
        vTaskDelayUntil( &xLastWakeTime, 2000);
    }
}
