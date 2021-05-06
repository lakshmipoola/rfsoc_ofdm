-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Synchronisation.vhd
-- Created: 2021-05-06 12:53:37
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Synchronisation
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_Synchronisation IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1_256_1                       :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        threshold                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        DataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        DataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        FFTValidOut                       :   OUT   std_logic;
        dataValid                         :   OUT   std_logic;
        preambleValid                     :   OUT   std_logic
        );
END ofdm_rx_src_Synchronisation;


ARCHITECTURE rtl OF ofdm_rx_src_Synchronisation IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_SchmidlCoxMetric
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          enb_1_256_1                     :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          threshold                       :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          left                            :   OUT   std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
          right                           :   OUT   std_logic_vector(32 DOWNTO 0);  -- sfix33_En23
          phase                           :   OUT   std_logic_vector(24 DOWNTO 0)  -- sfix25_En22
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_FrameDetect
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          leftIn                          :   IN    std_logic_vector(35 DOWNTO 0);  -- sfix36_En32
          rightIn                         :   IN    std_logic_vector(32 DOWNTO 0);  -- sfix33_En23
          phaseIn                         :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En22
          frameDet                        :   OUT   std_logic;
          phaseOut                        :   OUT   std_logic_vector(24 DOWNTO 0)  -- sfix25_En22
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_CoarseFreqCorr
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          enb_1_256_1                     :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataIn_im                       :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          frameDet                        :   IN    std_logic;
          phaseIn                         :   IN    std_logic_vector(24 DOWNTO 0);  -- sfix25_En22
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          frameDetOut                     :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_Delay
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          data_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          data_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          strobe                          :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          dataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          strobeOut                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_ControlSigGen
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          validIn                         :   IN    std_logic;
          FFTValid                        :   OUT   std_logic;
          dataValid                       :   OUT   std_logic;
          preambleValid                   :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_SchmidlCoxMetric
    USE ENTITY work.ofdm_rx_src_SchmidlCoxMetric(rtl);

  FOR ALL : ofdm_rx_src_FrameDetect
    USE ENTITY work.ofdm_rx_src_FrameDetect(rtl);

  FOR ALL : ofdm_rx_src_CoarseFreqCorr
    USE ENTITY work.ofdm_rx_src_CoarseFreqCorr(rtl);

  FOR ALL : ofdm_rx_src_Delay
    USE ENTITY work.ofdm_rx_src_Delay(rtl);

  FOR ALL : ofdm_rx_src_ControlSigGen
    USE ENTITY work.ofdm_rx_src_ControlSigGen(rtl);

  -- Signals
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_reg_re                    : vector_of_signed16(0 TO 21);  -- sfix16_En14 [22]
  SIGNAL Delay1_reg_im                    : vector_of_signed16(0 TO 21);  -- sfix16_En14 [22]
  SIGNAL Delay1_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay1_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_reg_re                    : vector_of_signed16(0 TO 1);  -- sfix16_En14 [2]
  SIGNAL Delay2_reg_im                    : vector_of_signed16(0 TO 1);  -- sfix16_En14 [2]
  SIGNAL Delay2_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay2_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL SchmidlCoxMetric_out1            : std_logic_vector(35 DOWNTO 0);  -- ufix36
  SIGNAL SchmidlCoxMetric_out2            : std_logic_vector(32 DOWNTO 0);  -- ufix33
  SIGNAL SchmidlCoxMetric_out3            : std_logic_vector(24 DOWNTO 0);  -- ufix25
  SIGNAL FrameDetect_out1                 : std_logic;
  SIGNAL FrameDetect_out2                 : std_logic_vector(24 DOWNTO 0);  -- ufix25
  SIGNAL CoarseFreqCorr_out1_re           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL CoarseFreqCorr_out1_im           : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL CoarseFreqCorr_out2              : std_logic;
  SIGNAL Delay_out1_re                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Delay_out1_im                    : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL Delay_out2                       : std_logic;
  SIGNAL Delay_out1_re_signed             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay_out1_im_signed             : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay4_out1_re                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL Delay4_out1_im                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL ControlSigGen_out1               : std_logic;
  SIGNAL ControlSigGen_out2               : std_logic;
  SIGNAL ControlSigGen_out3               : std_logic;

