import numpy as np
from scipy.spatial.transform import Rotation as R
import magpylib as magpy
import matplotlib.pyplot as plt
import plotly.graph_objects as go
import math


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

magpy.show(cyl, sensor, animation=True, backend='plotly')

# Trying to do plotting

fig = go.Figure().set_subplots(
    rows=1, cols=2, specs=[[{"type": "xy"}, {"type": "scene"}]]
)

# compute field and plot in 2D-axis
for i, lab in enumerate(["Bx", "By", "Bz"]):
    print(i)
    print(lab)

for i, lab in enumerate(["Bx", "By", "Bz"]):
    fig.add_trace(go.Scatter(x=np.linspace(-3, 3, 201), y=B[:, i], name=lab))

# now I specifically want to add the total magnitude
M = [];
for i in range(0,200):
    M.append(math.sqrt(B[i][0]*B[i][0] + B[i][2]*B[i][2]))


fig.add_trace(go.Scatter(x=np.linspace(-3, 3, 201),y=M,name=lab))
# temp_fig = go.Figure()

# generate figure
fig.show()
