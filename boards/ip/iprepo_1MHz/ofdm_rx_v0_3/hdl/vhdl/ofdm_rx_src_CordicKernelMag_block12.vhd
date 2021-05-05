-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_CordicKernelMag_block12.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_CordicKernelMag_block12
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_2/PhaseEst/Complex to Magnitude-Angle HDL Optimized/CordicKernelMag
-- Hierarchy Level: 3
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_CordicKernelMag_block12 IS
  PORT( xin                               :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        yin                               :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        zin                               :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En18
        lut_value                         :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18_En18
        idx                               :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
        xout                              :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        yout                              :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En15
        zout                              :   OUT   std_logic_vector(18 DOWNTO 0)  -- sfix19_En18
        );
END ofdm_rx_src_CordicKernelMag_block12;


ARCHITECTURE rtl OF ofdm_rx_src_CordicKernelMag_block12 IS

  -- Signals
  SIGNAL yin_signed                       : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yLessThanZero                    : std_logic;
  SIGNAL xin_signed                       : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL idx_unsigned                     : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL dynamic_shift1_cast              : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL yShifted                         : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL xout2                            : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL xout1                            : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL xout_tmp                         : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL dynamic_shift_cast               : unsigned(7 DOWNTO 0);  -- uint8
  SIGNAL xShifted                         : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yout2                            : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yout1                            : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL yout_tmp                         : signed(18 DOWNTO 0);  -- sfix19_En15
  SIGNAL zin_signed                       : signed(18 DOWNTO 0);  -- sfix19_En18
  SIGNAL lut_value_unsigned               : unsigned(17 DOWNTO 0);  -- ufix18_En18
  SIGNAL ZAdder_add_cast                  : signed(18 DOWNTO 0);  -- sfix19_En18
  SIGNAL zout2                            : signed(18 DOWNTO 0);  -- sfix19_En18
  SIGNAL ZSub_sub_cast                    : signed(18 DOWNTO 0);  -- sfix19_En18
  SIGNAL zout1                            : signed(18 DOWNTO 0);  -- sfix19_En18
  SIGNAL zout_tmp                         : signed(18 DOWNTO 0);  -- sfix19_En18

BEGIN
  yin_signed <= signed(yin);

  
  yLessThanZero <= '1' WHEN yin_signed < to_signed(16#00000#, 19) ELSE
      '0';

  xin_signed <= signed(xin);

  idx_unsigned <= unsigned(idx);

  dynamic_shift1_cast <= resize(idx_unsigned, 8);
  yShifted <= SHIFT_RIGHT(yin_signed, to_integer(dynamic_shift1_cast));

  xout2 <= xin_signed + yShifted;

  xout1 <= xin_signed - yShifted;

  
  xout_tmp <= xout2 WHEN yLessThanZero = '0' ELSE
      xout1;

  xout <= std_logic_vector(xout_tmp);

  dynamic_shift_cast <= resize(idx_unsigned, 8);
  xShifted <= SHIFT_RIGHT(xin_signed, to_integer(dynamic_shift_cast));

  yout2 <= yin_signed - xShifted;

  yout1 <= yin_signed + xShifted;

  
  yout_tmp <= yout2 WHEN yLessThanZero = '0' ELSE
      yout1;

  yout <= std_logic_vector(yout_tmp);

  zin_signed <= signed(zin);

  lut_value_unsigned <= unsigned(lut_value);

  ZAdder_add_cast <= signed(resize(lut_value_unsigned, 19));
  zout2 <= zin_signed + ZAdder_add_cast;

  ZSub_sub_cast <= signed(resize(lut_value_unsigned, 19));
  zout1 <= zin_signed - ZSub_sub_cast;

  
  zout_tmp <= zout2 WHEN yLessThanZero = '0' ELSE
      zout1;

  zout <= std_logic_vector(zout_tmp);

END rtl;

