// Copyright Robert L. Read, 2022
// Released under CERN Strong-reciprocal Open Hardware License

// This is an attempt to make a new parametrized experimental apparatus
// for teting our ferrofluid check valve. It will be similar to the system
// that Veronica design in SolidWorks, but will use the improved, 360 degree design


// Thanks to  Mike Thompson for ths CC Attribution-NonCommercial-SA 3.0 set of threaded tools
// include <Nut_Job_v2.scad>;

$fn = 40;


SlabHeight = 5;
HighChamberHeight = 15;
AirGapChamberHeight = 8;
ChamberRadius = 35;
// The idea of the Constrained Chamber Radius is to have a diameter of 0.33 inches.
ConstrainedChamberRadius = 0.4* 25.4 / 2.0;
SlabLength = ChamberRadius*5.5;
SlabWidth = ChamberRadius*2.5;
ChannelWidth = 1.0;
ChannelWallWidth = 2.0;
PlaneThickness = 2.0;
MagnetHeight = 50;
ww = 1.5; // This is the wall width, assumed to be sturdy enough

BasicRailWidth = 2;
MagnetWidth = 12.8;


LuerPosition = SlabLength/2 - 5;
// LockRingHeight = 15;
LockRingHeight = 20;

PI = 3.14152;
GapHeight = 3.0;
Thickness = 1.0;

// ptype = "valve";
// ptype = "interior";
// ptype = "valveWithRails";//
// ptype = "constrainedValve";
// ptype = "airgapchamber";
ptype = "highchamber";
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
//     color("gray")
     rotate(1.5 * 360 / order) 
        translate([r*1.5,0,0]) 
     square([2*a,a],center=true);
          color("gray")
     rotate(5.5 * 360 / order) 
        translate([r*1.5,0,0]) 
     square([2*a,a],center=true);
        
//    color("red") 
     translate([0.85*a,r+1.5*a,0])
     rotate([0,0,90])
      square([2*a,a],center=true);
     
//         color("red") 
     translate([0.85*a,-(r+1.5*a),0])
     rotate([0,0,90])
      square([2*a,a],center=true);
 }
module recoveryInterior(cr) {
    thickness = PlaneThickness*0.7;
    linear_extrude(height=thickness,center=true)
    union() {
        translate([cr*2.0,0])
        square([cr,cr],center=true); 
        crh = cr / 2;
        d = crh*3;
        points = [[d,crh], [d,-crh], [d-cr/3,0]];
        polygon(points);
    }
}
 module interior(cr) {
    thickness = PlaneThickness*0.7;
    union() {
        // First, we put in a rectangle that spans the whole thing
        linear_extrude(height=thickness,center=true)
        square([SlabLength*1.5,thickness],center=true);
        
        linear_extrude(height=thickness,center=true)
        difference() {
            circle(cr);
            union() {
                injectionWidth = PlaneThickness * 2;
 //               f = 0.2;
                f = 0.3;
                translate([-SlabLength/2,PlaneThickness* f,0])
                square([SlabLength,ChannelWidth*2],center=true);
                translate([-SlabLength/2,-PlaneThickness * f,0])
                square([SlabLength,ChannelWidth*2],center=true);
            }
        }
        // Now we adde the "recovery chambers"
        recoveryInterior(ChamberRadius);
        rotate([0,0,180])
        recoveryInterior(ChamberRadius);
    }
 }
 
 module luer() {
 //import("Body1.stl", convexity=3);
     myBarbJustForThis();
 }

module slab(r,cr) {
    l = r*4;
 //   color("red",0.2)
    linear_extrude(height = SlabHeight, center = true, convexity = 10, twist = 0)
    union() {
        circle(cr+5);
        square([5*r+10,r+5],center=true); 
    }
}

//module slabWithHighChamber(r,cr) {
//    l = r*4;
//    color("Green",1.0)
//    linear_extrude(height = HighChamberHeight, center = true, convexity = 10, twist = 0)
//    union() {
//        circle(cr+5);
//        square([5*r+10,r+5],center=true); 
//    }
//}

