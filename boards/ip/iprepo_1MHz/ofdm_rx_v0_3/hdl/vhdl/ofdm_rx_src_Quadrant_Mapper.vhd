-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Quadrant_Mapper.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Quadrant_Mapper
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_1/GradientEstimate /Complex to Magnitude-Angle HDL Optimized/Quadrant_Mapper
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_Quadrant_Mapper IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        xin                               :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        yin                               :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        xout                              :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        yout                              :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        QA_Control                        :   OUT   std_logic_vector(2 DOWNTO 0)  -- ufix3
        );
END ofdm_rx_src_Quadrant_Mapper;


ARCHITECTURE rtl OF ofdm_rx_src_Quadrant_Mapper IS

  -- Signals
  SIGNAL xin_signed                       : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL abs_y                            : signed(19 DOWNTO 0);  -- sfix20_En15
  SIGNAL abs_cast                         : signed(19 DOWNTO 0);  -- sfix20_En15
  SIGNAL xAbs                             : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL xAbsReg                          : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yin_signed                       : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL abs1_y                           : signed(19 DOWNTO 0);  -- sfix20_En15
  SIGNAL abs1_cast                        : signed(19 DOWNTO 0);  -- sfix20_En15
  SIGNAL yAbs                             : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yAbsReg                          : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL relop_relop1                     : std_logic;
  SIGNAL xout_tmp                         : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yout_tmp                         : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL in1reg                           : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL zeros                            : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL relop1_relop1                    : std_logic;
  SIGNAL in2reg                           : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL relop2_relop1                    : std_logic;
  SIGNAL qcControl                        : unsigned(2 DOWNTO 0);  -- ufix3

BEGIN
  xin_signed <= signed(xin);

  abs_cast <= resize(xin_signed, 20);
  
  abs_y <=  - (abs_cast) WHEN xin_signed < to_signed(16#00000#, 19) ELSE
      resize(xin_signed, 20);
  xAbs <= abs_y(18 DOWNTO 0);

  DelayxAbs_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xAbsReg <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xAbsReg <= xAbs;
      END IF;
    END IF;
  END PROCESS DelayxAbs_process;


  yin_signed <= signed(yin);

  abs1_cast <= resize(yin_signed, 20);
  
  abs1_y <=  - (abs1_cast) WHEN yin_signed < to_signed(16#00000#, 19) ELSE
      resize(yin_signed, 20);
  yAbs <= abs1_y(18 DOWNTO 0);

  DelayyAbs_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yAbsReg <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yAbsReg <= yAbs;
      END IF;
    END IF;
  END PROCESS DelayyAbs_process;


  
  relop_relop1 <= '1' WHEN xAbsReg > yAbsReg ELSE
      '0';

  
  xout_tmp <= yAbsReg WHEN relop_relop1 = '0' ELSE
      xAbsReg;

  xout <= std_logic_vector(xout_tmp);

  
  yout_tmp <= xAbsReg WHEN relop_relop1 = '0' ELSE
      yAbsReg;

  yout <= std_logic_vector(yout_tmp);

  Delayin1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      in1reg <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        in1reg <= xin_signed;
      END IF;
    END IF;
  END PROCESS Delayin1_process;


  zeros <= to_signed(16#00000#, 19);

  
  relop1_relop1 <= '1' WHEN in1reg < zeros ELSE
      '0';

  Delayin2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      in2reg <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        in2reg <= yin_signed;
      END IF;
    END IF;
  END PROCESS Delayin2_process;


  
  relop2_relop1 <= '1' WHEN in2reg < zeros ELSE
      '0';

  qcControl <= unsigned'(relop_relop1 & relop1_relop1 & relop2_relop1);

  QA_Control <= std_logic_vector(qcControl);

END rtl;

