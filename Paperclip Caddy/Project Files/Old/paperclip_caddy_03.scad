// cup holder paperclip caddy
// dimensioned around 1/2 height of a 12oz soda can
// scale in millimeters
difference(){
main_construct();
magnet_holes();
//translate([0,0,100]) rotate([90,0,0]) cylinder(r=33,h=50);
translate([0,0,78]) scale([.8,1,.5]) rotate([60,0,0]) cylinder(r=33,h=50);
}
//translate([0,0,85]) scale([1,1,.5]) rotate([90,0,0]) cylinder(r=33,h=50);
$fn=200;

module main_construct(){
    rotate_extrude(){
        square([33,5]);
        minkowski(){
            circle(1);
            union(){
                translate([25,1,0]) square([8,64]);
                translate([25,65,0]) polygon([[0,0],[8,0],[14,12],[6,12]]);
            }
        }
    }
}

module magnet_holes(){
    translate([0,0,57]){
        translate([0,-23.75,0]) rotate([90,0,0]) cylinder(h=3,d=6.1);
        rotate([0,0,45]) translate([0,-23.75,0]) rotate([90,0,0]) cylinder(h=3,d=6.1);
        rotate([0,0,-45]) translate([0,-23.75,0]) rotate([90,0,0]) cylinder(h=3,d=6.1);
    }
}

//add access cutout in lip