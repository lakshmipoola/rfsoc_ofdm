-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_dataValidGen.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_dataValidGen
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/DataArrange/dataValidGen
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_dataValidGen IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1                             :   IN    std_logic;
        dataValidOut                      :   OUT   std_logic
        );
END ofdm_rx_src_dataValidGen;


ARCHITECTURE rtl OF ofdm_rx_src_dataValidGen IS

  -- Signals
  SIGNAL NOT_out1                         : std_logic;
  SIGNAL HDL_Counter2_out1                : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL AND_out1                         : std_logic;

BEGIN
  NOT_out1 <=  NOT enb_1;

  -- Count limited, Unsigned Counter
  --  initial value   = 0
  --  step value      = 1
  --  count to value  = 63
  HDL_Counter2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      HDL_Counter2_out1 <= to_unsigned(16#00#, 8);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF NOT_out1 = '1' THEN 
          HDL_Counter2_out1 <= to_unsigned(16#00#, 8);
        ELSIF enb_1 = '1' THEN 
          IF HDL_Counter2_out1 >= to_unsigned(16#3F#, 8) THEN 
            HDL_Counter2_out1 <= to_unsigned(16#00#, 8);
          ELSE 
            HDL_Counter2_out1 <= HDL_Counter2_out1 + to_unsigned(16#01#, 8);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS HDL_Counter2_process;


  
  Compare_To_Constant_out1 <= '1' WHEN HDL_Counter2_out1 > to_unsigned(16#0B#, 8) ELSE
      '0';

  AND_out1 <= Compare_To_Constant_out1 AND enb_1;

  dataValidOut <= AND_out1;

END rtl;

