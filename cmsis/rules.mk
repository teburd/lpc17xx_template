# Setup
sp := $(sp).x
dirstack_$(sp) := $(d)
d := $(dir)

# Define Sources and Objects
SRCS_$(d) := $(wildcard $(d)/*.c)
OBJS_$(d) := $(SRCS_$(d):%.c=%.o)

# Define Object Dependenc
DEPS_$(d) := $(OBJS_$(d):%.o=%.d)

# Dependency Make Rules (created by GCC)
-include $(DEPS_$(d))

# Object Rule
$(OBJS_%(d)): CF_TGT := -I$(d)

# Archive Rule
$(d)/cmsis.a: $(OBJS_$(d))

# Clean Rule
CLEAN := $(CLEAN) $(OBJS_$(d)) $(DEPS_$(d)) $(d)/cmsis.a


# Cleanup
d := $(dirstack_$(sp))
sp := $(basename $(sp))
