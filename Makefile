TARGET_EXEC ?= econ

BUILD_DIR ?= ./obj
SRC_DIRS ?= $(shell find . -type d -name src)

SRCS := $(shell find $(SRC_DIRS) -name *.c)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

INC_DIRS := $(shell find . -type d -name inc)
INC_FLAGS := $(addprefix -I,$(INC_DIRS))

LDFLAGS :=

CC := mpicc
CFLAGS ?= $(INC_FLAGS) -std=c11 -MMD -MP -O0 -g3 -Wall -pedantic -Wno-padded -Wno-switch-enum -Wno-format-nonliteral


$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@


.PHONY: clean

clean:
	$(RM) -r $(BUILD_DIR)

-include $(DEPS)

MKDIR_P ?= mkdir -p
