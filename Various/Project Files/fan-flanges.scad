// Library for fan mounting flanges

NFA4();

module NFA4(){
    fan_flange(40,32,2,4);
}

module fan_flange(size,spacing,radius,hole){
    difference(){
        minkowski(){
            #square(size,center=true);
            circle(radius);
        }
        mount_pattern(spacing,hole);
        circle(d=size);
    }
}

module mount_pattern(spacing, hole){
    translate([spacing/2,spacing/2,0]) circle(d=hole);
    translate([-(spacing/2),spacing/2,0]) circle(d=hole);
    translate([spacing/2,-(spacing/2),0]) circle(d=hole);
    translate([-(spacing/2),-(spacing/2),0]) circle(d=hole);
}