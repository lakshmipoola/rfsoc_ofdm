-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\OFDM_Tx_HW\ofdm_tx_dut.vhd
-- Created: 2021-05-05 22:15:56
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ofdm_tx_dut
-- Source Path: ofdm_tx/ofdm_tx_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ofdm_tx_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        modScheme                         :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        enable                            :   IN    std_logic;  -- ufix1
        gain                              :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        ce_out                            :   OUT   std_logic;  -- ufix1
        data                              :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        valid                             :   OUT   std_logic  -- ufix1
        );
END ofdm_tx_dut;


ARCHITECTURE rtl OF ofdm_tx_dut IS

  -- Component Declarations
  COMPONENT ofdm_tx_src_OFDMTx
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          modScheme                       :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          enable                          :   IN    std_logic;  -- ufix1
          gain                            :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          ce_out                          :   OUT   std_logic;  -- ufix1
          data                            :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          valid                           :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ofdm_tx_src_OFDMTx
    USE ENTITY work.ofdm_tx_src_OFDMTx(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL enable_sig                       : std_logic;  -- ufix1
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL data_sig                         : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL valid_sig                        : std_logic;  -- ufix1

BEGIN
  u_ofdm_tx_src_OFDMTx : ofdm_tx_src_OFDMTx
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              modScheme => modScheme,  -- ufix32
              enable => enable_sig,  -- ufix1
              gain => gain,  -- ufix32
              ce_out => ce_out_sig,  -- ufix1
              data => data_sig,  -- ufix32
              valid => valid_sig  -- ufix1
              );

  enable_sig <= enable;

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  data <= data_sig;

  valid <= valid_sig;

END rtl;

