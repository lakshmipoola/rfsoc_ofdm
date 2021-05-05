-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_CoarseFreqCorr.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_CoarseFreqCorr
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/CoarseFreqCorr
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_CoarseFreqCorr IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1_256_1                       :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        frameDet                          :   IN    std_logic;
        phaseIn                           :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En22
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        frameDetOut                       :   OUT   std_logic
        );
END ofdm_rx_src_CoarseFreqCorr;


ARCHITECTURE rtl OF ofdm_rx_src_CoarseFreqCorr IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_RsingEdge
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          In1                             :   IN    std_logic;
          Out1                            :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_NCO_HDL_Optimized
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          inc                             :   IN    std_logic_vector(15 DOWNTO 0);  -- uint16
          validIn                         :   IN    std_logic;
          complexexp_re                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          complexexp_im                   :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_RsingEdge
    USE ENTITY work.ofdm_rx_src_RsingEdge(rtl);

  FOR ALL : ofdm_rx_src_NCO_HDL_Optimized
    USE ENTITY work.ofdm_rx_src_NCO_HDL_Optimized(rtl);

  -- Signals
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_reg_re                     : vector_of_signed16(0 TO 7);  -- sfix16_En14 [8]
  SIGNAL Delay_reg_im                     : vector_of_signed16(0 TO 7);  -- sfix16_En14 [8]
  SIGNAL Delay_out1_re                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_im                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_re_1                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_im_1                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_1_C2ReIm_A        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL RsingEdge_out1                   : std_logic;
  SIGNAL phaseIn_signed                   : signed(24 DOWNTO 0);  -- sfix25_En22
  SIGNAL Unit_Delay_Enabled_Synchronous_ectrl : signed(24 DOWNTO 0);  -- sfix25_En22
  SIGNAL Unit_Delay_Enabled_Synchronous_ectrl_1 : signed(24 DOWNTO 0);  -- sfix25_En22
  SIGNAL Gain_cast                        : signed(49 DOWNTO 0);  -- sfix50_En34
  SIGNAL Gain_out1                        : unsigned(15 DOWNTO 0);  -- uint16
  SIGNAL Constant_out1                    : std_logic;
  SIGNAL NCO_HDL_Optimized_out1_re        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL NCO_HDL_Optimized_out1_im        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL NCO_HDL_Optimized_out2           : std_logic;
  SIGNAL NCO_HDL_Optimized_out1_re_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL NCO_HDL_Optimized_out1_im_signed : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL conj_cast                        : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL conj_cast_1                      : signed(16 DOWNTO 0);  -- sfix17_En14
  SIGNAL Math_Function_out1_re            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_im            : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_re_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_im_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_re_2          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Math_Function_out1_im_2          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_2_C2ReIm_A        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_mul_temp                 : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Re_AC                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_Re_AC_1                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_1_C2ReIm_B        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_C2ReIm_2_C2ReIm_B        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product2_mul_temp                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Re_BD                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product1_mul_temp                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Im_AD                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_Im_AD_1                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product3_mul_temp                : signed(31 DOWNTO 0);  -- sfix32_En28
  SIGNAL Product_Im_BC                    : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_Re_BD_1                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL mulOutput                        : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_Im_BC_1                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL mulOutput_1                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay7_bypass_reg_re             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay7_bypass_reg_im             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_out1_re                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Product_out1_im                  : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_reg                       : std_logic_vector(0 TO 8);  -- ufix1 [9]
  SIGNAL Delay1_out1                      : std_logic;

