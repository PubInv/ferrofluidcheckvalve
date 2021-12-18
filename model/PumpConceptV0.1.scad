//
//    PumpConcept - V 0.1
//    Copyright (C) 2021  Robert L. Read
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.

// This is an experimental attempt to design a ferrofluid pump with no moving parts.abs
// I will attempt to make this as a linear extrusion of the chamber space, and then
// subtract that from the solid shape.abs
// I am attempting to build the simplest apparatus that can be used to test the 
// hypothesis that oscillating the magnitude (not direction) of the field can 
// create flow.

CircularMagnetDiameter = 12.7; // We use a half-inch magnet
CMD = CircularMagnetDiameter;
ChamberHeightZ = 2.0; // We will make a 2.0 mm high chamber
WellHeightZ = 4.0;
EqTriHeight = sqrt(3)/2;
SideLength = sqrt(3) * CMD;
InscribedRadius = sqrt(3)/6;
ChamberWidth = 1.0 * EqTriHeight * CMD;
ChamberLength = 1.0 * CMD;
ChannelLength = 5 * CMD; // we want a nice long chamber to be able to see the
// pumping effect visually.
ChannelWidth = 2.0;

TriangularLength = 0.7 * CMD;
ThickChamberLength = CMD / 2;

// Now I will union together two triangles, a rectangle, and long
// channel for the purpose of building this.

 module regular_polygon(order = 4, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

module chamber() {
    union() {
        translate([0,0,WellHeightZ - ChamberHeightZ/2])
        linear_extrude(height = WellHeightZ*2, center = true, slices = 20, scale = 1.0, $fn = 16)
        union() {
            translate([-ChamberLength/2+-(ChannelLength/2)+.1,0,0])
            square([ChamberLength,ChamberWidth],true);
        
            translate([+ChamberLength/2+(ChannelLength/2)-.1,0,0])
            square([ChamberLength,ChamberWidth],true);
        }
        linear_extrude(height = ChamberHeightZ, center = true, slices = 20, scale = 1.0, $fn = 16)
        union() {
        translate([0,0,0])
        square([ChannelLength,ChannelWidth],true);
        translate([0,0,0])
        color("red")
        translate([-(ChamberLength/2 + SideLength*EqTriHeight/6),0,0])
            square([ChamberLength,ChamberWidth],true);
            
        regular_polygon(order = 3, r=CMD/2);
            
        %color("blue")
        translate([-(3*ChamberLength/2 + 0*EqTriHeight * SideLength / 3),0,0])
        rotate([0,0,180])
        regular_polygon(order = 3, r=CMD/2);
        }
    }
}

module referenceCircle() {
    circle(r = CMD/2);
}

module holdingSlab() {
    translate([0,0,0])
    cube([ChannelLength+ChamberLength*2.5,ChamberWidth*1.5,ChamberHeightZ*3],true);
}

union() {
    color("red")
    translate([0,0,ChamberHeightZ*3/2])
    linear_extrude(height = 0.4, center = true, slices = 20, scale = 1.0, $fn = 32)
    referenceCircle();
    difference() {
        holdingSlab();
        chamber();
    }
}

