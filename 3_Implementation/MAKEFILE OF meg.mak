all:
	avr-gcc -Wall -g -Os -mmcu=atmega328 -o test.bin initialize.c diaplaymain.c application.c 
exec: all
	avr-objcopy -j .text -j .data -O ihex test.bin test.hex
clean:
	rm -rf test.hex
