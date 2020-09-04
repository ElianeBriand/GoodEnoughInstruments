
#include <stdint.h>

#include <stm32f103rc.h>
#include <system_stm32f103rc.h>
#include <core_cm3.h>

#include <w4c_gpio.h>


void high_level_system_init() {
    
    
    gpio_c_enable();
    led_setup_gpio();
    led_off();
    
    gpio_a_enable();
    button_1_setup_gpio();
    
    gpio_b_enable();
    
}
