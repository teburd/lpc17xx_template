# Setup

sp 		:= $(sp).x
dirstack_$(sp)	:= $(d)
d		:= $(dir)


# Local rules 

CSRCS_$(d)	:= $(wildcard $(d)/*.c)
ASRCS_$(d)	:= $(wildcard $(d)/*.s)
COBJS_$(d)	:= $(CSRCS_$(d):%.c=%.o)
AOBJS_$(d)	:= $(ASRCS_$(d):%.s=%.o)

ELF_$(d)	:= $(d)/firmware.elf
HEX_$(d)	:= $(d)/firmware.hex
DEPS_$(d)	:= $(TGTS_$(d):%=%.d)
TGTS_$(d)	:= $(ELF_$(d)) $(HEX_$(d))

TGT_BIN		:= $(TGT_BIN) $(TGTS_$(d))
CLEAN		:= $(CLEAN) $(TGTS_$(d)) $(DEPS_$(d))

$(ELF_$(d)):	CF_TGT := -Icmsis -DRADDB=\"$(DIR_ETC)\"
$(ELF_$(d)):	LL_TGT := $(S_LL_INET) cmsis/cmsis.a
$(ELF_$(d)):	$(COBJS_$(d)) $(AOBJS_$(d)) cmsis/cmsis.a
$(HEX_$(d)):	$(ELF_$(d))

DEPS_$(d)	:= $(COBJS_$(d) :%=%.d)

CLEAN		:= $(CLEAN) $(COBJS_$(d)) $(AOBJS_$(d)) $(DEPS_$(d)) $(TGTS_$(d))

$(COBJS_%(d)): CF_TGT := -I$(d)
$(AOBJS_%(d)): CF_TGT := -I$(d)

# Cleanup

-include $(DEPS_$(d))

d := $(dirstack_$(sp))
sp := $(basename $(sp))
