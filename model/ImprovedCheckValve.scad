// Copyright Robert L. Read, 2022
// Released under CERN Strong-reciprocal Open Hardware License

// This is an attempt to make a new parametrized experimental apparatus
// for teting our ferrofluid check valve. It will be similar to the system
// that Veronica design in SolidWorks, but will use the improved, 360 degree design


// Thanks to  Mike Thompson for ths CC Attribution-NonCommercial-SA 3.0 set of threaded tools
// include <Nut_Job_v2.scad>;

$fn = 40;


SlabHeight = 6;
ChamberRadius = 32;
SlabLength = ChamberRadius*5.5;
SlabWidth = ChamberRadius*2.5;
PlaneThickness = 1.0;
MagnetHeight = 50;
ww = 1.5; // This is the wall width, assumed to be sturdy enough

LuerPosition = SlabLength/2+5;
LockRingHeight = 15;

PI = 3.14152;
GapHeight = 3.0;
Thickness = 1.0;

ptype = "valve";
// ptype = "interior";

 module regular_polygon(order = 4, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }
 
 
 // Replicate a shape at a given radius and repeat with
 // rotation to create order number of objects
 module magnetChamber() {
     circle(CircleRadius);
 }
 
 module connectors(r, order=7) {
     difference() {
         circle(r*1.1);
         circle(r*0.8);
     }
     color("gray")
     rotate(1.5 * 360 / order) 
        translate([r*1.5,0,0]) 
     square([2*a,a],center=true);
          color("gray")
     rotate(5.5 * 360 / order) 
        translate([r*1.5,0,0]) 
     square([2*a,a],center=true);
        
    color("red") 
     translate([0.85*a,r+1.5*a,0])
     rotate([0,0,90])
      square([2*a,a],center=true);
     
         color("red") 
     translate([0.85*a,-(r+1.5*a),0])
     rotate([0,0,90])
      square([2*a,a],center=true);
 }

 module interior() {
     color("red")
      linear_extrude(height = PlaneThickness, center = true, convexity = 10, twist = 0)
    union() {
        // First, we put in a rectangle that spans the whole thing
        square([SlabLength,PlaneThickness],center=true);
        difference() {
            circle(ChamberRadius);
            union() {
                injectionWidth = PlaneThickness * 2;
                translate([-SlabLength/2,PlaneThickness,0])
                square([SlabLength,injectionWidth],center=true);
                translate([-SlabLength/2,-PlaneThickness,0])
                square([SlabLength,injectionWidth],center=true);
            }
        }
        // Now we adde the "recovery chambers"
        translate([ChamberRadius*2.0,0])
        square([ChamberRadius,ChamberRadius],center=true); 
        translate([-ChamberRadius*2,0,0])
        square([ChamberRadius,ChamberRadius],center=true);      
    }
 }
 
 module luer() {
 import("Body1.stl", convexity=3);
 }

module slab() {

    l = ChamberRadius*4;
    color("blue")
    linear_extrude(height = SlabHeight, center = true, convexity = 10, twist = 0)
    union() {
        circle(ChamberRadius+5);
        square([5*ChamberRadius+10,ChamberRadius+5],center=true); 
    }
//    union() {
//        difference() {
//            union() {
//            cube([SlabLength,SlabWidth,SlabHeight],center=true);
//            }
//        }
//    }
}

module basicRing(r) {
    w = 2;
    rotate([0,90,0])
    difference() {
        cylinder(LockRingHeight,r+w,r+w,center=true);
        cylinder(LockRingHeight+10,r,r,center=true);
    }
}

module lockRings() {
    // This should be the diameter of the permanent magnets used in the locks
    lockRadius = 12.8;
    rotate([0,90,0])
    basicRing(lockRadius); 
}

module addStands() {
    StandHeight = 2*25.4;
//    StandHeight = 25.4;
    translate([SlabLength/2+0,-SlabWidth/2,0])
    rotate([0,0,90])
    difference() {
        cube([SlabWidth,SlabHeight,SlabWidth]);
        translate([SlabWidth/4,-3,SlabWidth/3])
        cube([SlabWidth/2,SlabHeight*2,SlabWidth]);
    }
    translate([-SlabLength/2+SlabHeight,-SlabWidth/2,0])
    rotate([0,0,90])
    difference() {
        cube([SlabWidth,SlabHeight,SlabWidth]); 
        translate([SlabWidth/4,-3,SlabWidth/3])
        cube([SlabWidth/2,SlabHeight*2,SlabWidth]);
    }  
}

module completeValve() {
    union() {
        translate([LuerPosition,0,0]) rotate([0,270,0]) luer();
        translate([-LuerPosition,0,0]) rotate([0,90,0]) luer();
  //      addStands();
        difference() {
            union() {
                slab();
            }
            interior();
        }
        lockRings();
    } 

 
}

if (ptype == "valve") {
    completeValve();
} else if (ptype == "interior"){
    interior();
} else {
    echo("NO PTYPE SET!!! XXXXXXX");
}




