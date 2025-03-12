create_project prj -part xc7z020-clg484-1 -force
set_property target_language verilog [current_project]
set vivado_ver [version -short]
set COE_DIR "../../syn/verilog"
source "/home/minh/Documents/UTU-Doctorate/control_theory/NMPC_GP/RNG/RNG/hls/syn/verilog/RNG_ddiv_64ns_64ns_64_59_no_dsp_1_ip.tcl"
source "/home/minh/Documents/UTU-Doctorate/control_theory/NMPC_GP/RNG/RNG/hls/syn/verilog/RNG_dmul_64ns_64ns_64_7_max_dsp_1_ip.tcl"
source "/home/minh/Documents/UTU-Doctorate/control_theory/NMPC_GP/RNG/RNG/hls/syn/verilog/RNG_fptrunc_64ns_32_2_no_dsp_1_ip.tcl"
source "/home/minh/Documents/UTU-Doctorate/control_theory/NMPC_GP/RNG/RNG/hls/syn/verilog/RNG_uitodp_64ns_64_6_no_dsp_1_ip.tcl"
