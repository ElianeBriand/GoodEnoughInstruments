A small FT232H-based USB-to-JTAG board

# Features

- Mostly planned to be used for USB-to-JTAG
- All FT232H output pins brought out, so theoretically any of the supported 
protocols will work
- 200 mA LDO for FT232H, and another 200 mA LDO to power whatever your need
- USB Micro-B connector, powered from USB 5V

# Files

- EAGLE schematics and board files in `EAGLE` directory
- Gerbers and Pick and place files (for JLC SMT service) in `GerbersAndManufacturing`
- Configuration for OpenOCD and other software in `Software`


# Known issue

- JLC SMT does not have USB connector (or header, but that's less of a problem) so
you have to hand solder the connector, which is hard because it's tiny
- 200 mA for board under test is a bit low, but then again it likely has its own
power supply


