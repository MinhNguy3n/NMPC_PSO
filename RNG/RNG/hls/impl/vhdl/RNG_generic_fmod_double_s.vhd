-- ==============================================================
-- Generated by Vitis HLS v2024.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RNG_generic_fmod_double_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    x : IN STD_LOGIC_VECTOR (63 downto 0);
    ap_return : OUT STD_LOGIC_VECTOR (63 downto 0) );
end;


architecture behav of RNG_generic_fmod_double_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (8 downto 0) := "000000010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (8 downto 0) := "000000100";
    constant ap_ST_fsm_state4 : STD_LOGIC_VECTOR (8 downto 0) := "000001000";
    constant ap_ST_fsm_state5 : STD_LOGIC_VECTOR (8 downto 0) := "000010000";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (8 downto 0) := "000100000";
    constant ap_ST_fsm_state7 : STD_LOGIC_VECTOR (8 downto 0) := "001000000";
    constant ap_ST_fsm_state8 : STD_LOGIC_VECTOR (8 downto 0) := "010000000";
    constant ap_ST_fsm_state9 : STD_LOGIC_VECTOR (8 downto 0) := "100000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_4 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000100";
    constant ap_const_lv32_5 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000101";
    constant ap_const_lv32_7 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000111";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_6 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000110";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv32_3 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000011";
    constant ap_const_lv32_3F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111111";
    constant ap_const_lv32_34 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000110100";
    constant ap_const_lv11_7FF : STD_LOGIC_VECTOR (10 downto 0) := "11111111111";
    constant ap_const_lv11_41D : STD_LOGIC_VECTOR (10 downto 0) := "10000011101";
    constant ap_const_lv52_FFFFFFFBFFFFF : STD_LOGIC_VECTOR (51 downto 0) := "1111111111111111111111111111101111111111111111111111";
    constant ap_const_lv52_FFFFFFFC00000 : STD_LOGIC_VECTOR (51 downto 0) := "1111111111111111111111111111110000000000000000000000";
    constant ap_const_lv32_3D : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000111101";
    constant ap_const_lv10_3E3 : STD_LOGIC_VECTOR (9 downto 0) := "1111100011";
    constant ap_const_lv63_0 : STD_LOGIC_VECTOR (62 downto 0) := "000000000000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv54_0 : STD_LOGIC_VECTOR (53 downto 0) := "000000000000000000000000000000000000000000000000000000";
    constant ap_const_lv7_7F : STD_LOGIC_VECTOR (6 downto 0) := "1111111";
    constant ap_const_lv6_0 : STD_LOGIC_VECTOR (5 downto 0) := "000000";
    constant ap_const_lv6_1F : STD_LOGIC_VECTOR (5 downto 0) := "011111";
    constant ap_const_lv11_3FF : STD_LOGIC_VECTOR (10 downto 0) := "01111111111";
    constant ap_const_lv63_7FFFFFFFFFFFFFFF : STD_LOGIC_VECTOR (62 downto 0) := "111111111111111111111111111111111111111111111111111111111111111";
    constant ap_const_lv64_0 : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";

