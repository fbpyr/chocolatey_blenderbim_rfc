from pathlib import Path
import bpy


# bpy.ops.preferences.addon_install(filepath='/home/shane/Downloads/testaddon.py')
bpy.ops.preferences.addon_enable(module='blenderbim')
bpy.ops.wm.save_userpref()

print("enabled blenderbim addon successfully.")

