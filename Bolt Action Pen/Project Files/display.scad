/*
Bolt Action Pen
Design by Sithrazer
*/
use <Body_v1.0.scad>;
use <Bolt_v1.0.scad>;
use <Endcap_v1.0.scad>;

//from Body
color("green") difference(){
    Main_Tube();
    Bolt_Slot();
}

//from Bolt
color("red") translate([0,0,8]) Bolt();

//from Endcap
color("blue") translate([0,0,-2]) rotate_extrude() Cap_Profile();