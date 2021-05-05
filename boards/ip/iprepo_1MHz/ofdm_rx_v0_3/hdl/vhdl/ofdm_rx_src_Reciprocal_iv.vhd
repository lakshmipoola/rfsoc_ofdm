-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Reciprocal_iv.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Reciprocal_iv
-- Source Path: Reciprocal/Reciprocal_iv
-- Hierarchy Level: 5
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_Reciprocal_iv IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        ain                               :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        xinit                             :   OUT   std_logic_vector(22 DOWNTO 0);  -- sfix23_En19
        inzero                            :   OUT   std_logic;  -- ufix1
        aout                              :   OUT   std_logic_vector(15 DOWNTO 0)  -- ufix16_En16
        );
END ofdm_rx_src_Reciprocal_iv;


ARCHITECTURE rtl OF ofdm_rx_src_Reciprocal_iv IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_NewtonPolynomialIVStage
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          ain                             :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
          mulin                           :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En21
          adderin                         :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En19
          xinitinterm                     :   OUT   std_logic_vector(22 DOWNTO 0)  -- sfix23_En19
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_NewtonPolynomialIVStage
    USE ENTITY work.ofdm_rx_src_NewtonPolynomialIVStage(rtl);

  -- Signals
  SIGNAL ain_unsigned                     : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL ain_reg_reg                      : vector_of_unsigned16(0 TO 1);  -- ufix16 [2]
  SIGNAL aout_tmp                         : unsigned(15 DOWNTO 0);  -- ufix16_En16
  SIGNAL constA                           : signed(24 DOWNTO 0);  -- sfix25_En21
  SIGNAL constB                           : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL constC                           : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL xinitreg                         : std_logic_vector(22 DOWNTO 0);  -- ufix23
  SIGNAL xinitreg_signed                  : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL xinitreg_1                       : signed(24 DOWNTO 0);  -- sfix25_En21
  SIGNAL constC_reg_reg                   : vector_of_signed23(0 TO 3);  -- sfix23 [4]
  SIGNAL constC_p                         : signed(22 DOWNTO 0);  -- sfix23_En19
  SIGNAL xinit_tmp                        : std_logic_vector(22 DOWNTO 0);  -- ufix23
  SIGNAL mstwobit                         : unsigned(1 DOWNTO 0);  -- ufix2

BEGIN
  -- Polynomial initial value stage of the RecipSqrtSingleRate Implementation using Newton Method

  u_NewtonPolynomialIVStage1 : ofdm_rx_src_NewtonPolynomialIVStage
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ain => ain,  -- ufix16_En16
              mulin => std_logic_vector(constA),  -- sfix25_En21
              adderin => std_logic_vector(constB),  -- sfix23_En19
              xinitinterm => xinitreg  -- sfix23_En19
              );

  u_NewtonPolynomialIVStage2 : ofdm_rx_src_NewtonPolynomialIVStage
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              ain => std_logic_vector(aout_tmp),  -- ufix16_En16
              mulin => std_logic_vector(xinitreg_1),  -- sfix25_En21
              adderin => std_logic_vector(constC_p),  -- sfix23_En19
              xinitinterm => xinit_tmp  -- sfix23_En19
              );

  ain_unsigned <= unsigned(ain);

  -- Pipeline registers
  ain_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      ain_reg_reg <= (OTHERS => to_unsigned(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        ain_reg_reg(0) <= ain_unsigned;
        ain_reg_reg(1) <= ain_reg_reg(0);
      END IF;
    END IF;
  END PROCESS ain_reg_process;

  aout_tmp <= ain_reg_reg(1);

  constA <= to_signed(16#032FB80#, 25);

  constB <= to_signed(-16#1975F1#, 23);

  constC <= to_signed(16#15015D#, 23);

  xinitreg_signed <= signed(xinitreg);

  xinitreg_1 <= xinitreg_signed & '0' & '0';

  -- Pipeline registers
  constC_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      constC_reg_reg <= (OTHERS => to_signed(16#000000#, 23));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        constC_reg_reg(0) <= constC;
        constC_reg_reg(1 TO 3) <= constC_reg_reg(0 TO 2);
      END IF;
    END IF;
  END PROCESS constC_reg_process;

  constC_p <= constC_reg_reg(3);

  mstwobit <= ain_unsigned(15 DOWNTO 14);

  
  inzero <= '1' WHEN mstwobit = to_unsigned(16#0#, 2) ELSE
      '0';

  aout <= std_logic_vector(aout_tmp);

  xinit <= xinit_tmp;

END rtl;

