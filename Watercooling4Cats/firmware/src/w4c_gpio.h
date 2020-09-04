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

#ifndef W4C_GPIO_H
#define W4C_GPIO_H

#include <stdint.h>


/**Enable IO bank A
 
  Safe to call multiple time
 */
extern void gpio_a_enable();

/** Enable IO bank B 
 
  Safe to call multiple time
 */
extern void gpio_b_enable();

/** Enable IO bank C 
 
  Safe to call multiple time
 */
extern void gpio_c_enable();



/** Setup button 1 gpio 
    
    Require GPIO bank A to be enabled
 */
extern void button_1_setup_gpio();

/** Read button 1 gpio 
 
   Require button 1 GPIO to be setup 
 */
extern uint8_t button_1_read_state();


/** Setup button 2 gpio 
    
    Require GPIO bank B to be enabled
 */
extern void button_2_setup_gpio();

/** Read button 2 gpio 
 
   Require button 2 GPIO to be setup 
 */
extern uint8_t button_2_read_state();



/** Put Peltier CC enable pin in floating mode
    
    Require GPIO bank A to be enabled
*/
extern void peltier_cc_enable_setup_floating();


/** Put Peltier CC enable pin in output mode, push-pull, with value 0 initially set
    
    Require GPIO bank A to be enabled. It is safe to call this function as it disable the
    peltier CC.
*/
extern void peltier_cc_enable_setup_output();

/** Set the Peltier CC enable pin to high: this turns on the peltier CC
    
    Require peltier_cc_enable_setup_output() to have been called. It is potentially
    unsafe to call this function, as this will ENABLE the constant current buck to
    the peltier. Consider disabling interrupt non-essential to be sure to keep control.
    (If you are using delay() do NOT disable systicks. Maybe just busy wait)
*/
extern void peltier_cc_enable_on();

/** Set the Peltier CC enable pin to low: this turns off the peltier CC
    
    Require peltier_cc_enable_setup_output() to have been called. It is safe to call
    this function, as this disable the peltier CC.
*/
extern void peltier_cc_enable_off();


/** Setup LED gpio

    Require GPIO bank C to be enabled

*/
extern void led_setup_gpio();

/** Set LED on
 
  Require LED GPIO to be setup 
*/
extern void led_on();

/** Set LED off
 
  Require LED GPIO to be setup 
*/
extern void led_off();


#endif // W4C_GPIO_H
