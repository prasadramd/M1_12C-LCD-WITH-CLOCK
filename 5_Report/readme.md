# Project name is I2C LCD WITH CLOCK

Communicating with the display is a bit complicated because we have to use it in 4 bits  mode. If the backpack used a 16 bit expander instead of 8 bit then life whas much easier, but 8 bits expanders are cheaper… That means to write to an 8 bit register we have to send the high 4 bits of a byte first and then the last 4 bits. There are 2 registers to write to. That’s the data register DR and the instruction register IR. Text you want to get on the display have to be set in the data register. Command’s like, changing the cursor position or clearing the display, have to be set in the instruction register. The register select RS pin will let you choose between both the registers. Puttting the pin low (0V) selects the IR and high (5V) selects the DR.

It is possible to read an address location or to read the busy flag BF. The BF is used to check if the lcd is still working on an internal command. If so, it’s not possible to send a new instruction. I didn’t do anything with the BF yet or reading the address locations. For writing text on the lcd it’s not needed. I used delays according the datasheet to wait for the time the lcd needs.

There is a read write RW pin. To read from the lcd this pin should be high and for writing low. There is also a pin for the backlight BL, but my display requires this to be activated all the times else you won’t see anything on the display.

To set a byte into a register the enable EN pin have to be set high. This works like a latched flip flop, that means whatever voltage you put on the pins they will only be read by the lcd if the enable pin is high. Writing an instruction or a character are basically the same. The only difference is the register select pin. Basically to write to a register the following steps have to be done:

Put the correct voltages on all the lcd pins for the first 4 bits of a byte you want to send.
Set the enable pin high for more then 450 nano seconds and keep the rest of the pins the same.
Set the enable pin low for more then 37 micro seconds and keep the rest of the pins the same.
Do the last 3 steps again, but now for the last 4 bits of 8.
