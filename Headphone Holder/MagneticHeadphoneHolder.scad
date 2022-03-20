/*
Magnetic Headphone Holder
Design by Sithrazer
*/

// post one inch diameter 3" long, base 1" wide 4" tall
// magnet pockets 1/4" in from sides 1" vertical spacing
$fn=100;
c=25.4;

difference(){
    //main body and post
    union(){
        cube([4*c,0.25*c,1*c]);
        rotate([90,0,0]) translate([3*c,0.5*c,0]) cylinder(3*c,d=1*c);
        translate([3*c,0,0]) rotate([180,180,0]) cube([0.5*c,3*c,1*c]);
    }
    //magnet recesses
    translate([0.5*c,0.25*c,0.25*c]) rotate([90,0,0]) magnet();
    translate([2*c,0.25*c,0.25*c]) rotate([90,0,0]) magnet();
    translate([3.5*c,0.25*c,0.25*c]) rotate([90,0,0]) magnet();
    translate([0.5*c,0.25*c,0.75*c]) rotate([90,0,0]) magnet();
    translate([2*c,0.25*c,0.75*c]) rotate([90,0,0]) magnet();
    translate([3.5*c,0.25*c,0.75*c]) rotate([90,0,0]) magnet();
    translate([5.75*c,-1.75*c,0]) cylinder(50,d=4.9*c);
}

module magnet(){
    cylinder(3,d=6.5);
}