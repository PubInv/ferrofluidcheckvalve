import numpy as np
from scipy.spatial.transform import Rotation as R
import magpylib as magpy
import matplotlib.pyplot as plt
import plotly.graph_objects as go
import math

magWidth_in = 0.5
magLength_in = 1.0
magWidth_mm = magWidth_in * 25.4
magLength_mm = magLength_in * 25.4
meanFluidHeight_mm = 2


# We want to use this program to investigate both a one-magnet
# and a two-magnet solution. We believe the two-magnet solution
# provides a higher cracking pressure. At present,
# I do not know how to compute the field of two magnets,
# except to simply add them.
useTwoMagnetSolution = False

# TODO: This magnetism is probably too high. We need to
# find an actual value for our rare earth magnets.
# https://www.quora.com/What-is-the-magnetic-field-strength-of-a-1x1-in-cube-neodymium-magnet-in-teslas
magnetization_mT = 640
cyl = magpy.magnet.Cylinder(
    magnetization=(0,0,magnetization_mT),
    dimension=(magWidth_mm,magLength_mm),
    position=(0,0,-magLength_mm/2.0 -meanFluidHeight_mm),
    style_magnetization_color_mode='bicolor',
    style_magnetization_color_north='m',
    style_magnetization_color_south='c',
)

cyl2 = magpy.magnet.Cylinder(
    magnetization=(0,0,magnetization_mT),
    dimension=(magWidth_mm,magLength_mm),
    position=(0,0,magLength_mm/2.0 + meanFluidHeight_mm),
    style_magnetization_color_mode='bicolor',
    style_magnetization_color_north='m',
    style_magnetization_color_south='c',
)

# Create paths
spaceSize_mm = 6*magWidth_mm
ts = np.linspace(-spaceSize_mm, spaceSize_mm, 201)
pos = np.array([(t, 0, 0) for t in ts])
# The points at which we will evaluate the force
xpoints=np.linspace(-spaceSize_mm, spaceSize_mm, 201)

# Set path at initialization
sensor = magpy.Sensor(position=pos)

# Compute the magnetic field via the direct interface.
if useTwoMagnetSolution:
    B = magpy.getB(
        cyl,
        observers = pos
    )
else:
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
    fig.add_trace(go.Scatter(x=np.linspace(-spaceSize_mm, spaceSize_mm, 201), y=B[:, i], name=lab))

F = []
for i,x in enumerate(xpoints):
    F.append(B[i,0])

# now we seek to split xpoints into three arrays to do piece-wise curve fitting
Ex,Ey = [],[] # East points
Cx,Cy = [],[] # Central points
Wx,Wy = [],[] # West points
for i,x in enumerate(xpoints):
    if x <= -magWidth_mm/2:
        Wx.append(xpoints[i])
        Wy.append(F[i])
    elif x <= magWidth_mm/2:
        Cx.append(xpoints[i])
        Cy.append(F[i])
    else:
        Ex.append(xpoints[i])
        Ey.append(F[i])

highestPolyPower = 6
pE = np.poly1d(np.polyfit(Ex,Ey,highestPolyPower))
EP = []
for i,x in enumerate(Ex):
    EP.append(pE(x))

fig.add_trace(go.Scatter(x=Ex,y=EP,name="EP"))

pC = np.poly1d(np.polyfit(Cx,Cy,1))
CP = []
for i,x in enumerate(Cx):
    CP.append(pC(x))

fig.add_trace(go.Scatter(x=Cx,y=CP,name="CP"))

pW = np.poly1d(np.polyfit(Wx,Wy,highestPolyPower))
WP = []
for i,x in enumerate(Wx):
    WP.append(pW(x))
    print(i,x,pW(x))

fig.add_trace(go.Scatter(x=Wx,y=WP,name="WP"))

magpy.show(cyl, sensor, backend='plotly')
magpy.show(cyl2, sensor, backend='plotly')
fig.show()
