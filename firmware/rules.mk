# Setup
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)

# Define Sources and Objects
CSRCS_$(d) := $(wildcard $(d)/*.c)
ASRCS_$(d) := $(wildcard $(d)/*.s)
COBJS_$(d) := $(CSRCS_$(d):%.c=%.o)
AOBJS_$(d) := $(ASRCS_$(d):%.s=%.o)

# Define Object Dependency Rule Files
DEPS_$(d) := $(COBJS_$(d):%.o=%.d) $(AOBJS_$(d):%.o=%.d)


# Include Dependency Make Rules (created by GCC)
-include $(DEPS_$(d))

# Define Real Targets
ELF_$(d) := $(d)/firmware.elf
HEX_$(d) := $(d)/firmware.hex
DEPS_$(d) := $(TGTS_$(d):%=%.d)
TGTS_$(d) := $(ELF_$(d)) $(HEX_$(d))

# Append the defined targets to the project binary target
TGT_BIN := $(TGT_BIN) $(TGTS_$(d))

# Object Rules
$(COBJS_%(d)): CF_TGT := -I$(d)
$(AOBJS_%(d)): CF_TGT := -I$(d)

# Target Rules
$(ELF_$(d)): CF_TGT := -Icmsis -DRADDB=\"$(DIR_ETC)\"
$(ELF_$(d)): LL_TGT := $(S_LL_INET) cmsis/cmsis.a
$(ELF_$(d)): $(COBJS_$(d)) $(AOBJS_$(d)) cmsis/cmsis.a
$(HEX_$(d)): $(ELF_$(d))

CLEAN := $(CLEAN) $(COBJS_$(d)) $(AOBJS_$(d)) $(DEPS_$(d)) $(TGTS_$(d))

# Cleanup
d := $(dirstack_$(sp))
sp := $(basename $(sp))
