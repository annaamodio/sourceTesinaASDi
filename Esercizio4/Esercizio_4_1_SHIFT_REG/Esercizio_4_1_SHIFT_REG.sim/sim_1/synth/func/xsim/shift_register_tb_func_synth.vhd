-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Wed Oct 12 14:54:00 2022
-- Host        : LAPTOP-L0BA6RC1 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/esempiVIVADO/4_SHIFTREG/4_SHIFTREG.sim/sim_1/synth/func/xsim/shift_register_tb_func_synth.vhd
-- Design      : shift_register
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7k70tfbv676-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity shift_register is
  port (
    CLK : in STD_LOGIC;
    RST : in STD_LOGIC;
    SI : in STD_LOGIC;
    SO : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of shift_register : entity is true;
end shift_register;

architecture STRUCTURE of shift_register is
  signal CLK_IBUF : STD_LOGIC;
  signal CLK_IBUF_BUFG : STD_LOGIC;
  signal RST_IBUF : STD_LOGIC;
  signal SI_IBUF : STD_LOGIC;
  signal SO_OBUF : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 3 downto 1 );
begin
CLK_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => CLK_IBUF,
      O => CLK_IBUF_BUFG
    );
CLK_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => CLK,
      O => CLK_IBUF
    );
RST_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => RST,
      O => RST_IBUF
    );
SI_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => SI,
      O => SI_IBUF
    );
SO_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => SO_OBUF,
      O => SO
    );
\tmp_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => SI_IBUF,
      Q => p_0_in(1),
      R => RST_IBUF
    );
\tmp_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => p_0_in(1),
      Q => p_0_in(2),
      R => RST_IBUF
    );
\tmp_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => p_0_in(2),
      Q => p_0_in(3),
      R => RST_IBUF
    );
\tmp_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_IBUF_BUFG,
      CE => '1',
      D => p_0_in(3),
      Q => SO_OBUF,
      R => RST_IBUF
    );
end STRUCTURE;