module basicRing(r) {
    w = 2;
    rotate([0,90,0])
    difference() {
        cylinder(LockRingHeight,r+w,r+w,center=true);
        cylinder(LockRingHeight+10,r,r,center=true);
    }
}
module basicRail(r) {
    w = BasicRailWidth;
    translate([0,0,0])
    cube([SlabWidth,w,LockRingHeight],center=true);
}

module lockRings() {
    // This should be the diameter of the permanent magnets used in the locks
    lockRadius =  MagnetWidth / 2;
    rotate([0,90,0])
    basicRing(lockRadius); 
}
module lockRails() {
    // This should be the diameter of the permanent magnets used in the locks
    r = (MagnetWidth / 2) + (BasicRailWidth/2);
    translate([0,r,0])   
    basicRail(r);  
    translate([0,-r,0])   
    basicRail(r);    
}

module addStands() {
    StandHeight = 2*25.4;
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
    c = ChamberRadius/2;
    union() {
        translate([LuerPosition,0,0]) rotate([0,270,0]) luer();
        translate([-LuerPosition,0,0]) rotate([0,90,0]) luer();
        difference() {
          union() {
             slab(ChamberRadius,ChamberRadius);
             lockRings();
          }
         interior(hamberRadius);
       }
       // now we add a "blocking bar"
       translate([ChamberRadius*2.0,0])
       cube([2,c,SlabHeight],center=true);
       translate([-ChamberRadius*2.0,0])
       cube([2,c,SlabHeight],center=true);
    } 
}

module valveWithRails(r,cr) {
    c = r/2;
    union() {
        translate([LuerPosition,0,0]) rotate([0,270,0]) luer();
        translate([-LuerPosition,0,0]) rotate([0,90,0]) luer();
        difference() {
          union() {
             slab(r,cr);
             lockRails();
          }
         interior(cr);
       }
       // now we add a "blocking bar"
       translate([r*2.0,0])
       cube([2,c,SlabHeight],center=true);
       translate([-r*2.0,0])
       cube([2,c,SlabHeight],center=true);
    } 
}
 
module chamberDrum(cr,chamberHeight) {
    rotate([0,0,180])
    translate([0,0,-(ChannelWidth+ChannelWallWidth)/2])
    difference() {
        union() {
            color("blue",0.6)
//            translate([0,0,-ChannelWallWidth/2])
            translate([0,0,-0.5])
            difference() { 
                linear_extrude(chamberHeight, twist = 0)            
                 circle(cr+ww);
                translate([0,0,ChannelWallWidth])   
                linear_extrude(chamberHeight-2*ChannelWallWidth, twist = 0)            
                circle(cr);
            }
            // Now we add the channel.
            translate([cr,0,(ChannelWidth+ChannelWallWidth)/2])
            difference() {
                cube([cr*2,ChannelWidth+ChannelWallWidth,ChannelWidth+ChannelWallWidth],center=true);
                cube([cr*3,ChannelWidth,ChannelWidth],center=true);
            }
     }
     translate([cr,0,(ChannelWidth+ChannelWallWidth)/2])
     cube([cr*6,ChannelWidth,ChannelWidth],center=true);
    }
    
 
}

module valveWithHighChamber(r,chamberHeight) {
    c = r/2;
    cr = c;
//   translate([0,0,0])
//   interior(cr);
    
    difference() {
    union() {
        translate([LuerPosition,0,0]) rotate([0,270,0]) luer();
        translate([-LuerPosition,0,0]) rotate([0,90,0]) luer();
        chamberDrum(cr,chamberHeight);
        difference() {
            union() {
                difference() {
                    union() {
                        slab(r,cr); 
                        lockRails();
                    }
                    translate([0,0,-PlaneThickness/2])
                    linear_extrude(chamberHeight-2*ChannelWallWidth, twist = 0)            
                    circle(cr+ww);         
                }
            };      
        }
    }
    interior(cr);
    }  
   
   // now we add a "blocking bar"
//    translate([0,30,0])
       translate([r*2.0,0])
       cube([2,c,SlabHeight],center=true);
 //   translate([0,30,0])
       translate([-r*2.0,0])
       cube([2,c,SlabHeight],center=true); 
    // Now cut this:
    
