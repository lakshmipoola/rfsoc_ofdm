-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_Complex_to_Magnitude_Angle_HDL_Optimized.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_Complex_to_Magnitude_Angle_HDL_Optimized
-- Source Path: OFDM_Rx_HW/OFDMRx/Synchronisation/SchmidlCoxMetric /MagPhase/Complex to Magnitude-Angle HDL Optimized
-- Hierarchy Level: 4
-- 
-- Complex to Magnitude-Angle HDL Optimized
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ofdm_rx_src_OFDMRx_pkg.ALL;

ENTITY ofdm_rx_src_Complex_to_Magnitude_Angle_HDL_Optimized IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        In_re                             :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En16
        In_im                             :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En16
        validIn                           :   IN    std_logic;
        magnitude                         :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
        angle                             :   OUT   std_logic_vector(20 DOWNTO 0);  -- sfix21_En20
        validOut                          :   OUT   std_logic
        );
END ofdm_rx_src_Complex_to_Magnitude_Angle_HDL_Optimized;


ARCHITECTURE rtl OF ofdm_rx_src_Complex_to_Magnitude_Angle_HDL_Optimized IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_Quadrant_Mapper_block1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          xin                             :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          yin                             :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          xout                            :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          yout                            :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          QA_Control                      :   OUT   std_logic_vector(2 DOWNTO 0)  -- ufix3
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_CordicKernelMag_block19
    PORT( xin                             :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          yin                             :   IN    std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          zin                             :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En20
          lut_value                       :   IN    std_logic_vector(17 DOWNTO 0);  -- ufix18_En20
          idx                             :   IN    std_logic_vector(4 DOWNTO 0);  -- ufix5
          xout                            :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          yout                            :   OUT   std_logic_vector(18 DOWNTO 0);  -- sfix19_En16
          zout                            :   OUT   std_logic_vector(20 DOWNTO 0)  -- sfix21_En20
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_Quadrant_Correction_block1
    PORT( zin                             :   IN    std_logic_vector(20 DOWNTO 0);  -- sfix21_En20
          QA_Control                      :   IN    std_logic_vector(2 DOWNTO 0);  -- ufix3
          zout                            :   OUT   std_logic_vector(20 DOWNTO 0)  -- sfix21_En20
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_Quadrant_Mapper_block1
    USE ENTITY work.ofdm_rx_src_Quadrant_Mapper_block1(rtl);

  FOR ALL : ofdm_rx_src_CordicKernelMag_block19
    USE ENTITY work.ofdm_rx_src_CordicKernelMag_block19(rtl);

  FOR ALL : ofdm_rx_src_Quadrant_Correction_block1
    USE ENTITY work.ofdm_rx_src_Quadrant_Correction_block1(rtl);

  -- Signals
  SIGNAL Delay_ValidIn_reg                : std_logic_vector(0 TO 12);  -- ufix1 [13]
  SIGNAL ValidOutDelayed                  : std_logic;
  SIGNAL reset_out                        : std_logic;
  SIGNAL In_re_signed                     : signed(17 DOWNTO 0);  -- sfix18_En16
  SIGNAL In_im_signed                     : signed(17 DOWNTO 0);  -- sfix18_En16
  SIGNAL qMapReal                         : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL qMapImag                         : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL In1Register                      : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL In2Register                      : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL XQMapped                         : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yQMapped                         : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL ControlQC                        : std_logic_vector(2 DOWNTO 0);  -- ufix3
  SIGNAL XQMapped_signed                  : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yQMapped_signed                  : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL xin1                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin1                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin1                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value1                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift1                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout1                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout1                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout1                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout1_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout1_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout1_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin2                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin2                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin2                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value2                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift2                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout2                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout2                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout2                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout2_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout2_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout2_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin3                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin3                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin3                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value3                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift3                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout3                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout3                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout3                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout3_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout3_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout3_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin4                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin4                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin4                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value4                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift4                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout4                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout4                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout4                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout4_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout4_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout4_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin5                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin5                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin5                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value5                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift5                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout5                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout5                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout5                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout5_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout5_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout5_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin6                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin6                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin6                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value6                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift6                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout6                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout6                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout6                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout6_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout6_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout6_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin7                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin7                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin7                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value7                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift7                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout7                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout7                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout7                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout7_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout7_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout7_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin8                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin8                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin8                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value8                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift8                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout8                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout8                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout8                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout8_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout8_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout8_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin9                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin9                             : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin9                             : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value9                       : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift9                           : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout9                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout9                            : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout9                            : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout9_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yout9_signed                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout9_signed                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL xin10                            : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL yin10                            : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zin10                            : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL lut_value10                      : unsigned(17 DOWNTO 0);  -- ufix18_En20
  SIGNAL shift10                          : unsigned(4 DOWNTO 0);  -- ufix5
  SIGNAL xout10                           : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL yout10                           : std_logic_vector(18 DOWNTO 0);  -- ufix19
  SIGNAL zout10                           : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL xout10_signed                    : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL xin11                            : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL CSD_Gain_Factor_mul_temp         : signed(34 DOWNTO 0);  -- sfix35_En31
  SIGNAL CSD_Gain_Factor_cast             : signed(33 DOWNTO 0);  -- sfix34_En31
  SIGNAL xoutscaled                       : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zeroC                            : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL outSwitchMag                     : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL xin12                            : signed(18 DOWNTO 0);  -- sfix19_En16
  SIGNAL zout10_signed                    : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL ControlQC_unsigned               : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL zin11                            : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL DelayQC_Control_reg              : vector_of_unsigned3(0 TO 10);  -- ufix3 [11]
  SIGNAL ControlQCDelay                   : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL zout_corrected                   : std_logic_vector(20 DOWNTO 0);  -- ufix21
  SIGNAL zout_corrected_signed            : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL zeroCA                           : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL outSwitchAng                     : signed(20 DOWNTO 0);  -- sfix21_En20
  SIGNAL zout_corrected_1                 : signed(20 DOWNTO 0);  -- sfix21_En20

BEGIN
  u_QuadrantMapper : ofdm_rx_src_Quadrant_Mapper_block1
    PORT MAP( clk => clk,
              reset => reset,
              enb_1_256_0 => enb_1_256_0,
              xin => std_logic_vector(In1Register),  -- sfix19_En16
              yin => std_logic_vector(In2Register),  -- sfix19_En16
              xout => XQMapped,  -- sfix19_En16
              yout => yQMapped,  -- sfix19_En16
              QA_Control => ControlQC  -- ufix3
              );

  u_Iteration : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin1),  -- sfix19_En16
              yin => std_logic_vector(yin1),  -- sfix19_En16
              zin => std_logic_vector(zin1),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value1),  -- ufix18_En20
              idx => std_logic_vector(shift1),  -- ufix5
              xout => xout1,  -- sfix19_En16
              yout => yout1,  -- sfix19_En16
              zout => zout1  -- sfix21_En20
              );

  u_Iteration_1 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin2),  -- sfix19_En16
              yin => std_logic_vector(yin2),  -- sfix19_En16
              zin => std_logic_vector(zin2),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value2),  -- ufix18_En20
              idx => std_logic_vector(shift2),  -- ufix5
              xout => xout2,  -- sfix19_En16
              yout => yout2,  -- sfix19_En16
              zout => zout2  -- sfix21_En20
              );

  u_Iteration_2 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin3),  -- sfix19_En16
              yin => std_logic_vector(yin3),  -- sfix19_En16
              zin => std_logic_vector(zin3),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value3),  -- ufix18_En20
              idx => std_logic_vector(shift3),  -- ufix5
              xout => xout3,  -- sfix19_En16
              yout => yout3,  -- sfix19_En16
              zout => zout3  -- sfix21_En20
              );

  u_Iteration_3 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin4),  -- sfix19_En16
              yin => std_logic_vector(yin4),  -- sfix19_En16
              zin => std_logic_vector(zin4),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value4),  -- ufix18_En20
              idx => std_logic_vector(shift4),  -- ufix5
              xout => xout4,  -- sfix19_En16
              yout => yout4,  -- sfix19_En16
              zout => zout4  -- sfix21_En20
              );

  u_Iteration_4 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin5),  -- sfix19_En16
              yin => std_logic_vector(yin5),  -- sfix19_En16
              zin => std_logic_vector(zin5),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value5),  -- ufix18_En20
              idx => std_logic_vector(shift5),  -- ufix5
              xout => xout5,  -- sfix19_En16
              yout => yout5,  -- sfix19_En16
              zout => zout5  -- sfix21_En20
              );

  u_Iteration_5 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin6),  -- sfix19_En16
              yin => std_logic_vector(yin6),  -- sfix19_En16
              zin => std_logic_vector(zin6),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value6),  -- ufix18_En20
              idx => std_logic_vector(shift6),  -- ufix5
              xout => xout6,  -- sfix19_En16
              yout => yout6,  -- sfix19_En16
              zout => zout6  -- sfix21_En20
              );

  u_Iteration_6 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin7),  -- sfix19_En16
              yin => std_logic_vector(yin7),  -- sfix19_En16
              zin => std_logic_vector(zin7),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value7),  -- ufix18_En20
              idx => std_logic_vector(shift7),  -- ufix5
              xout => xout7,  -- sfix19_En16
              yout => yout7,  -- sfix19_En16
              zout => zout7  -- sfix21_En20
              );

  u_Iteration_7 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin8),  -- sfix19_En16
              yin => std_logic_vector(yin8),  -- sfix19_En16
              zin => std_logic_vector(zin8),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value8),  -- ufix18_En20
              idx => std_logic_vector(shift8),  -- ufix5
              xout => xout8,  -- sfix19_En16
              yout => yout8,  -- sfix19_En16
              zout => zout8  -- sfix21_En20
              );

  u_Iteration_8 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin9),  -- sfix19_En16
              yin => std_logic_vector(yin9),  -- sfix19_En16
              zin => std_logic_vector(zin9),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value9),  -- ufix18_En20
              idx => std_logic_vector(shift9),  -- ufix5
              xout => xout9,  -- sfix19_En16
              yout => yout9,  -- sfix19_En16
              zout => zout9  -- sfix21_En20
              );

  u_Iteration_9 : ofdm_rx_src_CordicKernelMag_block19
    PORT MAP( xin => std_logic_vector(xin10),  -- sfix19_En16
              yin => std_logic_vector(yin10),  -- sfix19_En16
              zin => std_logic_vector(zin10),  -- sfix21_En20
              lut_value => std_logic_vector(lut_value10),  -- ufix18_En20
              idx => std_logic_vector(shift10),  -- ufix5
              xout => xout10,  -- sfix19_En16
              yout => yout10,  -- sfix19_En16
              zout => zout10  -- sfix21_En20
              );

  u_QuadrantCorrection : ofdm_rx_src_Quadrant_Correction_block1
    PORT MAP( zin => std_logic_vector(zin11),  -- sfix21_En20
              QA_Control => std_logic_vector(ControlQCDelay),  -- ufix3
              zout => zout_corrected  -- sfix21_En20
              );

  Delay_ValidIn_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Delay_ValidIn_reg <= (OTHERS => '0');
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        Delay_ValidIn_reg(0) <= validIn;
        Delay_ValidIn_reg(1 TO 12) <= Delay_ValidIn_reg(0 TO 11);
      END IF;
    END IF;
  END PROCESS Delay_ValidIn_process;

  ValidOutDelayed <= Delay_ValidIn_reg(12);

  reset_out <=  NOT ValidOutDelayed;

  In_re_signed <= signed(In_re);

  qMapReal <= resize(In_re_signed, 19);

  In_im_signed <= signed(In_im);

  qMapImag <= resize(In_im_signed, 19);

  DelayRealInput_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      In1Register <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        In1Register <= qMapReal;
      END IF;
    END IF;
  END PROCESS DelayRealInput_process;


  DelayImagInput_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      In2Register <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        In2Register <= qMapImag;
      END IF;
    END IF;
  END PROCESS DelayImagInput_process;


  XQMapped_signed <= signed(XQMapped);

  yQMapped_signed <= signed(yQMapped);

  DelayQuadMapper1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin1 <= XQMapped_signed;
      END IF;
    END IF;
  END PROCESS DelayQuadMapper1_process;


  DelayQuadMapper2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin1 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin1 <= yQMapped_signed;
      END IF;
    END IF;
  END PROCESS DelayQuadMapper2_process;


  zin1 <= to_signed(16#000000#, 21);

  lut_value1 <= to_unsigned(16#25C81#, 18);

  shift1 <= to_unsigned(16#01#, 5);

  xout1_signed <= signed(xout1);

  yout1_signed <= signed(yout1);

  zout1_signed <= signed(zout1);

  Pipeline1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin2 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin2 <= xout1_signed;
      END IF;
    END IF;
  END PROCESS Pipeline1_process;


  Pipeline1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin2 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin2 <= yout1_signed;
      END IF;
    END IF;
  END PROCESS Pipeline1_1_process;


  Pipeline1_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin2 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin2 <= zout1_signed;
      END IF;
    END IF;
  END PROCESS Pipeline1_2_process;


  lut_value2 <= to_unsigned(16#13F67#, 18);

  shift2 <= to_unsigned(16#02#, 5);

  xout2_signed <= signed(xout2);

  yout2_signed <= signed(yout2);

  zout2_signed <= signed(zout2);

  Pipeline2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin3 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin3 <= xout2_signed;
      END IF;
    END IF;
  END PROCESS Pipeline2_process;


  Pipeline2_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin3 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin3 <= yout2_signed;
      END IF;
    END IF;
  END PROCESS Pipeline2_1_process;


  Pipeline2_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin3 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin3 <= zout2_signed;
      END IF;
    END IF;
  END PROCESS Pipeline2_2_process;


  lut_value3 <= to_unsigned(16#0A222#, 18);

  shift3 <= to_unsigned(16#03#, 5);

  xout3_signed <= signed(xout3);

  yout3_signed <= signed(yout3);

  zout3_signed <= signed(zout3);

  Pipeline3_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin4 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin4 <= xout3_signed;
      END IF;
    END IF;
  END PROCESS Pipeline3_process;


  Pipeline3_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin4 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin4 <= yout3_signed;
      END IF;
    END IF;
  END PROCESS Pipeline3_1_process;


  Pipeline3_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin4 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin4 <= zout3_signed;
      END IF;
    END IF;
  END PROCESS Pipeline3_2_process;


  lut_value4 <= to_unsigned(16#05162#, 18);

  shift4 <= to_unsigned(16#04#, 5);

  xout4_signed <= signed(xout4);

  yout4_signed <= signed(yout4);

  zout4_signed <= signed(zout4);

  Pipeline4_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin5 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin5 <= xout4_signed;
      END IF;
    END IF;
  END PROCESS Pipeline4_process;


  Pipeline4_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin5 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin5 <= yout4_signed;
      END IF;
    END IF;
  END PROCESS Pipeline4_1_process;


  Pipeline4_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin5 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin5 <= zout4_signed;
      END IF;
    END IF;
  END PROCESS Pipeline4_2_process;


  lut_value5 <= to_unsigned(16#028BB#, 18);

  shift5 <= to_unsigned(16#05#, 5);

  xout5_signed <= signed(xout5);

  yout5_signed <= signed(yout5);

  zout5_signed <= signed(zout5);

  Pipeline5_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin6 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin6 <= xout5_signed;
      END IF;
    END IF;
  END PROCESS Pipeline5_process;


  Pipeline5_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin6 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin6 <= yout5_signed;
      END IF;
    END IF;
  END PROCESS Pipeline5_1_process;


  Pipeline5_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin6 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin6 <= zout5_signed;
      END IF;
    END IF;
  END PROCESS Pipeline5_2_process;


  lut_value6 <= to_unsigned(16#0145F#, 18);

  shift6 <= to_unsigned(16#06#, 5);

  xout6_signed <= signed(xout6);

  yout6_signed <= signed(yout6);

  zout6_signed <= signed(zout6);

  Pipeline6_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin7 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin7 <= xout6_signed;
      END IF;
    END IF;
  END PROCESS Pipeline6_process;


  Pipeline6_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin7 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin7 <= yout6_signed;
      END IF;
    END IF;
  END PROCESS Pipeline6_1_process;


  Pipeline6_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin7 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin7 <= zout6_signed;
      END IF;
    END IF;
  END PROCESS Pipeline6_2_process;


  lut_value7 <= to_unsigned(16#00A30#, 18);

  shift7 <= to_unsigned(16#07#, 5);

  xout7_signed <= signed(xout7);

  yout7_signed <= signed(yout7);

  zout7_signed <= signed(zout7);

  Pipeline7_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin8 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin8 <= xout7_signed;
      END IF;
    END IF;
  END PROCESS Pipeline7_process;


  Pipeline7_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin8 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin8 <= yout7_signed;
      END IF;
    END IF;
  END PROCESS Pipeline7_1_process;


  Pipeline7_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin8 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin8 <= zout7_signed;
      END IF;
    END IF;
  END PROCESS Pipeline7_2_process;


  lut_value8 <= to_unsigned(16#00518#, 18);

  shift8 <= to_unsigned(16#08#, 5);

  xout8_signed <= signed(xout8);

  yout8_signed <= signed(yout8);

  zout8_signed <= signed(zout8);

  Pipeline8_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin9 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin9 <= xout8_signed;
      END IF;
    END IF;
  END PROCESS Pipeline8_process;


  Pipeline8_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin9 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin9 <= yout8_signed;
      END IF;
    END IF;
  END PROCESS Pipeline8_1_process;


  Pipeline8_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin9 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin9 <= zout8_signed;
      END IF;
    END IF;
  END PROCESS Pipeline8_2_process;


  lut_value9 <= to_unsigned(16#0028C#, 18);

  shift9 <= to_unsigned(16#09#, 5);

  xout9_signed <= signed(xout9);

  yout9_signed <= signed(yout9);

  zout9_signed <= signed(zout9);

  Pipeline9_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin10 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin10 <= xout9_signed;
      END IF;
    END IF;
  END PROCESS Pipeline9_process;


  Pipeline9_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      yin10 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        yin10 <= yout9_signed;
      END IF;
    END IF;
  END PROCESS Pipeline9_1_process;


  Pipeline9_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin10 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin10 <= zout9_signed;
      END IF;
    END IF;
  END PROCESS Pipeline9_2_process;


  lut_value10 <= to_unsigned(16#00146#, 18);

  shift10 <= to_unsigned(16#0A#, 5);

  xout10_signed <= signed(xout10);

  Pipeline10_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin11 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin11 <= xout10_signed;
      END IF;
    END IF;
  END PROCESS Pipeline10_process;


  -- CSD Encoding (28141) : 1001'001'00001'01'01; Cost (Adders) = 5
  CSD_Gain_Factor_mul_temp <= ((((resize(xin11 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 35) - resize(xin11 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 35)) - resize(xin11 & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0', 35)) - resize(xin11 & '0' & '0' & '0' & '0', 35)) - resize(xin11 & '0' & '0', 35)) + resize(xin11, 35);
  CSD_Gain_Factor_cast <= CSD_Gain_Factor_mul_temp(33 DOWNTO 0);
  xoutscaled <= CSD_Gain_Factor_cast(33 DOWNTO 15);

  zeroC <= to_signed(16#00000#, 19);

  
  outSwitchMag <= xoutscaled WHEN reset_out = '0' ELSE
      zeroC;

  Output_Register_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      xin12 <= to_signed(16#00000#, 19);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        xin12 <= outSwitchMag;
      END IF;
    END IF;
  END PROCESS Output_Register_process;


  magnitude <= std_logic_vector(xin12);

  zout10_signed <= signed(zout10);

  ControlQC_unsigned <= unsigned(ControlQC);

  Pipeline10_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zin11 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zin11 <= zout10_signed;
      END IF;
    END IF;
  END PROCESS Pipeline10_1_process;


  DelayQC_Control_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      DelayQC_Control_reg <= (OTHERS => to_unsigned(16#0#, 3));
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        DelayQC_Control_reg(0) <= ControlQC_unsigned;
        DelayQC_Control_reg(1 TO 10) <= DelayQC_Control_reg(0 TO 9);
      END IF;
    END IF;
  END PROCESS DelayQC_Control_process;

  ControlQCDelay <= DelayQC_Control_reg(10);

  zout_corrected_signed <= signed(zout_corrected);

  zeroCA <= to_signed(16#000000#, 21);

  
  outSwitchAng <= zout_corrected_signed WHEN reset_out = '0' ELSE
      zeroCA;

  Output_Register_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      zout_corrected_1 <= to_signed(16#000000#, 21);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        zout_corrected_1 <= outSwitchAng;
      END IF;
    END IF;
  END PROCESS Output_Register_1_process;


  angle <= std_logic_vector(zout_corrected_1);

  DelayValidOut_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      validOut <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb_1_256_0 = '1' THEN
        validOut <= ValidOutDelayed;
      END IF;
    END IF;
  END PROCESS DelayValidOut_process;


END rtl;

