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
# The points at which we will evaluate the force
xpoints=np.linspace(-3, 3, 201)

# Set path at initialization
sensor = magpy.Sensor(position=pos)

# Compute the magnetic field via the direct interface.
B = magpy.getB(
    cyl,
    observers = pos
)


# Trying to do plotting

fig = go.Figure().set_subplots(
    rows=1, cols=2, specs=[[{"type": "xy"}, {"type": "scene"}]]
)

# compute field and plot in 2D-axis
for i, lab in enumerate(["Bx", "By", "Bz"]):
    print(i)
    print(lab)

for i, lab in enumerate(["Bx"]):
    fig.add_trace(go.Scatter(x=np.linspace(-3, 3, 201), y=B[:, i], name=lab))

F = []
for i,x in enumerate(xpoints):
    F.append(B[i,0])

# now we seek to split xpoints into three arrays to do piece-wise curve fitting
Ex,Ey = [],[] # East points
Cx,Cy = [],[] # Central points
Wx,Wy = [],[] # West points
for i,x in enumerate(xpoints):
    if x <= -0.5:
        Wx.append(xpoints[i])
        Wy.append(F[i])
    elif x <= 0.5:
        Cx.append(xpoints[i])
        Cy.append(F[i])
    else:
        Ex.append(xpoints[i])
        Ey.append(F[i])

pE = np.poly1d(np.polyfit(Ex,Ey,6))
EP = []
for i,x in enumerate(Ex):
    EP.append(pE(x))

fig.add_trace(go.Scatter(x=Ex,y=EP,name="EP"))

pC = np.poly1d(np.polyfit(Cx,Cy,1))
CP = []
for i,x in enumerate(Cx):
    CP.append(pC(x))

fig.add_trace(go.Scatter(x=Cx,y=CP,name="CP"))

pW = np.poly1d(np.polyfit(Wx,Wy,6))
WP = []
for i,x in enumerate(Wx):
    WP.append(pW(x))
    print(i,x,pW(x))

fig.add_trace(go.Scatter(x=Wx,y=WP,name="WP"))


# pW = np.poly1d(np.polyfit(Wx,Wy,6))
# ZP = []
# for i,x in enumerate(Wx):
#     ZP.append(pW(x))

# fig.add_trace(go.Scatter(x=Wx,y=ZP,name="ZP"))


# # Spud boy
# def guessz(x):
#     v = -3.0 - x
#     return -7*(v)**4

# This is the best one so far
# def guessq(x):
#     v = -3.0 - x
#     return -1.1*(v)**6

# QP = []
# for i,x in enumerate(Wx):
#     QP.append(guessq(x))

# fig.add_trace(go.Scatter(x=Wx,y=QP,name="QP"))

# magpy.show(cyl, sensor, backend='plotly')
fig.show()
