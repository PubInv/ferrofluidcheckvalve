import numpy as np
from scipy.spatial.transform import Rotation as R
import magpylib as magpy
import matplotlib.pyplot as plt

cyl = magpy.magnet.Cylinder(
    magnetization=(0,0,1000),
    dimension=(1,2),
    position=(0,0,-1),
    style_magnetization_color_mode='bicolor',
    style_magnetization_color_north='m',
    style_magnetization_color_south='c',
)

# Create paths
ts = np.linspace(-3, 3, 201)
pos = np.array([(t, 0, 0.1) for t in ts])

# Set path at initialization
sensor = magpy.Sensor(position=pos)

# Compute the magnetic field via the direct interface.
B = magpy.getB(
    cyl,
    observers = pos
)

print(B.round())

# magpy.show(cyl)

magpy.show(cyl, sensor, animation=True, backend='plotly')

# Trying to do plotting

# fig = plt.figure(figsize=(10, 4))
# ax1 = fig.add_subplot(121)  # 2D-axis
# ax2 = fig.add_subplot(122, projection="3d"
