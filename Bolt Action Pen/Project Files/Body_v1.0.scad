/*
Bolt Action Pen
Design by Sithrazer
*/

$fn=40;

color("green") difference(){
    Main_Tube();
    Bolt_Slot();
}

module Main_Tube(){
    difference(){
        union(){
            linear_extrude(135) circle(d=12); // main body
            translate([0,0,135]) cylinder(d1=12,d2=5.4,h=10); // tip cone
        }
        // ID/negative space
        linear_extrude(133) circle(d=7.9); //primary negative space
        linear_extrude(146) circle(d=3); //tip exit diameter
        linear_extrude(140) circle(d=4); //spring shelf
        translate([0,0,133]) cylinder(d1=7.9,d2=5,h=2); //transitions main body cavity to near tip size
    }
}

module Bolt_Slot(){
    hull(){
        rotate([0,0,55]) translate([0,-3,17.25]) rotate([90,0,0]) cylinder(d=4.5,h=5);
        rotate([0,0,55]) translate([0,-3,16.25]) rotate([90,0,0]) cylinder(d=4.5,h=5);
    }
    hull(){
        translate([0,-3,17.25]) rotate([90,0,0]) cylinder(d=4.5,h=5);
        rotate([0,0,55]) translate([0,-3,17.25]) rotate([90,0,0]) cylinder(d=4.5,h=5);
    }
    
    hull(){
        translate([0,-3,17.25]) rotate([90,0,0]) cylinder(d=4.5,h=5);
        translate([0,-3,0]) rotate([90,0,0]) cylinder(d=4.5,h=5);
    }
}