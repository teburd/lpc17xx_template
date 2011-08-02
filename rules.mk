# Standard things

.SUFFIXES:
.SUFFIXES:	.c .o .s

all:		targets


# Subdirectories, in random order

dir	:= cmsis
include		$(dir)/rules.mk
dir	:= firmware
include		$(dir)/rules.mk


# General directory independent rules

%.o:	%.s
		@$(ACOMP)
		@echo "Compiling $<"

%.o:	%.c
		@$(CCOMP)
		@echo "Compiling $<"

%:		%.o
		@$(LINK)
		@echo "Linking $^"

%:		%.c
		@$(COMPLINK)
		@echo "Compiling and Linking $^"

%.a:
		@$(ARCHIVE)
		@echo "Archiving $@"

%.elf:
	@$(LINK)
	@echo "Linking $@"

%.hex:	%.elf
	@$(ELF2HEX)
	@echo "Hexifying $@"


# The variables TGT_*, CLEAN and CMD_INST* may be added to by the Makefile
# fragments in the various subdirectories.

.PHONY:		targets
targets:	$(TGT_BIN) $(TGT_SBIN) $(TGT_ETC) $(TGT_LIB)

.PHONY:		clean
clean:
		rm -f $(CLEAN)

# Prevent make from removing any build targets, including intermediate ones

.SECONDARY:	$(CLEAN)
