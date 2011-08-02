GNU_INSTALL_ROOT	= /usr
GNU_VERSION 		= 4.5.2
GNUTOOLS			='$(GNU_INSTALL_ROOT)/bin'
THUMB2GNULIB 		='$(GNU_INSTALL_ROOT)/lib/gcc/arm-none-eabi/$(GNU_VERSION)/thumb2'
THUMB2GNULIB2		='$(GNU_INSTALL_ROOT)/arm-none-eabi/lib/thumb2'

CPU				= cortex-m3
OPTIM			= 0

CF_ALL			= -c 
CF_ALL			+= -mcpu=$(CPU) 
CF_ALL			+= -mthumb 
CF_ALL			+= -Wall 
CF_ALL			+= -O$(OPTIM) 
CF_ALL			+= -mapcs-frame 
CF_ALL			+= -D__thumb2__=1 
CF_ALL			+= -msoft-float 
CF_ALL			+= -gdwarf-2 
CF_ALL			+= -mno-sched-prolog 
CF_ALL			+= -fno-hosted 
CF_ALL			+= -mtune=cortex-m3 
CF_ALL			+= -march=armv7-m 
CF_ALL			+= -mfix-cortex-m3-ldrd  
CF_ALL			+= -ffunction-sections 
CF_ALL			+= -fdata-sections 
CF_ALL			+= -D__RAM_MODE__=1 

AF_ALL			= -mcpu=$(CPU)
AF_ALL			+= --defsym RAM_MODE=1 

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

LF_ALL			=  -static -mcpu=cortex-m3 -mthumb -mthumb-interwork
LF_ALL			+= -Wl,--start-group 
LF_ALL			+= -L$(THUMB2GNULIB) -L$(THUMB2GNULIB2)
LF_ALL			+= -lc -lg
LF_ALL			+= -lgcc -lm 
LF_ALL			+= -Wl,--end-group 

MAP      		= -Xlinker -Map -Xlinker
LDESC    		= -Xlinker -T  
ENTRY    		= -e
BIN      		= -bin
EXT      		=.elf
LEXT     		= 
REC      		=.srec
HEX		 		=.hex

ACOMP			= $(AS) $(AS_ALL) $(AS_TGT) -o $@ $<
CCOMP			= $(CC) $(CF_ALL) $(CF_TGT) -o $@ -c $<
ARCHIVE 		= $(AR) $@ $^
LINK			= $(CC) $(LF_ALL) $(LF_TGT) -o $@ $^ $(LL_TGT) $(LL_ALL)
COMPLINK		= $(CC) $(CF_ALL) $(CF_TGT) $(LF_ALL) $(LF_TGT) -o $@ $< $(LL_TGT) $(LL_ALL)
ELF2HEX			= $(OBJCOPY) -O ihex $< $@
