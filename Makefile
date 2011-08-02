LDRAMSCRIPT = 'ldscript_ram_gnu.ld'
LDROMSCRIPT = 'ldscript_rom_gnu.ld'
LDSIMSCRIPT = '/usr/arm-none-eabi/lib/generic-hosted.ld'
include build.mk

ram: LF_ALL += -T$(LDRAMSCRIPT)
ram: AS_ALL += --defsym RAM_MODE=1
ram: CF_ALL += -DRAM_MODE=1
ram: targets

rom: LF_ALL += -T$(LDROMSCRIPT)
rom: AS_ALL += --defsym RAM_MODE=0
rom: CF_ALL += -DRAM_MODE=0
rom: targets

sim: LF_ALL += -T$(LDSIMSCRIPT)
sim: AS_ALL += --defsym RAM_MODE=1
sim: CF_ALL += -DRAM_MODE=1
sim: targets

include rules.mk


