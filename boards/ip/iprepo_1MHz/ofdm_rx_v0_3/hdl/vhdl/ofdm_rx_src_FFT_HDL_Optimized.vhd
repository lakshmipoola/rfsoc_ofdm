-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_FFT_HDL_Optimized.vhd
-- Created: 2021-05-06 12:53:37
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_FFT_HDL_Optimized
-- Source Path: OFDM_Rx_HW/OFDMRx/FFT/FFT HDL Optimized
-- Hierarchy Level: 2
-- 
-- FFT HDL Optimized
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_FFT_HDL_Optimized IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataIn_im                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validIn                           :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
        dataOut_im                        :   OUT   std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
        validOut                          :   OUT   std_logic
        );
END ofdm_rx_src_FFT_HDL_Optimized;


ARCHITECTURE rtl OF ofdm_rx_src_FFT_HDL_Optimized IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_RADIX22FFT_CTRL1_1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dinXTwdl_1_1_vld                :   IN    std_logic;
          dinXTwdl_1_1_vld_1              :   IN    std_logic;
          softReset                       :   IN    std_logic;
          rd_1_Addr                       :   OUT   std_logic_vector(4 DOWNTO 0);  -- ufix5
          rd_1_Enb                        :   OUT   std_logic;
          proc_1_enb                      :   OUT   std_logic;
          multiply_1_J                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_SDF1_1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          din_1_1_re_dly                  :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          din_1_1_im_dly                  :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          din_1_vld_dly                   :   IN    std_logic;
          rd_1_Addr                       :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          rd_1_Enb                        :   IN    std_logic;
          twdl_1_1_re                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_1_1_im                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_1_1_vld                    :   IN    std_logic;
          proc_1_enb                      :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_1_1_re                     :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dout_1_1_im                     :   OUT   std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dout_1_1_vld                    :   OUT   std_logic;
          dinXTwdl_1_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_CTRL1_2
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_1_1_vld                    :   IN    std_logic;
          dinXTwdl_2_1_vld                :   IN    std_logic;
          softReset                       :   IN    std_logic;
          rd_2_Addr                       :   OUT   std_logic_vector(3 DOWNTO 0);  -- ufix4
          rd_2_Enb                        :   OUT   std_logic;
          proc_2_enb                      :   OUT   std_logic;
          multiply_2_J                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_SDF2_2
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_1_1_re                     :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dout_1_1_im                     :   IN    std_logic_vector(16 DOWNTO 0);  -- sfix17_En14
          dout_1_1_vld                    :   IN    std_logic;
          rd_2_Addr                       :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          rd_2_Enb                        :   IN    std_logic;
          proc_2_enb                      :   IN    std_logic;
          multiply_2_J                    :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_2_1_re                     :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En14
          dout_2_1_im                     :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En14
          dout_2_1_vld                    :   OUT   std_logic;
          dinXTwdl_2_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_TWDLROM_3_1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_2_1_vld                    :   IN    std_logic;
          softReset                       :   IN    std_logic;
          twdl_3_1_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_3_1_im                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_3_1_vld                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_CTRL1_3
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dinXTwdl_3_1_vld                :   IN    std_logic;
          dinXTwdl_3_1_vld_1              :   IN    std_logic;
          softReset                       :   IN    std_logic;
          rd_3_Addr                       :   OUT   std_logic_vector(2 DOWNTO 0);  -- ufix3
          rd_3_Enb                        :   OUT   std_logic;
          proc_3_enb                      :   OUT   std_logic;
          multiply_3_J                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_SDF1_3
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          din_3_1_re_dly                  :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En14
          din_3_1_im_dly                  :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En14
          din_3_vld_dly                   :   IN    std_logic;
          rd_3_Addr                       :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          rd_3_Enb                        :   IN    std_logic;
          twdl_3_1_re                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_3_1_im                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_3_1_vld                    :   IN    std_logic;
          proc_3_enb                      :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_3_1_re                     :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En14
          dout_3_1_im                     :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En14
          dout_3_1_vld                    :   OUT   std_logic;
          dinXTwdl_3_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_CTRL1_4
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_3_1_vld                    :   IN    std_logic;
          dinXTwdl_4_1_vld                :   IN    std_logic;
          softReset                       :   IN    std_logic;
          rd_4_Addr                       :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          rd_4_Enb                        :   OUT   std_logic;
          proc_4_enb                      :   OUT   std_logic;
          multiply_4_J                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_SDF2_4
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_3_1_re                     :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En14
          dout_3_1_im                     :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En14
          dout_3_1_vld                    :   IN    std_logic;
          rd_4_Addr                       :   IN    std_logic_vector(1 DOWNTO 0);  -- ufix2
          rd_4_Enb                        :   IN    std_logic;
          proc_4_enb                      :   IN    std_logic;
          multiply_4_J                    :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_4_1_re                     :   OUT   std_logic_vector(19 DOWNTO 0);  -- sfix20_En14
          dout_4_1_im                     :   OUT   std_logic_vector(19 DOWNTO 0);  -- sfix20_En14
          dout_4_1_vld                    :   OUT   std_logic;
          dinXTwdl_4_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_TWDLROM_5_1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_4_1_vld                    :   IN    std_logic;
          softReset                       :   IN    std_logic;
          twdl_5_1_re                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_5_1_im                     :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_5_1_vld                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_CTRL1_5
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dinXTwdl_5_1_vld                :   IN    std_logic;
          dinXTwdl_5_1_vld_1              :   IN    std_logic;
          softReset                       :   IN    std_logic;
          rd_5_Addr                       :   OUT   std_logic;  -- ufix1
          rd_5_Enb                        :   OUT   std_logic;
          proc_5_enb                      :   OUT   std_logic;
          multiply_5_J                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_SDF1_5
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          din_5_1_re_dly                  :   IN    std_logic_vector(19 DOWNTO 0);  -- sfix20_En14
          din_5_1_im_dly                  :   IN    std_logic_vector(19 DOWNTO 0);  -- sfix20_En14
          din_5_vld_dly                   :   IN    std_logic;
          rd_5_Addr                       :   IN    std_logic;  -- ufix1
          rd_5_Enb                        :   IN    std_logic;
          twdl_5_1_re                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_5_1_im                     :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          twdl_5_1_vld                    :   IN    std_logic;
          proc_5_enb                      :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_5_1_re                     :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En14
          dout_5_1_im                     :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En14
          dout_5_1_vld                    :   OUT   std_logic;
          dinXTwdl_5_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_CTRL1_6
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_5_1_vld                    :   IN    std_logic;
          dinXTwdl_6_1_vld                :   IN    std_logic;
          softReset                       :   IN    std_logic;
          rd_6_Addr                       :   OUT   std_logic;
          rd_6_Enb                        :   OUT   std_logic;
          proc_6_enb                      :   OUT   std_logic;
          multiply_6_J                    :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX22FFT_SDF2_6
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_5_1_re                     :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En14
          dout_5_1_im                     :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En14
          dout_5_1_vld                    :   IN    std_logic;
          rd_6_Addr                       :   IN    std_logic;
          rd_6_Enb                        :   IN    std_logic;
          proc_6_enb                      :   IN    std_logic;
          multiply_6_J                    :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_6_1_re                     :   OUT   std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          dout_6_1_im                     :   OUT   std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          dout_6_1_vld                    :   OUT   std_logic;
          dinXTwdl_6_1_vld                :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_RADIX2FFT_bitNatural
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          dout_6_1_re                     :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          dout_6_1_im                     :   IN    std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          dout_6_1_vld                    :   IN    std_logic;
          softReset                       :   IN    std_logic;
          dout_re1                        :   OUT   std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          dout_im1                        :   OUT   std_logic_vector(21 DOWNTO 0);  -- sfix22_En14
          dout_vld1                       :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_RADIX22FFT_CTRL1_1
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_CTRL1_1(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_SDF1_1
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_SDF1_1(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_CTRL1_2
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_CTRL1_2(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_SDF2_2
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_SDF2_2(rtl);

  FOR ALL : ofdm_rx_src_TWDLROM_3_1
    USE ENTITY work.ofdm_rx_src_TWDLROM_3_1(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_CTRL1_3
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_CTRL1_3(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_SDF1_3
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_SDF1_3(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_CTRL1_4
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_CTRL1_4(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_SDF2_4
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_SDF2_4(rtl);

  FOR ALL : ofdm_rx_src_TWDLROM_5_1
    USE ENTITY work.ofdm_rx_src_TWDLROM_5_1(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_CTRL1_5
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_CTRL1_5(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_SDF1_5
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_SDF1_5(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_CTRL1_6
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_CTRL1_6(rtl);

  FOR ALL : ofdm_rx_src_RADIX22FFT_SDF2_6
    USE ENTITY work.ofdm_rx_src_RADIX22FFT_SDF2_6(rtl);

  FOR ALL : ofdm_rx_src_RADIX2FFT_bitNatural
    USE ENTITY work.ofdm_rx_src_RADIX2FFT_bitNatural(rtl);

  -- Signals
  SIGNAL softReset                        : std_logic;
  SIGNAL dataIn_re_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL dataIn_im_signed                 : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL intdelay_reg                     : vector_of_signed16(0 TO 2);  -- sfix16 [3]
  SIGNAL din_1_1_re_dly                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL intdelay_reg_1                   : vector_of_signed16(0 TO 2);  -- sfix16 [3]
  SIGNAL din_1_1_im_dly                   : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL intdelay_reg_2                   : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL din_1_vld_dly                    : std_logic;
  SIGNAL twdl_1_1_re                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL twdl_1_1_im                      : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL intdelay_reg_3                   : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL twdl_1_1_vld                     : std_logic;
  SIGNAL dinXTwdl_1_1_vld                 : std_logic;
  SIGNAL rd_1_Addr                        : std_logic_vector(4 DOWNTO 0);  -- ufix5
  SIGNAL rd_1_Enb                         : std_logic;
  SIGNAL proc_1_enb                       : std_logic;
  SIGNAL multiply_1_J                     : std_logic;
  SIGNAL dout_1_1_re                      : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL dout_1_1_im                      : std_logic_vector(16 DOWNTO 0);  -- ufix17
  SIGNAL dout_1_1_vld                     : std_logic;
  SIGNAL dinXTwdl_2_1_vld                 : std_logic;
  SIGNAL rd_2_Addr                        : std_logic_vector(3 DOWNTO 0);  -- ufix4
  SIGNAL rd_2_Enb                         : std_logic;
  SIGNAL proc_2_enb                       : std_logic;
  SIGNAL multiply_2_J                     : std_logic;
  SIGNAL dout_2_1_re                      : std_logic_vector(17 DOWNTO 0);  -- ufix18
  SIGNAL dout_2_1_im                      : std_logic_vector(17 DOWNTO 0);  -- ufix18
  SIGNAL dout_2_1_vld                     : std_logic;
  SIGNAL dout_2_1_re_signed               : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL dout_2_1_im_signed               : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL intdelay_reg_4                   : vector_of_signed18(0 TO 2);  -- sfix18 [3]
  SIGNAL din_3_1_re_dly                   : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL intdelay_reg_5                   : vector_of_signed18(0 TO 2);  -- sfix18 [3]
  SIGNAL din_3_1_im_dly                   : signed(17 DOWNTO 0);  -- sfix18_En14
  SIGNAL intdelay_reg_6                   : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL din_3_vld_dly                    : std_logic;
  SIGNAL twdl_3_1_re                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL twdl_3_1_im                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL twdl_3_1_vld                     : std_logic;
  SIGNAL dinXTwdl_3_1_vld                 : std_logic;
  SIGNAL rd_3_Addr                        : std_logic_vector(2 DOWNTO 0);  -- ufix3
  SIGNAL rd_3_Enb                         : std_logic;
  SIGNAL proc_3_enb                       : std_logic;
  SIGNAL multiply_3_J                     : std_logic;
  SIGNAL dout_3_1_re                      : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL dout_3_1_im                      : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL dout_3_1_vld                     : std_logic;
  SIGNAL dinXTwdl_4_1_vld                 : std_logic;
  SIGNAL rd_4_Addr                        : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL rd_4_Enb                         : std_logic;
  SIGNAL proc_4_enb                       : std_logic;
  SIGNAL multiply_4_J                     : std_logic;
  SIGNAL dout_4_1_re                      : std_logic_vector(19 DOWNTO 0);  -- ufix20
  SIGNAL dout_4_1_im                      : std_logic_vector(19 DOWNTO 0);  -- ufix20
  SIGNAL dout_4_1_vld                     : std_logic;
  SIGNAL dout_4_1_re_signed               : signed(19 DOWNTO 0);  -- sfix20_En14
  SIGNAL dout_4_1_im_signed               : signed(19 DOWNTO 0);  -- sfix20_En14
  SIGNAL intdelay_reg_7                   : vector_of_signed20(0 TO 2);  -- sfix20 [3]
  SIGNAL din_5_1_re_dly                   : signed(19 DOWNTO 0);  -- sfix20_En14
  SIGNAL intdelay_reg_8                   : vector_of_signed20(0 TO 2);  -- sfix20 [3]
  SIGNAL din_5_1_im_dly                   : signed(19 DOWNTO 0);  -- sfix20_En14
  SIGNAL intdelay_reg_9                   : std_logic_vector(0 TO 2);  -- ufix1 [3]
  SIGNAL din_5_vld_dly                    : std_logic;
  SIGNAL twdl_5_1_re                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL twdl_5_1_im                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL twdl_5_1_vld                     : std_logic;
  SIGNAL dinXTwdl_5_1_vld                 : std_logic;
  SIGNAL rd_5_Addr                        : std_logic;  -- ufix1
  SIGNAL rd_5_Enb                         : std_logic;
  SIGNAL proc_5_enb                       : std_logic;
  SIGNAL multiply_5_J                     : std_logic;
  SIGNAL dout_5_1_re                      : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL dout_5_1_im                      : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL dout_5_1_vld                     : std_logic;
  SIGNAL dinXTwdl_6_1_vld                 : std_logic;
  SIGNAL rd_6_Addr                        : std_logic;
  SIGNAL rd_6_Enb                         : std_logic;
  SIGNAL proc_6_enb                       : std_logic;
  SIGNAL multiply_6_J                     : std_logic;
  SIGNAL dout_6_1_re                      : std_logic_vector(21 DOWNTO 0);  -- ufix22
  SIGNAL dout_6_1_im                      : std_logic_vector(21 DOWNTO 0);  -- ufix22
  SIGNAL dout_6_1_vld                     : std_logic;
  SIGNAL dout_re1                         : std_logic_vector(21 DOWNTO 0);  -- ufix22
  SIGNAL dout_im1                         : std_logic_vector(21 DOWNTO 0);  -- ufix22
  SIGNAL dout_vld1                        : std_logic;

BEGIN
  u_CTRL1_1_1 : ofdm_rx_src_RADIX22FFT_CTRL1_1
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dinXTwdl_1_1_vld => dinXTwdl_1_1_vld,
              dinXTwdl_1_1_vld_1 => dinXTwdl_1_1_vld,
              softReset => softReset,
              rd_1_Addr => rd_1_Addr,  -- ufix5
              rd_1_Enb => rd_1_Enb,
              proc_1_enb => proc_1_enb,
              multiply_1_J => multiply_1_J
              );

  u_SDF1_1_1 : ofdm_rx_src_RADIX22FFT_SDF1_1
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              din_1_1_re_dly => std_logic_vector(din_1_1_re_dly),  -- sfix16_En14
              din_1_1_im_dly => std_logic_vector(din_1_1_im_dly),  -- sfix16_En14
              din_1_vld_dly => din_1_vld_dly,
              rd_1_Addr => rd_1_Addr,  -- ufix5
              rd_1_Enb => rd_1_Enb,
              twdl_1_1_re => std_logic_vector(twdl_1_1_re),  -- sfix16_En14
              twdl_1_1_im => std_logic_vector(twdl_1_1_im),  -- sfix16_En14
              twdl_1_1_vld => twdl_1_1_vld,
              proc_1_enb => proc_1_enb,
              softReset => softReset,
              dout_1_1_re => dout_1_1_re,  -- sfix17_En14
              dout_1_1_im => dout_1_1_im,  -- sfix17_En14
              dout_1_1_vld => dout_1_1_vld,
              dinXTwdl_1_1_vld => dinXTwdl_1_1_vld
              );

  u_CTRL2_2_1 : ofdm_rx_src_RADIX22FFT_CTRL1_2
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_1_1_vld => dout_1_1_vld,
              dinXTwdl_2_1_vld => dinXTwdl_2_1_vld,
              softReset => softReset,
              rd_2_Addr => rd_2_Addr,  -- ufix4
              rd_2_Enb => rd_2_Enb,
              proc_2_enb => proc_2_enb,
              multiply_2_J => multiply_2_J
              );

  u_SDF2_2_1 : ofdm_rx_src_RADIX22FFT_SDF2_2
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_1_1_re => dout_1_1_re,  -- sfix17_En14
              dout_1_1_im => dout_1_1_im,  -- sfix17_En14
              dout_1_1_vld => dout_1_1_vld,
              rd_2_Addr => rd_2_Addr,  -- ufix4
              rd_2_Enb => rd_2_Enb,
              proc_2_enb => proc_2_enb,
              multiply_2_J => multiply_2_J,
              softReset => softReset,
              dout_2_1_re => dout_2_1_re,  -- sfix18_En14
              dout_2_1_im => dout_2_1_im,  -- sfix18_En14
              dout_2_1_vld => dout_2_1_vld,
              dinXTwdl_2_1_vld => dinXTwdl_2_1_vld
              );

  u_twdlROM_3_1 : ofdm_rx_src_TWDLROM_3_1
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_2_1_vld => dout_2_1_vld,
              softReset => softReset,
              twdl_3_1_re => twdl_3_1_re,  -- sfix16_En14
              twdl_3_1_im => twdl_3_1_im,  -- sfix16_En14
              twdl_3_1_vld => twdl_3_1_vld
              );

  u_CTRL1_3_1 : ofdm_rx_src_RADIX22FFT_CTRL1_3
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dinXTwdl_3_1_vld => dinXTwdl_3_1_vld,
              dinXTwdl_3_1_vld_1 => dinXTwdl_3_1_vld,
              softReset => softReset,
              rd_3_Addr => rd_3_Addr,  -- ufix3
              rd_3_Enb => rd_3_Enb,
              proc_3_enb => proc_3_enb,
              multiply_3_J => multiply_3_J
              );

  u_SDF1_3_1 : ofdm_rx_src_RADIX22FFT_SDF1_3
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              din_3_1_re_dly => std_logic_vector(din_3_1_re_dly),  -- sfix18_En14
              din_3_1_im_dly => std_logic_vector(din_3_1_im_dly),  -- sfix18_En14
              din_3_vld_dly => din_3_vld_dly,
              rd_3_Addr => rd_3_Addr,  -- ufix3
              rd_3_Enb => rd_3_Enb,
              twdl_3_1_re => twdl_3_1_re,  -- sfix16_En14
              twdl_3_1_im => twdl_3_1_im,  -- sfix16_En14
              twdl_3_1_vld => twdl_3_1_vld,
              proc_3_enb => proc_3_enb,
              softReset => softReset,
              dout_3_1_re => dout_3_1_re,  -- sfix19_En14
              dout_3_1_im => dout_3_1_im,  -- sfix19_En14
              dout_3_1_vld => dout_3_1_vld,
              dinXTwdl_3_1_vld => dinXTwdl_3_1_vld
              );

  u_CTRL2_4_1 : ofdm_rx_src_RADIX22FFT_CTRL1_4
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_3_1_vld => dout_3_1_vld,
              dinXTwdl_4_1_vld => dinXTwdl_4_1_vld,
              softReset => softReset,
              rd_4_Addr => rd_4_Addr,  -- ufix2
              rd_4_Enb => rd_4_Enb,
              proc_4_enb => proc_4_enb,
              multiply_4_J => multiply_4_J
              );

  u_SDF2_4_1 : ofdm_rx_src_RADIX22FFT_SDF2_4
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_3_1_re => dout_3_1_re,  -- sfix19_En14
              dout_3_1_im => dout_3_1_im,  -- sfix19_En14
              dout_3_1_vld => dout_3_1_vld,
              rd_4_Addr => rd_4_Addr,  -- ufix2
              rd_4_Enb => rd_4_Enb,
              proc_4_enb => proc_4_enb,
              multiply_4_J => multiply_4_J,
              softReset => softReset,
              dout_4_1_re => dout_4_1_re,  -- sfix20_En14
              dout_4_1_im => dout_4_1_im,  -- sfix20_En14
              dout_4_1_vld => dout_4_1_vld,
              dinXTwdl_4_1_vld => dinXTwdl_4_1_vld
              );

  u_twdlROM_5_1 : ofdm_rx_src_TWDLROM_5_1
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_4_1_vld => dout_4_1_vld,
              softReset => softReset,
              twdl_5_1_re => twdl_5_1_re,  -- sfix16_En14
              twdl_5_1_im => twdl_5_1_im,  -- sfix16_En14
              twdl_5_1_vld => twdl_5_1_vld
              );

  u_CTRL1_5_1 : ofdm_rx_src_RADIX22FFT_CTRL1_5
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dinXTwdl_5_1_vld => dinXTwdl_5_1_vld,
              dinXTwdl_5_1_vld_1 => dinXTwdl_5_1_vld,
              softReset => softReset,
              rd_5_Addr => rd_5_Addr,  -- ufix1
              rd_5_Enb => rd_5_Enb,
              proc_5_enb => proc_5_enb,
              multiply_5_J => multiply_5_J
              );

  u_SDF1_5_1 : ofdm_rx_src_RADIX22FFT_SDF1_5
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              din_5_1_re_dly => std_logic_vector(din_5_1_re_dly),  -- sfix20_En14
              din_5_1_im_dly => std_logic_vector(din_5_1_im_dly),  -- sfix20_En14
              din_5_vld_dly => din_5_vld_dly,
              rd_5_Addr => rd_5_Addr,  -- ufix1
              rd_5_Enb => rd_5_Enb,
              twdl_5_1_re => twdl_5_1_re,  -- sfix16_En14
              twdl_5_1_im => twdl_5_1_im,  -- sfix16_En14
              twdl_5_1_vld => twdl_5_1_vld,
              proc_5_enb => proc_5_enb,
              softReset => softReset,
              dout_5_1_re => dout_5_1_re,  -- sfix21_En14
              dout_5_1_im => dout_5_1_im,  -- sfix21_En14
              dout_5_1_vld => dout_5_1_vld,
              dinXTwdl_5_1_vld => dinXTwdl_5_1_vld
              );

  u_CTRL2_6_1 : ofdm_rx_src_RADIX22FFT_CTRL1_6
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_5_1_vld => dout_5_1_vld,
              dinXTwdl_6_1_vld => dinXTwdl_6_1_vld,
              softReset => softReset,
              rd_6_Addr => rd_6_Addr,
              rd_6_Enb => rd_6_Enb,
              proc_6_enb => proc_6_enb,
              multiply_6_J => multiply_6_J
              );

  u_SDF2_6_1 : ofdm_rx_src_RADIX22FFT_SDF2_6
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_5_1_re => dout_5_1_re,  -- sfix21_En14
              dout_5_1_im => dout_5_1_im,  -- sfix21_En14
              dout_5_1_vld => dout_5_1_vld,
              rd_6_Addr => rd_6_Addr,
              rd_6_Enb => rd_6_Enb,
              proc_6_enb => proc_6_enb,
              multiply_6_J => multiply_6_J,
              softReset => softReset,
              dout_6_1_re => dout_6_1_re,  -- sfix22_En14
              dout_6_1_im => dout_6_1_im,  -- sfix22_En14
              dout_6_1_vld => dout_6_1_vld,
              dinXTwdl_6_1_vld => dinXTwdl_6_1_vld
              );

  u_NaturalOrder_Stage : ofdm_rx_src_RADIX2FFT_bitNatural
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              dout_6_1_re => dout_6_1_re,  -- sfix22_En14
              dout_6_1_im => dout_6_1_im,  -- sfix22_En14
              dout_6_1_vld => dout_6_1_vld,
              softReset => softReset,
              dout_re1 => dout_re1,  -- sfix22_En14
              dout_im1 => dout_im1,  -- sfix22_En14
              dout_vld1 => dout_vld1
              );

  softReset <= '0';

  dataIn_re_signed <= signed(dataIn_re);

  dataIn_im_signed <= signed(dataIn_im);

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg <= (OTHERS => to_signed(16#0000#, 16));
        ELSE 
          intdelay_reg(0) <= dataIn_re_signed;
          intdelay_reg(1 TO 2) <= intdelay_reg(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_process;

  din_1_1_re_dly <= intdelay_reg(2);

  intdelay_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_1 <= (OTHERS => to_signed(16#0000#, 16));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_1 <= (OTHERS => to_signed(16#0000#, 16));
        ELSE 
          intdelay_reg_1(0) <= dataIn_im_signed;
          intdelay_reg_1(1 TO 2) <= intdelay_reg_1(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_1_process;

  din_1_1_im_dly <= intdelay_reg_1(2);

  intdelay_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_2 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_2 <= (OTHERS => '0');
        ELSE 
          intdelay_reg_2(0) <= validIn;
          intdelay_reg_2(1 TO 2) <= intdelay_reg_2(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_2_process;

  din_1_vld_dly <= intdelay_reg_2(2);

  twdl_1_1_re <= to_signed(16#4000#, 16);

  twdl_1_1_im <= to_signed(16#0000#, 16);

  intdelay_3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_3 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_3 <= (OTHERS => '0');
        ELSE 
          intdelay_reg_3(0) <= validIn;
          intdelay_reg_3(1 TO 2) <= intdelay_reg_3(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_3_process;

  twdl_1_1_vld <= intdelay_reg_3(2);

  dout_2_1_re_signed <= signed(dout_2_1_re);

  dout_2_1_im_signed <= signed(dout_2_1_im);

  intdelay_4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_4 <= (OTHERS => to_signed(16#00000#, 18));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_4 <= (OTHERS => to_signed(16#00000#, 18));
        ELSE 
          intdelay_reg_4(0) <= dout_2_1_re_signed;
          intdelay_reg_4(1 TO 2) <= intdelay_reg_4(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_4_process;

  din_3_1_re_dly <= intdelay_reg_4(2);

  intdelay_5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_5 <= (OTHERS => to_signed(16#00000#, 18));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_5 <= (OTHERS => to_signed(16#00000#, 18));
        ELSE 
          intdelay_reg_5(0) <= dout_2_1_im_signed;
          intdelay_reg_5(1 TO 2) <= intdelay_reg_5(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_5_process;

  din_3_1_im_dly <= intdelay_reg_5(2);

  intdelay_6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_6 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_6 <= (OTHERS => '0');
        ELSE 
          intdelay_reg_6(0) <= dout_2_1_vld;
          intdelay_reg_6(1 TO 2) <= intdelay_reg_6(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_6_process;

  din_3_vld_dly <= intdelay_reg_6(2);

  dout_4_1_re_signed <= signed(dout_4_1_re);

  dout_4_1_im_signed <= signed(dout_4_1_im);

  intdelay_7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_7 <= (OTHERS => to_signed(16#00000#, 20));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_7 <= (OTHERS => to_signed(16#00000#, 20));
        ELSE 
          intdelay_reg_7(0) <= dout_4_1_re_signed;
          intdelay_reg_7(1 TO 2) <= intdelay_reg_7(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_7_process;

  din_5_1_re_dly <= intdelay_reg_7(2);

  intdelay_8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_8 <= (OTHERS => to_signed(16#00000#, 20));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_8 <= (OTHERS => to_signed(16#00000#, 20));
        ELSE 
          intdelay_reg_8(0) <= dout_4_1_im_signed;
          intdelay_reg_8(1 TO 2) <= intdelay_reg_8(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_8_process;

  din_5_1_im_dly <= intdelay_reg_8(2);

  intdelay_9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      intdelay_reg_9 <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        IF softReset = '1' THEN
          intdelay_reg_9 <= (OTHERS => '0');
        ELSE 
          intdelay_reg_9(0) <= dout_4_1_vld;
          intdelay_reg_9(1 TO 2) <= intdelay_reg_9(0 TO 1);
        END IF;
      END IF;
    END IF;
  END PROCESS intdelay_9_process;

  din_5_vld_dly <= intdelay_reg_9(2);

  dataOut_re <= dout_re1;

  dataOut_im <= dout_im1;

  validOut <= dout_vld1;

END rtl;

