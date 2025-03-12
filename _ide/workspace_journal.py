# 2025-03-12T15:40:43.475635
import vitis

client = vitis.create_client()
client.set_workspace(path="NMPC_GP")

comp = client.get_component(name="RNG")
comp.run(operation="C_SIMULATION")

client.delete_component(name="RNG")

comp = client.create_hls_component(name = "RNG",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp.run(operation="PACKAGE")

vitis.dispose()

