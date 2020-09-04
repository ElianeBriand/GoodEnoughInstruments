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

#ifndef SAFE_REBOOT_H
#define SAFE_REBOOT_H



/** Reboot device while ensuring external circuit are in a safe mode
 
 In particular, this disable the constant current buck to the peltier.
 */
extern void safe_reboot();


#endif // SAFE_REBOOT_H
