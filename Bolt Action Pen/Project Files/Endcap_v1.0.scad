/*
Bolt Action Pen
Design by Sithrazer
*/

$fn=40;

color("blue") rotate_extrude() Cap_Profile();

module Cap_Profile(){
    hull(){ //inner extrusion
        square([2,10]);
        translate([2.6,1,0]) circle(r=1); //translate 1/2 of internal diameter of pen body, less clearance, less radius of circle
        translate([2.6,9,0]) circle(r=1);
    }
    
    translate([6.1,0,0]) hull(){ //outer extrusion
        translate([0.75,0.75,0]) circle(r=0.75);
        translate([0.75,9.25,0]) circle(r=0.75);
    }
    
    square([6.85,2]); //end plate
}