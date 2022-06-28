all: rfsoc2x2 rfsoc4x2 zcu111

rfsoc2x2:
	$(MAKE) -C boards/RFSoC2x2/rfsoc_ofdm/

rfsoc4x2:
	$(MAKE) -C boards/RFSoC4x2/rfsoc_ofdm/

zcu111:
	$(MAKE) -C boards/ZCU111/rfsoc_ofdm/
