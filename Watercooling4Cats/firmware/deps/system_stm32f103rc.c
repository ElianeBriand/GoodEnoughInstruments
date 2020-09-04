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


/*
 This file contain the definition of the system init and clock update
 Inspired from STMicro provided file, this supports only the 72 Mhz clock mode
 supported by the STM32F103RC
*/

#include <stdint.h>
#include <stm32f103rc.h>
#include <core_cm3.h>

#include <stm32f1xx_ll_rcc.h>

#define VECT_TAB_OFFSET  0x0

#define SYSCLK_FREQ_8MHz  8000000
#define SYSCLK_FREQ_64MHz  64000000
#define SYSCLK_FREQ_72MHz  72000000

uint32_t SystemCoreClock = SYSCLK_FREQ_8MHz;
const uint8_t AHBPrescTable[16U] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 6, 7, 8, 9};
const uint8_t APBPrescTable[8U] =  {0, 0, 0, 0, 1, 2, 3, 4};

static void SetSysClock(void);

#if !defined  (HSE_VALUE) 
  #define HSE_VALUE               8000000U /*!< Default value of the External oscillator in Hz.
                                                This value can be provided and adapted by the user application. */
#endif /* HSE_VALUE */

#if !defined  (HSI_VALUE)
  #define HSI_VALUE               8000000U /*!< Default value of the Internal oscillator in Hz.
                                                This value can be provided and adapted by the user application. */
#endif /* HSI_VALUE */

  

/**
  * @brief  Update SystemCoreClock variable according to Clock Register Values.
  *         The SystemCoreClock variable contains the core clock (HCLK), it can
  *         be used by the user application to setup the SysTick timer or configure
  *         other parameters.
  *           
  * @note   Each time the core clock (HCLK) changes, this function must be called
  *         to update SystemCoreClock variable value. Otherwise, any configuration
  *         based on this variable will be incorrect.         
  *     
  * @note   - The system frequency computed by this function is not the real 
  *           frequency in the chip. It is calculated based on the predefined 
  *           constant and the selected clock source:
  *             
  *           - If SYSCLK source is HSI, SystemCoreClock will contain the HSI_VALUE(*)
  *                                              
  *           - If SYSCLK source is HSE, SystemCoreClock will contain the HSE_VALUE(**)
  *                          
  *           - If SYSCLK source is PLL, SystemCoreClock will contain the HSE_VALUE(**) 
  *             or HSI_VALUE(*) multiplied by the PLL factors.
  *         
  *         (*) HSI_VALUE is a constant defined in stm32f1xx.h file (default value
  *             8 MHz) but the real value may vary depending on the variations
  *             in voltage and temperature.   
  *    
  *         (**) HSE_VALUE is a constant defined in stm32f1xx.h file (default value
  *              8 MHz or 25 MHz, depending on the product used), user has to ensure
  *              that HSE_VALUE is same as the real frequency of the crystal used.
  *              Otherwise, this function may have wrong result.
  *                
  *         - The result of this function could be not correct when using fractional
  *           value for HSE crystal.
  * @param  None
  * @retval None
  */


void stm32f103rc_system_init() {
    
    // //// First reset to known state
    // in case config is garbled (hot reset ?) 
   
    //LL_RCC_DeInit();
    
    
    
    
    // Point the NVIC to the interrupt table
    SCB->VTOR = FLASH_BASE | VECT_TAB_OFFSET;
    NVIC_SetPriorityGrouping( 4 );
    
    __disable_irq();
    
    // LL_RCC_HSI_Enable(); --> If it was not on, this would not run
    LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_HSI);
    LL_RCC_HSE_Disable();
    LL_RCC_PLL_Disable();
    //LL_RCC_LSI_Enable();
    
    LL_RCC_SetAHBPrescaler(LL_RCC_SYSCLK_DIV_1);
    LL_RCC_SetAPB2Prescaler(LL_RCC_APB2_DIV_1);
    LL_RCC_SetAPB1Prescaler(LL_RCC_APB2_DIV_2);
    LL_RCC_ConfigMCO(LL_RCC_MCO1SOURCE_NOCLOCK);
    LL_RCC_SetADCClockSource(LL_RCC_ADC_CLKSRC_PCLK2_DIV_8);
    
    LL_RCC_PLL_ConfigDomain_SYS(LL_RCC_PLLSOURCE_HSI_DIV_2, LL_RCC_PLL_MUL_10);
    LL_RCC_PLL_Enable();
    
    //while(!LL_RCC_LSI_IsReady());
    //LL_RCC_SetRTCClockSource(LL_RCC_RTC_CLKSOURCE_LSI);
    //LL_RCC_EnableRTC();
    
    while(!LL_RCC_PLL_IsReady());
    LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_PLL);
    
    while(LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_PLL);
    
    /* Disable all interrupts */
    //LL_RCC_WriteReg(CIR, 0x00000000U);

    /* Clear reset flags */
    //LL_RCC_ClearResetFlags();
    
    NVIC_SetPriority (SysTick_IRQn, 0x80);
    NVIC_SetPriority (SVCall_IRQn, 0x80);
    NVIC_SetPriority (PendSV_IRQn, 0x80);
    
    
    __enable_irq();
    
    SystemCoreClock = RCC_GetSystemClockFreq();
    
    
    
    
    return;

    
    
    
}

