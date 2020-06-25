// Library for fan mounting flanges

module generic_40(){
    fan_flange(40,2,38,32,4.3);
}

module generic_80(){
    fan_flange(80,4,76,71.5,4.3);
}

module generic_120(){
    fan_flange(120,4,115,105,4.3);
}

module fan_flange(frame_s,frame_r,blade_d,hole_s,hole_d){
    difference(){
        minkowski(){
            square(frame_s-frame_r*2,center=true);
            circle(frame_r);
        }
        mount_pattern(hole_s,hole_d);
        circle(d=blade_d);
    }
}

module mount_pattern(spacing, hole){
    translate([spacing/2,spacing/2,0]) circle(d=hole);
    translate([-(spacing/2),spacing/2,0]) circle(d=hole);
    translate([spacing/2,-(spacing/2),0]) circle(d=hole);
    translate([-(spacing/2),-(spacing/2),0]) circle(d=hole);
}