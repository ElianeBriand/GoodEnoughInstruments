

#include <stdint.h>
#include <stm32f103rc.h>


void setup_i2c_1() {
    // Enable clock to i2c 1
    RCC->APB1ENR |= RCC_APB1ENR_I2C1EN;
    
    
    
}
