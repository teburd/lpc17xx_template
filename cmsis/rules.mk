# Setup
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)

# Define Sources and Objects
SRCS_$(d) := $(wildcard $(d)/*.c)
OBJS_$(d) := $(SRCS_$(d):%.c=%.o)

# Define Object Dependencies
DEPS_$(d) := $(OBJS_$(d):%.o=%.d)

# Include Dependency Make Rules (created by GCC)
-include $(DEPS_$(d))

# Object Rules
$(OBJS_%(d)): CF_TGT := -I$(d)

# Archive Rules
$(d)/cmsis.a: $(OBJS_$(d))

CLEAN := $(CLEAN) $(OBJS_$(d)) $(DEPS_$(d)) $(d)/cmsis.a


# Cleanup
d := $(dirstack_$(sp))
sp := $(basename $(sp))