BEGIN
  u_SchmidlCoxMetric : ofdm_rx_src_SchmidlCoxMetric
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_256_0 => enb_1_256_0,
              enb_1_256_1 => enb_1_256_1,
              dataIn_re => dataIn_re,  -- sfix16_En14
              dataIn_im => dataIn_im,  -- sfix16_En14
              threshold => threshold,  -- uint32
              left => SchmidlCoxMetric_out1,  -- sfix36_En32
              right => SchmidlCoxMetric_out2,  -- sfix33_En23
              phase => SchmidlCoxMetric_out3  -- sfix25_En22
              );

  u_FrameDetect : ofdm_rx_src_FrameDetect
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              leftIn => SchmidlCoxMetric_out1,  -- sfix36_En32
              rightIn => SchmidlCoxMetric_out2,  -- sfix33_En23
              phaseIn => SchmidlCoxMetric_out3,  -- sfix25_En22
              frameDet => FrameDetect_out1,
              phaseOut => FrameDetect_out2  -- sfix25_En22
              );

  u_CoarseFreqCorr : ofdm_rx_src_CoarseFreqCorr
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_256_0 => enb_1_256_0,
              enb_1_256_1 => enb_1_256_1,
              dataIn_re => std_logic_vector(Delay2_out1_re),  -- sfix16_En14
              dataIn_im => std_logic_vector(Delay2_out1_im),  -- sfix16_En14
              frameDet => FrameDetect_out1,
              phaseIn => FrameDetect_out2,  -- sfix25_En22
              dataOut_re => CoarseFreqCorr_out1_re,  -- sfix16_En14
              dataOut_im => CoarseFreqCorr_out1_im,  -- sfix16_En14
              frameDetOut => CoarseFreqCorr_out2
              );

  u_Delay : ofdm_rx_src_Delay
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              data_re => CoarseFreqCorr_out1_re,  -- sfix16_En14
              data_im => CoarseFreqCorr_out1_im,  -- sfix16_En14
              strobe => CoarseFreqCorr_out2,
              dataOut_re => Delay_out1_re,  -- sfix16_En14
              dataOut_im => Delay_out1_im,  -- sfix16_En14
              strobeOut => Delay_out2
              );

  u_ControlSigGen : ofdm_rx_src_ControlSigGen
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              validIn => Delay_out2,
              FFTValid => ControlSigGen_out1,
              dataValid => ControlSigGen_out2,
              preambleValid => ControlSigGen_out3
              );

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  Delay1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay1_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay1_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay1_reg_im(0) <= dataIn_im_signed;
        Delay1_reg_im(1 TO 21) <= Delay1_reg_im(0 TO 20);
        Delay1_reg_re(0) <= dataIn_re_signed;
        Delay1_reg_re(1 TO 21) <= Delay1_reg_re(0 TO 20);
      END IF;
    END IF;
  END PROCESS Delay1_process;

  Delay1_out1_re <= Delay1_reg_re(21);
  Delay1_out1_im <= Delay1_reg_im(21);

  Delay2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay2_reg_re <= (OTHERS => to_signed(16#0000#, 16));
      Delay2_reg_im <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay2_reg_im(0) <= Delay1_out1_im;
        Delay2_reg_im(1) <= Delay2_reg_im(0);
        Delay2_reg_re(0) <= Delay1_out1_re;
        Delay2_reg_re(1) <= Delay2_reg_re(0);
      END IF;
    END IF;
  END PROCESS Delay2_process;

  Delay2_out1_re <= Delay2_reg_re(1);
  Delay2_out1_im <= Delay2_reg_im(1);

  Delay_out1_re_signed <= signed(Delay_out1_re);

  Delay_out1_im_signed <= signed(Delay_out1_im);

  Delay4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay4_out1_re <= to_signed(16#0000#, 16);
      Delay4_out1_im <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay4_out1_re <= Delay_out1_re_signed;
        Delay4_out1_im <= Delay_out1_im_signed;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  DataOut_re <= std_logic_vector(Delay4_out1_re);

  DataOut_im <= std_logic_vector(Delay4_out1_im);

  FFTValidOut <= ControlSigGen_out1;

  dataValid <= ControlSigGen_out2;

  preambleValid <= ControlSigGen_out3;

END rtl;

