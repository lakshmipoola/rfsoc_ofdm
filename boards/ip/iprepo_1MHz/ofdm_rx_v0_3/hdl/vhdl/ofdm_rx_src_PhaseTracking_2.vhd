-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Rx_HW\ofdm_rx_src_PhaseTracking_2.vhd
-- Created: 2021-05-05 14:38:24
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_rx_src_PhaseTracking_2
-- Source Path: OFDM_Rx_HW/OFDMRx/PhaseTracking_2
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_rx_src_PhaseTracking_2 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb_1_256_0                       :   IN    std_logic;
        enb_1_256_1                       :   IN    std_logic;
        dataIn_re                         :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        dataIn_im                         :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
        dataValidIn                       :   IN    std_logic;
        dataOut_re                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        dataOut_im                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        validOut                          :   OUT   std_logic
        );
END ofdm_rx_src_PhaseTracking_2;


ARCHITECTURE rtl OF ofdm_rx_src_PhaseTracking_2 IS

  -- Component Declarations
  COMPONENT ofdm_rx_src_PilotCtrlGen_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          enb_1_256_1                     :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          dataIn_im                       :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          ValidIn                         :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          dataOut_im                      :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          pilotOut_re                     :   OUT   std_logic_vector(1 DOWNTO 0);  -- sfix2
          pilotOut_im                     :   OUT   std_logic_vector(1 DOWNTO 0);  -- sfix2
          PilotEnd                        :   OUT   std_logic;
          dataValid                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_PhaseEst
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          enb_1_256_1                     :   IN    std_logic;
          dataIn_re                       :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          dataIn_im                       :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          PilotIn_re                      :   IN    std_logic_vector(1 DOWNTO 0);  -- sfix2
          PilotIn_im                      :   IN    std_logic_vector(1 DOWNTO 0);  -- sfix2
          pilotEnd                        :   IN    std_logic;
          dataValid                       :   IN    std_logic;
          dataOut_re                      :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          dataOut_im                      :   OUT   std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          phaseOut                        :   OUT   std_logic_vector(22 DOWNTO 0);  -- sfix23_En20
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ofdm_rx_src_CordicRotate_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb_1_256_0                     :   IN    std_logic;
          enb_1_256_1                     :   IN    std_logic;
          DataIn_re                       :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          DataIn_im                       :   IN    std_logic_vector(17 DOWNTO 0);  -- sfix18_En15
          PhaseIn                         :   IN    std_logic_vector(22 DOWNTO 0);  -- sfix23_En20
          validIn                         :   IN    std_logic;
          DataOut_re                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          DataOut_im                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_rx_src_PilotCtrlGen_block
    USE ENTITY work.ofdm_rx_src_PilotCtrlGen_block(rtl);

  FOR ALL : ofdm_rx_src_PhaseEst
    USE ENTITY work.ofdm_rx_src_PhaseEst(rtl);

  FOR ALL : ofdm_rx_src_CordicRotate_block
    USE ENTITY work.ofdm_rx_src_CordicRotate_block(rtl);

  -- Signals
  SIGNAL PilotCtrlGen_out1_re             : std_logic_vector(17 DOWNTO 0);  -- ufix18
  SIGNAL PilotCtrlGen_out1_im             : std_logic_vector(17 DOWNTO 0);  -- ufix18
  SIGNAL PilotCtrlGen_out2_re             : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL PilotCtrlGen_out2_im             : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL PilotCtrlGen_out3                : std_logic;
  SIGNAL PilotCtrlGen_out4                : std_logic;
  SIGNAL PhaseEst_out1_re                 : std_logic_vector(17 DOWNTO 0);  -- ufix18
  SIGNAL PhaseEst_out1_im                 : std_logic_vector(17 DOWNTO 0);  -- ufix18
  SIGNAL PhaseEst_out2                    : std_logic_vector(22 DOWNTO 0);  -- ufix23
  SIGNAL PhaseEst_out3                    : std_logic;
  SIGNAL CordicRotate_out1_re             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL CordicRotate_out1_im             : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL CordicRotate_out2                : std_logic;

BEGIN
  -- Phase Tracking Stage 2:  Track Common Phase Error (CPE) from symbol to symbol.
  -- CPE is caused by residual frequency offset and phase noise effects. 

  u_PilotCtrlGen : ofdm_rx_src_PilotCtrlGen_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_256_0 => enb_1_256_0,
              enb_1_256_1 => enb_1_256_1,
              dataIn_re => dataIn_re,  -- sfix18_En15
              dataIn_im => dataIn_im,  -- sfix18_En15
              ValidIn => dataValidIn,
              dataOut_re => PilotCtrlGen_out1_re,  -- sfix18_En15
              dataOut_im => PilotCtrlGen_out1_im,  -- sfix18_En15
              pilotOut_re => PilotCtrlGen_out2_re,  -- sfix2
              pilotOut_im => PilotCtrlGen_out2_im,  -- sfix2
              PilotEnd => PilotCtrlGen_out3,
              dataValid => PilotCtrlGen_out4
              );

  u_PhaseEst : ofdm_rx_src_PhaseEst
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_256_0 => enb_1_256_0,
              enb_1_256_1 => enb_1_256_1,
              dataIn_re => PilotCtrlGen_out1_re,  -- sfix18_En15
              dataIn_im => PilotCtrlGen_out1_im,  -- sfix18_En15
              PilotIn_re => PilotCtrlGen_out2_re,  -- sfix2
              PilotIn_im => PilotCtrlGen_out2_im,  -- sfix2
              pilotEnd => PilotCtrlGen_out3,
              dataValid => PilotCtrlGen_out4,
              dataOut_re => PhaseEst_out1_re,  -- sfix18_En15
              dataOut_im => PhaseEst_out1_im,  -- sfix18_En15
              phaseOut => PhaseEst_out2,  -- sfix23_En20
              validOut => PhaseEst_out3
              );

  u_CordicRotate : ofdm_rx_src_CordicRotate_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              enb_1_256_0 => enb_1_256_0,
              enb_1_256_1 => enb_1_256_1,
              DataIn_re => PhaseEst_out1_re,  -- sfix18_En15
              DataIn_im => PhaseEst_out1_im,  -- sfix18_En15
              PhaseIn => PhaseEst_out2,  -- sfix23_En20
              validIn => PhaseEst_out3,
              DataOut_re => CordicRotate_out1_re,  -- sfix16_En14
              DataOut_im => CordicRotate_out1_im,  -- sfix16_En14
              validOut => CordicRotate_out2
              );

  dataOut_re <= CordicRotate_out1_re;

  dataOut_im <= CordicRotate_out1_im;

  validOut <= CordicRotate_out2;

END rtl;