BEGIN
  -- Generate complex sinusoid with a frequency equal 
  -- to the estimated frequency offset. 
  -- 
  -- Correct frequency offset
  -- 
  -- Reccord the phase of the averaged autocorrelation at the coarse
  -- timing point.  

  u_RsingEdge : ofdm_rx_src_RsingEdge
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              In1 => frameDet,
              Out1 => RsingEdge_out1
              );

  u_NCO_HDL_Optimized : ofdm_rx_src_NCO_HDL_Optimized
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              inc => std_logic_vector(Gain_out1),  -- uint16
              validIn => Constant_out1,
              complexexp_re => NCO_HDL_Optimized_out1_re,  -- sfix16_En14
              complexexp_im => NCO_HDL_Optimized_out1_im,  -- sfix16_En14
              validOut => NCO_HDL_Optimized_out2
              );

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  Delay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay_reg_im(0) <= dataIn_im_signed;
        Delay_reg_im(1 TO 7) <= Delay_reg_im(0 TO 6);
        Delay_reg_re(0) <= dataIn_re_signed;
        Delay_reg_re(1 TO 7) <= Delay_reg_re(0 TO 6);
      END IF;
    END IF;
  END PROCESS Delay_process;

  Delay_out1_re <= Delay_reg_re(7);
  Delay_out1_im <= Delay_reg_im(7);

  Delay_out1_re_1 <= Delay_out1_re;

  reduced_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_1_C2ReIm_A <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_1_C2ReIm_A <= Delay_out1_re_1;
      END IF;
    END IF;
  END PROCESS reduced_process;


  phaseIn_signed <= signed(phaseIn);

  
  Unit_Delay_Enabled_Synchronous_ectrl_1 <= Unit_Delay_Enabled_Synchronous_ectrl WHEN RsingEdge_out1 = '0' ELSE
      phaseIn_signed;

  delayMatch1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Unit_Delay_Enabled_Synchronous_ectrl <= to_signed(16#0000000#, 25);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Unit_Delay_Enabled_Synchronous_ectrl <= Unit_Delay_Enabled_Synchronous_ectrl_1;
      END IF;
    END IF;
  END PROCESS delayMatch1_process;


  Gain_cast <= resize(Unit_Delay_Enabled_Synchronous_ectrl & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 50);
  Gain_out1 <= unsigned(Gain_cast(49 DOWNTO 34));

  Constant_out1 <= '1';

  NCO_HDL_Optimized_out1_re_signed <= signed(NCO_HDL_Optimized_out1_re);

  NCO_HDL_Optimized_out1_im_signed <= signed(NCO_HDL_Optimized_out1_im);

  Math_Function_out1_re <= NCO_HDL_Optimized_out1_re_signed;
  conj_cast <= resize(NCO_HDL_Optimized_out1_im_signed, 17);
  conj_cast_1 <=  - (conj_cast);
  
  Math_Function_out1_im <= X"7FFF" WHEN (conj_cast_1(16) = '0') AND (conj_cast_1(15) /= '0') ELSE
      X"8000" WHEN (conj_cast_1(16) = '1') AND (conj_cast_1(15) /= '1') ELSE
      conj_cast_1(15 DOWNTO 0);

  delayMatch_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Math_Function_out1_re_1 <= to_signed(16#0000#, 16);
      Math_Function_out1_im_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Math_Function_out1_re_1 <= Math_Function_out1_re;
        Math_Function_out1_im_1 <= Math_Function_out1_im;
      END IF;
    END IF;
  END PROCESS delayMatch_process;


  Math_Function_out1_re_2 <= Math_Function_out1_re_1;

  reduced_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_2_C2ReIm_A <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_2_C2ReIm_A <= Math_Function_out1_re_2;
      END IF;
    END IF;
  END PROCESS reduced_1_process;


  Product_mul_temp <= Product_C2ReIm_1_C2ReIm_A * Product_C2ReIm_2_C2ReIm_A;
  Product_Re_AC <= Product_mul_temp(29 DOWNTO 14);

  PipelineRegister_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_AC_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Re_AC_1 <= Product_Re_AC;
      END IF;
    END IF;
  END PROCESS PipelineRegister_process;


  Delay_out1_im_1 <= Delay_out1_im;

  reduced_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_1_C2ReIm_B <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_1_C2ReIm_B <= Delay_out1_im_1;
      END IF;
    END IF;
  END PROCESS reduced_2_process;


  Math_Function_out1_im_2 <= Math_Function_out1_im_1;

  reduced_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_C2ReIm_2_C2ReIm_B <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_C2ReIm_2_C2ReIm_B <= Math_Function_out1_im_2;
      END IF;
    END IF;
  END PROCESS reduced_3_process;


  Product2_mul_temp <= Product_C2ReIm_1_C2ReIm_B * Product_C2ReIm_2_C2ReIm_B;
  Product_Re_BD <= Product2_mul_temp(29 DOWNTO 14);

  Product1_mul_temp <= Product_C2ReIm_1_C2ReIm_A * Product_C2ReIm_2_C2ReIm_B;
  Product_Im_AD <= Product1_mul_temp(29 DOWNTO 14);

  PipelineRegister1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_AD_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Im_AD_1 <= Product_Im_AD;
      END IF;
    END IF;
  END PROCESS PipelineRegister1_process;


  Product3_mul_temp <= Product_C2ReIm_1_C2ReIm_B * Product_C2ReIm_2_C2ReIm_A;
  Product_Im_BC <= Product3_mul_temp(29 DOWNTO 14);

  PipelineRegister2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Re_BD_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Re_BD_1 <= Product_Re_BD;
      END IF;
    END IF;
  END PROCESS PipelineRegister2_process;


  mulOutput <= Product_Re_AC_1 - Product_Re_BD_1;

  PipelineRegister3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Product_Im_BC_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        Product_Im_BC_1 <= Product_Im_BC;
      END IF;
    END IF;
  END PROCESS PipelineRegister3_process;


  mulOutput_1 <= Product_Im_AD_1 + Product_Im_BC_1;

  Delay7_bypass_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay7_bypass_reg_re <= to_signed(16#0000#, 16);
      Delay7_bypass_reg_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_1 = '1' THEN
        Delay7_bypass_reg_im <= mulOutput_1;
        Delay7_bypass_reg_re <= mulOutput;
      END IF;
    END IF;
  END PROCESS Delay7_bypass_process;

  
  Product_out1_re <= mulOutput WHEN enb_1_256_1 = '1' ELSE
      Delay7_bypass_reg_re;
  
  Product_out1_im <= mulOutput_1 WHEN enb_1_256_1 = '1' ELSE
      Delay7_bypass_reg_im;

  dataOut_re <= std_logic_vector(Product_out1_re);

  dataOut_im <= std_logic_vector(Product_out1_im);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay1_reg(0) <= frameDet;
        Delay1_reg(1 TO 8) <= Delay1_reg(0 TO 7);
      END IF;
    END IF;
  END PROCESS Delay1_process;

  Delay1_out1 <= Delay1_reg(8);

  frameDetOut <= Delay1_out1;

END rtl;

