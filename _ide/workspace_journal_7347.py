# 2025-03-12T11:25:06.810126
import vitis

client = vitis.create_client()
client.set_workspace(path="NMPC_GP")

comp = client.create_hls_component(name = "RNG",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="RNG")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

vitis.dispose()

