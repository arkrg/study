TOP ?= $(notdir $(CURDIR))
TB ?= tb_$(TOP)
SRC_FILES   := $(wildcard src/*.sv)
TB_FILES   := $(wildcard tb/$(TB).sv)

BUILD_DIR  := ./build/$(TB)

.PHONY: all run compile sim wave clean

all: compile sim wave

run: compile sim

compile:
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && xvlog -sv  $(addprefix ../../, $(SRC_FILES) $(TB_FILES))
	cd $(BUILD_DIR) && xelab $(TB)  -debug typical -log compile.log -s $(TB)_snapshot

sim:
	cd $(BUILD_DIR) && xsim $(TB)_snapshot -R 

wave:
	cd $(BUILD_DIR) && gtkwave *.vcd & 

clean:
	rm -rf $(BUILD_DIR)
