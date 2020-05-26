// cup holder paperclip caddy
// dimensioned around 1/2 height of a 12oz soda can
// scale in millimeters

difference(){
main_body();
magnets();
}
foot();
lip();
// TESTING
//rotate_extrude() translate([body_d/2-wall_thickness/2,0,0]) circle(d=wall_thickness);
// END TESTING

// START Global Vars
$fn=100;
wall_thickness=8; // multiply by 2 if using diameter instead of radius
// END Global Vars

// START Part Specific Vars
//heights
body_h=60;
lip_h=12;
foot_h=5;
//diameters | divide by 2 in part for radius
body_d=66;
lip_lower_d=body_d;
lip_upper_d=body_d + 12;
foot_lower_d=body_d - (wall_thickness * 2);
foot_upper_d=body_d;
// END Part Specific Vars

module main_body(){
    difference(){
        //main body solid
        color("Blue") cylinder(r=body_d/2,h=body_h);
        //main body cavity
        color("Blue") cylinder(r=(body_d/2)-(wall_thickness),h=body_h);
    }
}

module lip(){
    translate([0,0,body_h]){
        difference(){
            color("Green") cylinder(h=lip_h, r1=lip_lower_d/2, r2=lip_upper_d/2);
            color("Green") cylinder(h=lip_h, r1=lip_lower_d/2-wall_thickness, r2=lip_upper_d/2-wall_thickness);
            translate([0,0,lip_upper_d/2]) rotate([90,0,0]) color("Purple") cylinder(h=50,d=lip_upper_d);
        }
    }
}

module foot(){
    translate([0,0,-(foot_h)]) color("Red") cylinder(d2=foot_upper_d, d1=foot_lower_d, h=foot_h);
}

module magnets(){
    translate([0,0,body_h-10]){
        rotate([0,0,45]) translate([0,-(body_d/2-0.25-wall_thickness),0]) rotate([90,0,0]) color("Violet") cylinder(h=2.75,d=6);
        rotate([0,0,0]) translate([0,-(body_d/2-0.25-wall_thickness),0]) rotate([90,0,0]) color("Violet") cylinder(h=2.75,d=6);
        rotate([0,0,-45]) translate([0,-(body_d/2-0.25-wall_thickness),0]) rotate([90,0,0]) color("Violet") cylinder(h=2.75,d=6);
    }
}