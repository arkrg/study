# ==============================================================================
# Build & Simulation Makefile
# ==============================================================================

# 1. 기본 파라미터 설정
TOP ?= $(notdir $(CURDIR))
TB ?= tb_$(TOP)
TB_FILES   := $(wildcard src/$(TB).sv)

BUILD_DIR  := ./build/$(TB)

.PHONY: all run compile sim wave clean

# 기본 타겟
all: compile sim wave

run: compile sim

compile:
	echo $(TB_FILES)
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && xvlog -sv  ../../$(TB_FILES)
	cd $(BUILD_DIR) && xelab $(TB)  -debug typical -log compile.log -s $(TB)_snapshot

sim:
	cd $(BUILD_DIR) && xsim $(TB)_snapshot -R 

# 모든 Test 실행 + xcrg를 이용한 Coverage DB Merge & HTML 통합 리포트 생성
wave:
	@if [ -d "$(BUILD_DIR)" ] && [ -n "$$(ls $(BUILD_DIR)/*.vcd 2>/dev/null)" ]; then \
		cd $(BUILD_DIR) && gtkwave *.vcd & \
	else \
		echo "[ERROR] 파형 파일(.vcd)을 찾을 수 없습니다: $(BUILD_DIR)"; \
	fi

clean:
	rm -rf $(BUILD_DIR)
