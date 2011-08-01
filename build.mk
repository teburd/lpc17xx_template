GNU_INSTALL_ROOT	= /usr
GNU_VERSION 		= 4.5.2
GNUTOOLS			='$(GNU_INSTALL_ROOT)/bin'
THUMB2GNULIB 		='$(GNU_INSTALL_ROOT)/lib/gcc/arm-none-eabi/$(GNU_VERSION)/thumb2'
THUMB2GNULIB2		='$(GNU_INSTALL_ROOT)/arm-none-eabi/lib/thumb2'

CPU				= cortex-m3
OPTIM			= 0

CFLAGS			= -c 
CFLAGS			+= -mcpu=$(CPU) 
CFLAGS			+= -mthumb 
CFLAGS			+= -Wall 
CFLAGS			+= -O$(OPTIM) 
CFLAGS			+= -mapcs-frame 
CFLAGS			+= -D__thumb2__=1 
CFLAGS			+= -msoft-float 
CFLAGS			+= -gdwarf-2 
CFLAGS			+= -mno-sched-prolog 
CFLAGS			+= -fno-hosted 
CFLAGS			+= -mtune=cortex-m3 
CFLAGS			+= -march=armv7-m 
CFLAGS			+= -mfix-cortex-m3-ldrd  
CFLAGS			+= -ffunction-sections 
CFLAGS			+= -fdata-sections 

AFLAGS			= -mcpu=$(CPU) 

CC       		= $(GNUTOOLS)/arm-none-eabi-gcc-$(GNU_VERSION)
AS       		= $(GNUTOOLS)/arm-none-eabi-as
AR       		= $(GNUTOOLS)/arm-none-eabi-ar -r
LD       		= $(GNUTOOLS)/arm-none-eabi-gcc
NM       		= $(GNUTOOLS)/arm-none-eabi-nm
OBJDUMP  		= $(GNUTOOLS)/arm-none-eabi-objdump
OBJCOPY  		= $(GNUTOOLS)/arm-none-eabi-objcopy
READELF  		= $(GNUTOOLS)/arm-none-eabi-readelf
CODESIZE 		= $(GNUTOOLS)/arm-none-eabi-size

#LDFLAGS  		= -nostartfiles 
#LDFLAGS 		+= -nodefaultlibs 
#LDFLAGS 		+= -nostdlib 

LK				=  -static -mcpu=cortex-m3 -mthumb -mthumb-interwork
LK				+= -Wl,--start-group 
LK				+= -L$(THUMB2GNULIB) -L$(THUMB2GNULIB2)
LK				+= -lc -lg -lstdc++ -lsupc++ 
LK				+= -lgcc -lm 
LK				+= -Wl,--end-group 

MAP      		= -Xlinker -Map -Xlinker
LDESC    		= -Xlinker -T  
ENTRY    		= -e
BIN      		= -bin
EXT      		=.elf
LEXT     		= 
REC      		=.srec
HEX		 		=.hex
