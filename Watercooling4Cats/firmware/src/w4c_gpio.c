#include <stdint.h>
#include <stm32f103rc.h>




/** Enable IO bank A */
void gpio_a_enable() {
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
}

/** Enable IO bank B */
void gpio_b_enable() {
    RCC->APB2ENR |= RCC_APB2ENR_IOPBEN;
}

/** Enable IO bank C */
void gpio_c_enable() {
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
}

/** Setup button 1 gpio */
void button_1_setup_gpio() {
    // Set pin 11 mode to input
    GPIOA->CRH   &= ~ GPIO_CRH_MODE11;  // Set MODE to 00 (input)
    
    // Set to floating input (external pull down on button)
    GPIOA->CRH   &= ~ GPIO_CRH_CNF11;  // Reset CNF to 00
    GPIOA->CRH   |= GPIO_CRH_CNF11_0;  // Set CNF to 01, floating
    
    GPIOA->ODR &= ~GPIO_ODR_ODR11;
}

/** Read button 1 gpio */
uint8_t button_1_read_state() {
    if((GPIOA->IDR & GPIO_IDR_IDR11)) {
        return 1;
    } else {
        return 0;
    }
}

/** Setup button 2 gpio */
void button_2_setup_gpio() {
    // Set pin 1 mode to input
    GPIOB->CRH   &= ~ GPIO_CRL_MODE0;  // Set MODE to 00 (input)
    
    // Set to floating input (external pull down on button)
    GPIOB->CRH   &= ~ GPIO_CRL_CNF0;  // Reset CNF to 00
    GPIOB->CRH   |= GPIO_CRL_CNF0_0;  // Set CNF to 01, floating
    
    GPIOB->ODR &= ~GPIO_ODR_ODR0;
}

/** Read button 2 gpio */
uint8_t button_2_read_state() {
    if((GPIOB->IDR & GPIO_IDR_IDR0)) {
        return 1;
    } else {
        return 0;
    }
}


/** Setup LED gpio */
void led_setup_gpio() {
    // Set pin 5 mode to 2Mhz max output (10)
    GPIOC->CRL   &= ~ GPIO_CRL_MODE5;  // Reset MODE to 00 for pin 5
    GPIOC->CRL   |= GPIO_CRL_MODE5_1;  // Set bit 1 (result: 10)
    
    // Set to push-pull mode
    GPIOC->CRL   &= ~ GPIO_CRL_CNF5;  // Reset CNF to 00 = push-pull mode
}


/** Set LED on */
void led_on() {
    GPIOC->ODR |=  GPIO_ODR_ODR5;
}

/** Set LED off */
void led_off() {
    GPIOC->ODR &= ~GPIO_ODR_ODR5;
}


/** Put Peltier CC enable pin in floating mode */
void peltier_cc_enable_setup_floating() {
    /* For safety, put a zero in ODR for pin 6 such that if its in output mode,
     * its pulled down (whether push_pull or open-drain)), or in input mode with
     * pull-up/pull-down, the pull-down is activated
     * */
    GPIOA->ODR &= ~GPIO_ODR_ODR6;
    
    // Set pin 6 mode to input
    GPIOA->CRL   &= ~ GPIO_CRL_MODE6;  // Set MODE to 00 (input)
    
    // Set to floating input (external pull down)
    GPIOA->CRL   &= ~ GPIO_CRL_CNF6;    // Reset CNF to 00
    GPIOA->CRL   |=   GPIO_CRL_CNF6_0;  // Set CNF to 01, floating
}

/** Put Peltier CC enable pin in output mode, push-pull, with value 0 initially set*/
void peltier_cc_enable_setup_output() {
    /* For safety, put a zero in ODR for pin 6 such that it starts pulled down.
     * */
    GPIOA->ODR &= ~GPIO_ODR_ODR6;
    
    // Set pin 6 mode to input
    GPIOA->CRL   &= ~ GPIO_CRL_MODE6;  // Set MODE to 00 (input)
    
    // Set pin 6 mode to output, max 10 Mhz
    GPIOA->CRL   |= GPIO_CRL_MODE6_0;  // Set bit 0 (result: 01)
    
    // Set CNF to push-pull
    GPIOA->CRL   &= ~ GPIO_CRL_CNF6;  // Set 00 in CNF for pin 6, enabling push-pull
    
    // Re-set pin 6 to low, just in case
    GPIOA->ODR &= ~GPIO_ODR_ODR6;
}

/** Set the Peltier CC enable pin to high: this turns on the peltier CC*/
void peltier_cc_enable_on() {
    GPIOA->ODR |=  GPIO_ODR_ODR6;
}

/** Set the Peltier CC enable pin to low: this turns off the peltier CC */
void peltier_cc_enable_off() {
    GPIOA->ODR &= ~GPIO_ODR_ODR6;
}
