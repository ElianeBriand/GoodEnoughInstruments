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

#ifndef HIGH_LEVEL_SYSTEM_INIT_H
#define HIGH_LEVEL_SYSTEM_INIT_H

/**  Perform non-essential system initialization (does not belong in pre-main crt or system init)
 
 Necessary for:
  - delay_*

 
*/
extern void high_level_system_init();


#endif // HIGH_LEVEL_SYSTEM_INIT_H
