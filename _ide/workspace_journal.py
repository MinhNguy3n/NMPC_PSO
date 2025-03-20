# 2025-03-20T17:51:53.499373
import vitis

client = vitis.create_client()
client.set_workspace(path="NMPC_GP")

status = client.add_platform_repos(platform=["/home/minh/Documents/UTU-work-related/VHDL_2024/vivado-boards-master/new/board_files"])

comp = client.create_aie_component(name="PW_approx_GPR", part = "xc7z020clg400-1", template = "empty_hls_component")

client.delete_component(name="PW_approx_GPR")

comp = client.create_hls_component(name = "approx_rbf_kernel",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

