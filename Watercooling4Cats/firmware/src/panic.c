
#include <stdint.h>
#include <stm32f103rc.h>

void panic() {
    
    // Put peltier CC into safe config
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN;
    GPIOA->ODR &= ~GPIO_ODR_ODR6;
    GPIOA->CRL   &= ~ GPIO_CRL_MODE6;  // Set MODE to 00 (input)
    GPIOA->CRL   &= ~ GPIO_CRL_CNF6;    // Reset CNF to 00
    GPIOA->CRL   |=   GPIO_CRL_CNF6_0;  // Set CNF to 01, floating
    
    __DSB(); 
    
    // Prepare leds
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;
    // Set pin 5 mode to 2Mhz max output (10)
    GPIOC->CRL   &= ~ GPIO_CRL_MODE5;  // Reset MODE to 00 for pin 5
    GPIOC->CRL   |= GPIO_CRL_MODE5_1;  // Set bit 1 (result: 10)
    
    // Set to push-pull mode
    GPIOC->CRL   &= ~ GPIO_CRL_CNF5;  // Reset CNF to 00 = push-pull mode
    __DSB(); 
    
    // Signal failure with led
    while(1) {
        GPIOC->ODR |=  GPIO_ODR_ODR5;
        for(uint32_t i = 0; i < 400000000; i++);
        GPIOC->ODR &= ~GPIO_ODR_ODR5;
        for(uint32_t i = 0; i < 400000000; i++);
        GPIOC->ODR |=  GPIO_ODR_ODR5;
        for(uint32_t i = 0; i < 400000000; i++);
        GPIOC->ODR &= ~GPIO_ODR_ODR5;
        for(uint32_t i = 0; i < 4000000000; i++);
        __NOP();
    }
    
}
