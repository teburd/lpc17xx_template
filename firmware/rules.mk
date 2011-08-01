# Setup

sp 		:= $(sp).x
dirstack_$(sp)	:= $(d)
d		:= $(dir)


# Local rules 

SRCS_$(d) 	:= $(wildcard $(d)/*.c)
OBJS_$(d) 	:= $(SRCS_$(d):%.c=%.o)

TGTS_$(d)	:= $(d)/firmware.hex
DEPS_$(d)	:= $(TGTS_$(d):%=%.d)

TGT_BIN		:= $(TGT_BIN) $(TGTS_$(d))
CLEAN		:= $(CLEAN) $(TGTS_$(d)) $(DEPS_$(d))

$(TGTS_$(d)):	$(d)/Rules.mk

$(TGTS_$(d)):	CF_TGT := -Icmsis -DRADDB=\"$(DIR_ETC)\"
$(TGTS_$(d)):	LL_TGT := $(S_LL_INET) cmsis/cmsis.a
$(TGTS_$(d)):	SRCS_$(d) cmsis/cmsis.a
		$(COMPLINK)

DEPS_$(d)	:= $(OBJS_$(d) :%=%.d)

CLEAN		:= $(CLEAN) $(OBJS_$(d)) $(DEPS_$(d)) $(d)/firmware.hex

$(OBJS_%(d)): CF_TGT := -I$(d)


# Cleanup

-include $(DEPS_$(d))

d := $(dirstack_$(sp))
sp := $(basename $(sp))
