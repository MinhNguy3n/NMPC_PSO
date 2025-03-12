set SynModuleInfo {
  {SRCNAME generic_fmod<double>_Pipeline_1 MODELNAME generic_fmod_double_Pipeline_1 RTLNAME RNG_generic_fmod_double_Pipeline_1
    SUBMODULES {
      {MODELNAME RNG_flow_control_loop_pipe_sequential_init RTLNAME RNG_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME RNG_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME generic_fmod<double> MODELNAME generic_fmod_double_s RTLNAME RNG_generic_fmod_double_s
    SUBMODULES {
      {MODELNAME RNG_ctlz_54_54_1_1 RTLNAME RNG_ctlz_54_54_1_1 BINDTYPE op TYPE ctlz IMPL auto}
    }
  }
  {SRCNAME RNG MODELNAME RNG RTLNAME RNG IS_TOP 1
    SUBMODULES {
      {MODELNAME RNG_fptrunc_64ns_32_2_no_dsp_1 RTLNAME RNG_fptrunc_64ns_32_2_no_dsp_1 BINDTYPE op TYPE fptrunc IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME RNG_dmul_64ns_64ns_64_7_max_dsp_1 RTLNAME RNG_dmul_64ns_64ns_64_7_max_dsp_1 BINDTYPE op TYPE dmul IMPL maxdsp LATENCY 6 ALLOW_PRAGMA 1}
      {MODELNAME RNG_ddiv_64ns_64ns_64_59_no_dsp_1 RTLNAME RNG_ddiv_64ns_64ns_64_59_no_dsp_1 BINDTYPE op TYPE ddiv IMPL fabric LATENCY 58 ALLOW_PRAGMA 1}
      {MODELNAME RNG_uitodp_64ns_64_6_no_dsp_1 RTLNAME RNG_uitodp_64ns_64_6_no_dsp_1 BINDTYPE op TYPE uitodp IMPL auto LATENCY 5 ALLOW_PRAGMA 1}
    }
  }
}
