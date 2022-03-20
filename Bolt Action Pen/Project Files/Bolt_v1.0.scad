/*
Bolt Action Pen
Design by Sithrazer
*/

$fn=40;

bolt_length = 29; // 29mm (default) fits 4 1/4" (~108mm) length BIC pen inserts
lever_length = 9; // 9mm (default) protrudes 8mm beyond the body and 5mm beyond the endcap

color("red") Bolt();

module Bolt(){
    rotate_extrude() hull(){
        BL = bolt_length - 1; // compensate for the radius of the circles/squares
        translate([0,BL,0]) square(1);
        translate([0,0,0]) square(1);
        translate([2.5,BL,0]) circle(r=1);
        translate([2.5,1,0]) circle(r=1);
    }
    
    translate([0,0,2]) rotate([90,0,0]) cylinder(d=4,h=lever_length);
    translate([0,-lever_length,2]) sphere(d=4);
}