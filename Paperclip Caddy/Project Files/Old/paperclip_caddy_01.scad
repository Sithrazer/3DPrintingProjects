//cup holder magnetic paperclip caddy
//dimensioned around 1/2 height 12oz size soda can
//scale in millimeters

//TODO
//reorganize modules to create discrete components instead of solids vs voids
//TODO

$fn=100;
wall_thickness=8 * 2; //doubled for diameter instead of radius
body_h=60; //height of main body (not total height)
body_d=66; //od of main body
lip_h=12;
lip_upper_d=body_d + 12;
foot_h=5;
foot_lower_d=50;
cavity_h=body_h - 10;
cavity_d=body_d - wall_thickness;

//shifts cavity construct into viewable area
//set to zero before exporting
off_side=0;

//main_body();
//main_cavity();
//magnet_cavity();

difference(){
    main_body();
    main_cavity();
    magnet_cavity();
}

module main_body(){
    union(){
//main body
        color("Blue") cylinder(h=body_h,d=body_d);
//foot
        translate([0,0,-(foot_h)]) color("Red") cylinder(h=foot_h,d1=foot_lower_d,d2=body_d);
//lip
        translate([0,0,body_h]) color("Green") cylinder(h=lip_h,d1=body_d,d2=lip_upper_d);
    }
}

module main_cavity(){
    union(){
//main body cavity
        translate([off_side,0,(body_h - cavity_h)]){
            color("Purple") cylinder(h=cavity_h,d=cavity_d);
        }
//lip cavity
        translate([off_side,0,body_h]){
            color("Yellow") cylinder(h=lip_h,d1=cavity_d,d2=lip_upper_d - wall_thickness);
        }
    }
}

module magnet_cavity(){
    translate([off_side,0,body_h-10]){
        rotate([0,0,45]) translate([0,-(cavity_d/2-0.5),0]) rotate([90,0,0]) color("Violet") cylinder(h=2.75,d=6);
        rotate([0,0,0]) translate([0,-(cavity_d/2-0.5),0]) rotate([90,0,0]) color("Violet") cylinder(h=2.75,d=6);
        rotate([0,0,-45]) translate([0,-(cavity_d/2-0.5),0]) rotate([90,0,0]) color("Violet") cylinder(h=2.75,d=6);
    }
}