   difference() {
      q = 0.8;
      m = 0.7;
      color("white", 1.0)
      translate([cr+-m,0,chamberHeight/2-4])
      rotate([0,90,0])
      difference() {
        cube([chamberHeight-3,ChannelWidth+ChannelWallWidth+q,ChannelWidth+ChannelWallWidth+q],center=true);
        cube([chamberHeight*2,ChannelWidth+q,ChannelWidth+q],center=true);
     }
     f = 1.2;
     g = 0.4;
     translate([cr+2,0,0])    
     cube([ChannelWidth*f+4,ChannelWidth*f+g,ChannelWidth*f+g],center=true);
   }
}

if (ptype == "valve") {
    completeValve();
} else if (ptype == "valveWithRails") {
    valveWithRails(ChamberRadius,ChamberRadius);
} else if (ptype == "constrainedValve") {
        d = 4;
 //   difference() {
    valveWithRails(ChamberRadius,ConstrainedChamberRadius);
 //    cube([d,100,100],center=true);
// }
} else if (ptype == "interior"){
    interior(ConstrainedChamberRadius);
} else if (ptype == "highchamber") {
 //  d = 15;
 // difference() {
      valveWithHighChamber(ChamberRadius,HighChamberHeight);
 //    cube([d,100,100],center=true);
 //} 
} else if (ptype == "airgapchamber") {
 //   d = 33;
 // difference() {
      valveWithHighChamber(ChamberRadius,AirGapChamberHeight);
 //     cube([d,100,100],center=true);
 // } 
  }else {
    echo("NO PTYPE SET!!! XXXXXXX");
}

// %translate([0,50,0])
// valveWithRails(ConstrainedChamberRadius);

// Super-Duper Parametric Hose Barb : https://www.thingiverse.com/thing:2990340
// By Varnerrants, licensed under CC - Attribution. Don't forget to attribute Varnerrants 
// (no other name given in documentation?)$fn = 90;

// Hose Outer Diameter (used to calculate shlouder length)
// hose_od = 9.5;
hose_od = 5;
// Hose Inner Diameter
// hose_id = 8;
hose_id = 4;

// How far the barbs swell the diameter.
swell = 2;

// Wall thickness of the barb.
//wall_thickness = 1.31;
wall_thickness = 0.8;

// Number of barbs.
barbs = 3;
// How far between each barb section?
barb_length = 2;

// Do you want to render the outer shell?
shell = true;

// Do you want to render the bore?
bore = true;

// Flattens the barbs on one end. Usefull if youre printing barbs at angles, as the flattened side can be rotated downward facing the bed.
ezprint = false;

//barb(hose_od = hose_od, hose_id = hose_id, swell = swell, wall_thickness = wall_thickness, barbs = barbs, barb_length = barb_length, shell = shell, bore = bore, ezprint = ezprint);

module barb(hose_od = 21.5, hose_id = 15, swell = 1, wall_thickness = 1.31, barbs = 3, barb_length = 2, shell = true, bore = true, ezprint = true) {
    id = hose_id - (2 * wall_thickness);
    translate([0, 0, -((barb_length * (barbs + 1)) + 4.5 + (hose_od - hose_id))])
    difference() {
        union() {
            if (shell == true) {
                cylinder(d = hose_id, h = barb_length);
                for (z = [1 : 1 : barbs]) {
                    translate([0, 0, z * barb_length]) cylinder(d1 = hose_id, d2 = hose_id + swell, h = barb_length);
                }
                translate([0, 0, barb_length * (barbs + 1)]) cylinder(d = hose_id, h = 4.5 + (hose_od - hose_id));
            }
        }
        if (bore == true) {
            translate([0, 0, -1]/2) cylinder(d = id, h = (barb_length * (barbs + 1)) + 4.5 + (hose_od - hose_id) + 1);
        }
        if (ezprint == true) {
            difference() {
                cylinder(d = hose_id + (swell * 3), h = (barb_length * (barbs + 1)));
                translate([swell, 0, 0]) cylinder(d = hose_id + (swell * 2), h = (barb_length * (barbs + 1)));
            }
        }
    }
}

module myBarbJustForThis() {
    barb(hose_od = hose_od, hose_id = hose_id, swell = swell, wall_thickness = wall_thickness, barbs = barbs, barb_length = barb_length, shell = shell, bore = bore, ezprint = ezprint);
}