attribute shreg_extract : string;
    signal ap_CS_fsm : STD_LOGIC_VECTOR (8 downto 0) := "000000001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal ret_5_fu_101_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ret_5_reg_322 : STD_LOGIC_VECTOR (63 downto 0);
    signal fz_sig_fu_113_p1 : STD_LOGIC_VECTOR (51 downto 0);
    signal fz_sig_reg_328 : STD_LOGIC_VECTOR (51 downto 0);
    signal isF_e_x_fu_117_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal isF_e_x_reg_333 : STD_LOGIC_VECTOR (0 downto 0);
    signal isyBx_e_fu_123_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal isyBx_e_reg_337 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln267_fu_141_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln267_reg_341 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln271_fu_153_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal or_ln271_reg_345 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_mx_fu_169_p3 : STD_LOGIC_VECTOR (52 downto 0);
    signal ap_mx_reg_349 : STD_LOGIC_VECTOR (52 downto 0);
    signal n_fu_178_p2 : STD_LOGIC_VECTOR (9 downto 0);
    signal n_reg_354 : STD_LOGIC_VECTOR (9 downto 0);
    signal t_2_fu_185_p4 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state2 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state2 : signal is "none";
    signal t_3_fu_194_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal icmp_ln319_fu_205_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln319_reg_372 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_CS_fsm_state5 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state5 : signal is "none";
    signal trunc_ln324_fu_219_p1 : STD_LOGIC_VECTOR (5 downto 0);
    signal trunc_ln324_reg_376 : STD_LOGIC_VECTOR (5 downto 0);
    signal add_ln325_fu_227_p2 : STD_LOGIC_VECTOR (6 downto 0);
    signal add_ln325_reg_382 : STD_LOGIC_VECTOR (6 downto 0);
    signal ap_mx_2_fu_263_p3 : STD_LOGIC_VECTOR (51 downto 0);
    signal ap_mx_2_reg_387 : STD_LOGIC_VECTOR (51 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal t_4_fu_300_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state8 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state8 : signal is "none";
    signal t_fu_308_p3 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state9 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state9 : signal is "none";
    signal grp_generic_fmod_double_Pipeline_1_fu_87_ap_start : STD_LOGIC;
    signal grp_generic_fmod_double_Pipeline_1_fu_87_ap_done : STD_LOGIC;
    signal grp_generic_fmod_double_Pipeline_1_fu_87_ap_idle : STD_LOGIC;
    signal grp_generic_fmod_double_Pipeline_1_fu_87_ap_ready : STD_LOGIC;
    signal grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out : STD_LOGIC_VECTOR (53 downto 0);
    signal grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out_ap_vld : STD_LOGIC;
    signal ap_phi_mux_retval_1_in_phi_fu_73_p12 : STD_LOGIC_VECTOR (63 downto 0);
    signal retval_1_in_reg_70 : STD_LOGIC_VECTOR (63 downto 0);
    signal t_5_fu_286_p4 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_CS_fsm_state7 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state7 : signal is "none";
    signal grp_generic_fmod_double_Pipeline_1_fu_87_ap_start_reg : STD_LOGIC := '0';
    signal ap_CS_fsm_state4 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state4 : signal is "none";
    signal fz_exp_fu_105_p3 : STD_LOGIC_VECTOR (10 downto 0);
    signal icmp_ln267_fu_129_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln267_1_fu_135_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln271_fu_147_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal fz_exp_cast_fu_159_p4 : STD_LOGIC_VECTOR (9 downto 0);
    signal grp_fu_94_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal tmp_5_fu_211_p3 : STD_LOGIC_VECTOR (53 downto 0);
    signal trunc_ln324_1_fu_223_p1 : STD_LOGIC_VECTOR (6 downto 0);
    signal sext_ln325_fu_247_p1 : STD_LOGIC_VECTOR (31 downto 0);
    signal zext_ln325_fu_250_p1 : STD_LOGIC_VECTOR (53 downto 0);
    signal shl_ln325_fu_254_p2 : STD_LOGIC_VECTOR (53 downto 0);
    signal icmp_ln325_fu_233_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal trunc_ln325_1_fu_238_p4 : STD_LOGIC_VECTOR (51 downto 0);
    signal empty_fu_259_p1 : STD_LOGIC_VECTOR (51 downto 0);
    signal sub_ln327_fu_271_p2 : STD_LOGIC_VECTOR (5 downto 0);
    signal sext_ln327_fu_276_p1 : STD_LOGIC_VECTOR (10 downto 0);
    signal fz_exp_1_fu_280_p2 : STD_LOGIC_VECTOR (10 downto 0);
    signal bitcast_ln497_fu_296_p1 : STD_LOGIC_VECTOR (63 downto 0);
    signal ap_return_preg : STD_LOGIC_VECTOR (63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (8 downto 0);
    signal ap_ST_fsm_state1_blk : STD_LOGIC;
    signal ap_ST_fsm_state2_blk : STD_LOGIC;
    signal ap_ST_fsm_state3_blk : STD_LOGIC;
    signal ap_ST_fsm_state4_blk : STD_LOGIC;
    signal ap_ST_fsm_state5_blk : STD_LOGIC;
    signal ap_ST_fsm_state6_blk : STD_LOGIC;
    signal ap_ST_fsm_state7_blk : STD_LOGIC;
    signal ap_ST_fsm_state8_blk : STD_LOGIC;
    signal ap_ST_fsm_state9_blk : STD_LOGIC;
    signal tmp_5_fu_211_p0 : STD_LOGIC_VECTOR (53 downto 0);
    signal tmp_5_fu_211_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_ce_reg : STD_LOGIC;

    component RNG_generic_fmod_double_Pipeline_1 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        zext_ln254 : IN STD_LOGIC_VECTOR (9 downto 0);
        zext_ln300 : IN STD_LOGIC_VECTOR (52 downto 0);
        r_sh_1_out : OUT STD_LOGIC_VECTOR (53 downto 0);
        r_sh_1_out_ap_vld : OUT STD_LOGIC );
    end component;


    component RNG_ctlz_54_54_1_1 IS
    generic (
        din_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din : IN STD_LOGIC_VECTOR (53 downto 0);
        dout : OUT STD_LOGIC_VECTOR (53 downto 0) );
    end component;



begin
    grp_generic_fmod_double_Pipeline_1_fu_87 : component RNG_generic_fmod_double_Pipeline_1
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst,
        ap_start => grp_generic_fmod_double_Pipeline_1_fu_87_ap_start,
        ap_done => grp_generic_fmod_double_Pipeline_1_fu_87_ap_done,
        ap_idle => grp_generic_fmod_double_Pipeline_1_fu_87_ap_idle,
        ap_ready => grp_generic_fmod_double_Pipeline_1_fu_87_ap_ready,
        zext_ln254 => n_reg_354,
        zext_ln300 => ap_mx_reg_349,
        r_sh_1_out => grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out,
        r_sh_1_out_ap_vld => grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out_ap_vld);

    ctlz_54_54_1_1_U4 : component RNG_ctlz_54_54_1_1
    generic map (
        din_WIDTH => 54,
        dout_WIDTH => 54)
    port map (
        din => grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out,
        dout => tmp_5_fu_211_p3);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg <= ap_const_lv64_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
                    ap_return_preg <= bitcast_ln497_fu_296_p1;
                end if; 
            end if;
        end if;
    end process;


    grp_generic_fmod_double_Pipeline_1_fu_87_ap_start_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                grp_generic_fmod_double_Pipeline_1_fu_87_ap_start_reg <= ap_const_logic_0;
            else
                if (((or_ln271_fu_153_p2 = ap_const_lv1_1) and (or_ln267_fu_141_p2 = ap_const_lv1_1) and (isyBx_e_fu_123_p2 = ap_const_lv1_0) and (isF_e_x_fu_117_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                    grp_generic_fmod_double_Pipeline_1_fu_87_ap_start_reg <= ap_const_logic_1;
                elsif ((grp_generic_fmod_double_Pipeline_1_fu_87_ap_ready = ap_const_logic_1)) then 
                    grp_generic_fmod_double_Pipeline_1_fu_87_ap_start_reg <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    retval_1_in_reg_70_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((isyBx_e_fu_123_p2 = ap_const_lv1_1) and (isF_e_x_fu_117_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then 
                retval_1_in_reg_70 <= ret_5_fu_101_p1;
            elsif (((icmp_ln319_reg_372 = ap_const_lv1_0) and (or_ln271_reg_345 = ap_const_lv1_1) and (or_ln267_reg_341 = ap_const_lv1_1) and (isyBx_e_reg_337 = ap_const_lv1_0) and (isF_e_x_reg_333 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state7))) then 
                retval_1_in_reg_70 <= t_5_fu_286_p4;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state8)) then 
                retval_1_in_reg_70 <= t_4_fu_300_p3;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                retval_1_in_reg_70 <= t_3_fu_194_p3;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state2)) then 
                retval_1_in_reg_70 <= t_2_fu_185_p4;
            elsif ((ap_const_logic_1 = ap_CS_fsm_state9)) then 
                retval_1_in_reg_70 <= t_fu_308_p3;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state5)) then
                add_ln325_reg_382 <= add_ln325_fu_227_p2;
                icmp_ln319_reg_372 <= icmp_ln319_fu_205_p2;
                trunc_ln324_reg_376 <= trunc_ln324_fu_219_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state6)) then
                ap_mx_2_reg_387 <= ap_mx_2_fu_263_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_logic_1 = ap_CS_fsm_state1)) then
                    ap_mx_reg_349(51 downto 0) <= ap_mx_fu_169_p3(51 downto 0);
                fz_sig_reg_328 <= fz_sig_fu_113_p1;
                isF_e_x_reg_333 <= isF_e_x_fu_117_p2;
                isyBx_e_reg_337 <= isyBx_e_fu_123_p2;
                n_reg_354 <= n_fu_178_p2;
                or_ln267_reg_341 <= or_ln267_fu_141_p2;
                or_ln271_reg_345 <= or_ln271_fu_153_p2;
                ret_5_reg_322 <= ret_5_fu_101_p1;
            end if;
        end if;
    end process;
    ap_mx_reg_349(52) <= '1';

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, isF_e_x_fu_117_p2, isyBx_e_fu_123_p2, or_ln267_fu_141_p2, or_ln271_fu_153_p2, icmp_ln319_fu_205_p2, ap_CS_fsm_state5, grp_generic_fmod_double_Pipeline_1_fu_87_ap_done, ap_CS_fsm_state4)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((or_ln271_fu_153_p2 = ap_const_lv1_1) and (or_ln267_fu_141_p2 = ap_const_lv1_1) and (isyBx_e_fu_123_p2 = ap_const_lv1_0) and (isF_e_x_fu_117_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state4;
                elsif (((or_ln271_fu_153_p2 = ap_const_lv1_0) and (or_ln267_fu_141_p2 = ap_const_lv1_1) and (isyBx_e_fu_123_p2 = ap_const_lv1_0) and (isF_e_x_fu_117_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state3;
                elsif (((or_ln267_fu_141_p2 = ap_const_lv1_0) and (isyBx_e_fu_123_p2 = ap_const_lv1_0) and (isF_e_x_fu_117_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                elsif (((isyBx_e_fu_123_p2 = ap_const_lv1_1) and (isF_e_x_fu_117_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state7;
                elsif (((isF_e_x_fu_117_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_1))) then
                    ap_NS_fsm <= ap_ST_fsm_state9;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state4 => 
                if (((grp_generic_fmod_double_Pipeline_1_fu_87_ap_done = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state4))) then
                    ap_NS_fsm <= ap_ST_fsm_state5;
                else
                    ap_NS_fsm <= ap_ST_fsm_state4;
                end if;
            when ap_ST_fsm_state5 => 
                if (((icmp_ln319_fu_205_p2 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_state5))) then
                    ap_NS_fsm <= ap_ST_fsm_state8;
                else
                    ap_NS_fsm <= ap_ST_fsm_state6;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state7 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when ap_ST_fsm_state8 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when ap_ST_fsm_state9 => 
                ap_NS_fsm <= ap_ST_fsm_state7;
            when others =>  
                ap_NS_fsm <= "XXXXXXXXX";
        end case;
    end process;
    add_ln325_fu_227_p2 <= std_logic_vector(unsigned(trunc_ln324_1_fu_223_p1) + unsigned(ap_const_lv7_7F));
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state2 <= ap_CS_fsm(1);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);
    ap_CS_fsm_state4 <= ap_CS_fsm(3);
    ap_CS_fsm_state5 <= ap_CS_fsm(4);
    ap_CS_fsm_state6 <= ap_CS_fsm(5);
    ap_CS_fsm_state7 <= ap_CS_fsm(6);
    ap_CS_fsm_state8 <= ap_CS_fsm(7);
    ap_CS_fsm_state9 <= ap_CS_fsm(8);

    ap_ST_fsm_state1_blk_assign_proc : process(ap_start)
    begin
        if ((ap_start = ap_const_logic_0)) then 
            ap_ST_fsm_state1_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state1_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state2_blk <= ap_const_logic_0;
    ap_ST_fsm_state3_blk <= ap_const_logic_0;

    ap_ST_fsm_state4_blk_assign_proc : process(grp_generic_fmod_double_Pipeline_1_fu_87_ap_done)
    begin
        if ((grp_generic_fmod_double_Pipeline_1_fu_87_ap_done = ap_const_logic_0)) then 
            ap_ST_fsm_state4_blk <= ap_const_logic_1;
        else 
            ap_ST_fsm_state4_blk <= ap_const_logic_0;
        end if; 
    end process;

    ap_ST_fsm_state5_blk <= ap_const_logic_0;
    ap_ST_fsm_state6_blk <= ap_const_logic_0;
    ap_ST_fsm_state7_blk <= ap_const_logic_0;
    ap_ST_fsm_state8_blk <= ap_const_logic_0;
    ap_ST_fsm_state9_blk <= ap_const_logic_0;

    ap_done_assign_proc : process(ap_start, ap_CS_fsm_state1, ap_CS_fsm_state7)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state7) or ((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0)))) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and (ap_start = ap_const_logic_0))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;

    ap_mx_2_fu_263_p3 <= 
        trunc_ln325_1_fu_238_p4 when (icmp_ln325_fu_233_p2(0) = '1') else 
        empty_fu_259_p1;
    ap_mx_fu_169_p3 <= (ap_const_lv1_1 & fz_sig_fu_113_p1);

    ap_phi_mux_retval_1_in_phi_fu_73_p12_assign_proc : process(isF_e_x_reg_333, isyBx_e_reg_337, or_ln267_reg_341, or_ln271_reg_345, icmp_ln319_reg_372, retval_1_in_reg_70, t_5_fu_286_p4, ap_CS_fsm_state7)
    begin
        if (((icmp_ln319_reg_372 = ap_const_lv1_0) and (or_ln271_reg_345 = ap_const_lv1_1) and (or_ln267_reg_341 = ap_const_lv1_1) and (isyBx_e_reg_337 = ap_const_lv1_0) and (isF_e_x_reg_333 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_state7))) then 
            ap_phi_mux_retval_1_in_phi_fu_73_p12 <= t_5_fu_286_p4;
        else 
            ap_phi_mux_retval_1_in_phi_fu_73_p12 <= retval_1_in_reg_70;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state7)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(ap_CS_fsm_state7, bitcast_ln497_fu_296_p1, ap_return_preg)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state7)) then 
            ap_return <= bitcast_ln497_fu_296_p1;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;

    bitcast_ln497_fu_296_p1 <= ap_phi_mux_retval_1_in_phi_fu_73_p12;
    empty_fu_259_p1 <= shl_ln325_fu_254_p2(52 - 1 downto 0);
    fz_exp_1_fu_280_p2 <= std_logic_vector(signed(sext_ln327_fu_276_p1) + signed(ap_const_lv11_3FF));
    fz_exp_cast_fu_159_p4 <= ret_5_fu_101_p1(61 downto 52);
    fz_exp_fu_105_p3 <= ret_5_fu_101_p1(62 downto 52);
    fz_sig_fu_113_p1 <= ret_5_fu_101_p1(52 - 1 downto 0);
    grp_fu_94_p3 <= ret_5_reg_322(63 downto 63);
    grp_generic_fmod_double_Pipeline_1_fu_87_ap_start <= grp_generic_fmod_double_Pipeline_1_fu_87_ap_start_reg;
    icmp_ln267_1_fu_135_p2 <= "1" when (unsigned(fz_sig_fu_113_p1) > unsigned(ap_const_lv52_FFFFFFFBFFFFF)) else "0";
    icmp_ln267_fu_129_p2 <= "0" when (fz_exp_fu_105_p3 = ap_const_lv11_41D) else "1";
    icmp_ln271_fu_147_p2 <= "0" when (fz_sig_fu_113_p1 = ap_const_lv52_FFFFFFFC00000) else "1";
    icmp_ln319_fu_205_p2 <= "1" when (grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out = ap_const_lv54_0) else "0";
    icmp_ln325_fu_233_p2 <= "1" when (trunc_ln324_reg_376 = ap_const_lv6_0) else "0";
    isF_e_x_fu_117_p2 <= "1" when (fz_exp_fu_105_p3 = ap_const_lv11_7FF) else "0";
    isyBx_e_fu_123_p2 <= "1" when (unsigned(fz_exp_fu_105_p3) < unsigned(ap_const_lv11_41D)) else "0";
    n_fu_178_p2 <= std_logic_vector(unsigned(fz_exp_cast_fu_159_p4) + unsigned(ap_const_lv10_3E3));
    or_ln267_fu_141_p2 <= (icmp_ln267_fu_129_p2 or icmp_ln267_1_fu_135_p2);
    or_ln271_fu_153_p2 <= (icmp_ln271_fu_147_p2 or icmp_ln267_fu_129_p2);
    ret_5_fu_101_p1 <= x;
        sext_ln325_fu_247_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(add_ln325_reg_382),32));

        sext_ln327_fu_276_p1 <= std_logic_vector(IEEE.numeric_std.resize(signed(sub_ln327_fu_271_p2),11));

    shl_ln325_fu_254_p2 <= std_logic_vector(shift_left(unsigned(grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out),to_integer(unsigned('0' & zext_ln325_fu_250_p1(31-1 downto 0)))));
    sub_ln327_fu_271_p2 <= std_logic_vector(unsigned(ap_const_lv6_1F) - unsigned(trunc_ln324_reg_376));
    t_2_fu_185_p4 <= ((grp_fu_94_p3 & ap_const_lv11_41D) & fz_sig_reg_328);
    t_3_fu_194_p3 <= (grp_fu_94_p3 & ap_const_lv63_0);
    t_4_fu_300_p3 <= (grp_fu_94_p3 & ap_const_lv63_0);
    t_5_fu_286_p4 <= ((grp_fu_94_p3 & fz_exp_1_fu_280_p2) & ap_mx_2_reg_387);
    t_fu_308_p3 <= (grp_fu_94_p3 & ap_const_lv63_7FFFFFFFFFFFFFFF);
    trunc_ln324_1_fu_223_p1 <= tmp_5_fu_211_p3(7 - 1 downto 0);
    trunc_ln324_fu_219_p1 <= tmp_5_fu_211_p3(6 - 1 downto 0);
    trunc_ln325_1_fu_238_p4 <= grp_generic_fmod_double_Pipeline_1_fu_87_r_sh_1_out(52 downto 1);
    zext_ln325_fu_250_p1 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(sext_ln325_fu_247_p1),54));
end behav;
