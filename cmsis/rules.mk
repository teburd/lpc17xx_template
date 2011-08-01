# Standard things

sp				:= $(sp).x
dirstack_$(sp)	:= $(d)
d				:= $(dir)


SRCS_$(d) 	:= $(wildcard $(d)/*.c)
OBJS_$(d) 	:= $(SRCS_$(d):%.c=%.o)

DEPS_$(d)	:= $(OBJS_$(d) :%=%.d)

CLEAN		:= $(CLEAN) $(OBJS_$(d)) $(DEPS_$(d)) $(d)/cmsis.a

$(OBJS_%(d)): CF_TGT := -I$(d)

$(d)/cmsis.a: $(OBJS_$(d))

-include $(DEPS_$(d))

d := $(dirstack_$(sp))
sp := $(basename $(sp))
