#include "FreeRTOS.h"
#include "task.h"

#include <panic.h>

void vApplicationStackOverflowHook( TaskHandle_t xTask,
                                    signed char *pcTaskName ) {
    print_serial_immediate("PANIC: Application stack overflow !\r\n");
    panic();
} 

void vAssertCalled(const char* file, const int line )    {
    static char assert_buffer[25];
    assert_buffer[0] = '-';
    assert_buffer[0] = 0;
    sprintf(assert_buffer, "%d", line);
    print_serial_immediate("PANIC: Assertion failed in ");
    print_serial_immediate(file);
    print_serial_immediate(" at line ");
    print_serial_immediate(assert_buffer);
    print_serial_immediate("\r\n");
    panic();
}


void vApplicationMallocFailedHook() {
    print_serial_immediate("PANIC: malloc failed !\r\n");
    panic();
}
