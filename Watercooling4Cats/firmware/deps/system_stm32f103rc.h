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
 This file contain the declaration of the system init and clock update function.
 Its purpose is to be a licence-wise clean version of the stm32 peripheral library.
*/

#ifndef SYSTEM_STM32F103RC_H
#define SYSTEM_STM32F103RC_H

#include <stdint.h>

extern uint32_t SystemCoreClock;
extern const uint8_t AHBPrescTable[16U];
extern const uint8_t APBPrescTable[8U];


extern void stm32f103rc_system_init();


#endif // SYSTEM_STM32F103RC_H


