#include <stm32f103rc.h>
#include <w4c_gpio.h>

void safe_reboot() {
    
    /* Restore conf to USART */
    
    prepare_reboot_usart_1();
    
    /* Enables GPIO bank A & put the Peltier constant current buck enable pin to
     * floating mode : as there is an external pull-down, this ensure the CC is
     * disabled during reset. (don't want it to output current while MCU is not
     * able to control it)
     */
    
    
    gpio_a_enable();
    peltier_cc_enable_setup_floating();
    
    
    NVIC_SystemReset();
    
}
