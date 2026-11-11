PN ?= p1
RUN_FILE   := $(wildcard src/$(PN)*.sv)
TOP := $(basename $(notdir $(RUN_FILE)))


BUILD_DIR  := ./build/$(TOP)

.PHONY: all run compile sim wave clean

all: compile sim wave

run: compile sim

debug:
	echo $(TOP) $(RUN_FILE) 
compile:
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && xvlog -sv  ../../$(RUN_FILE)
	cd $(BUILD_DIR) && xelab $(TOP) -debug typical -log compile.log -s $(TOP)_snapshot

sim:
	cd $(BUILD_DIR) && xsim $(TOP)_snapshot -R 

wave:
		cd $(BUILD_DIR) && gtkwave *.vcd & 

clean:
	rm -rf $(BUILD_DIR)
