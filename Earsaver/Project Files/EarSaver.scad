// ear saver design

$fn=40; //circle fidelity
ext=1.6; //extrusion depth
adj=-2; //fine tune hook position

hookGroup();
mirror([1,0,0]) hookGroup();

//neck band
difference(){
    //main structure
    union(){
        linear_extrude(ext){
            hull(){
                translate([25,0,0]) circle(r=6);
                translate([-25,0,0]) circle(r=6);
            }
            translate([25,0,0]) rotate(5) hull(){
                circle(r=6);
                translate([50,0,0]) circle(r=6);
            }
            mirror([1,0,0]) translate([25,0,0]) rotate(5) hull(){
                circle(r=6);
                translate([50,0,0]) circle(r=6);
            }
        }
    }
    //cutouts
    union(){
        linear_extrude(ext){
            hull(){
                translate([25,0,0]) circle(r=3);
                translate([-25,0,0]) circle(r=3);
            }
            translate([25,0,0]) rotate(5) hull(){
                circle(r=3);
                translate([50,0,0]) circle(r=3);
            }
            mirror([1,0,0]) translate([25,0,0]) rotate(5) hull(){
                circle(r=3);
                translate([50,0,0]) circle(r=3);
            }
        }
    }
}

//hooks
module hook(){
    rotate([0,0,-30]) rotate_extrude(convexity=10, angle=60) translate([17,0,0]) square([3,ext],false);
    rotate([0,0,-30]) translate([18.5,0,0]) linear_extrude(ext) circle(d=4);
    rotate([0,0,30]) translate([18.5,0,0]) linear_extrude(ext) circle(d=4);
}

module hookGroup(){
    translate([25,0,0]){
        rotate(5) translate([-12.5+adj,0,0]) hook();
        rotate(5) translate([adj,0,0]) hook();
        rotate(5) translate([12.5+adj,0,0]) hook();
        rotate(5) translate([25+adj,0,0]) hook();
        rotate(5) translate([37.5+adj,0,0]) hook();
    }
}