//Travel case for 1-2 cigars
conv=25.4;
wall=8;
slide=50;

//cigar stand-in (64 ring guage x 7in long)
//cylinder((7*conv),d=conv);

//make shell
difference(){
hull(){
    cylinder(5*conv,d=conv+wall);
    translate([0,conv+wall/2,0]) cylinder(5*conv,d=conv+wall);
    sphere(d=conv+wall);
    translate([0,conv+wall/2,0]) sphere(d=conv+wall);
}

translate([0,0,0]) cylinder((7*conv),d=conv);
sphere(d=conv);
translate([0,conv+wall/2,0]) cylinder((7*conv),d=conv);
translate([0,conv+wall/2,0]) sphere(d=conv);
hull(){
    translate([0,0,4.5*conv]) cylinder(2*conv,d=conv+wall/2);
    translate([0,conv+wall/2,4.5*conv])
    cylinder(2*conv,d=conv+wall/2);
}
}

//make lid
translate([slide,0,0]){
    difference(){
        union(){
        hull(){
            cylinder(2*conv,d=conv+wall);
            translate([0,conv+wall/2,0]) cylinder(2*conv,d=conv+wall);
            sphere(d=conv+wall);
            translate([0,conv+wall/2,0]) sphere(d=conv+wall);
        }
        hull(){
        cylinder(3*conv,d=conv+wall/2-0.5);
        translate([0,conv+wall/2,0]) cylinder(3*conv,d=conv+wall/2-0.5);
        }
    }
        cylinder(5*conv,d=conv);
        translate([0,conv+wall/2,0]) cylinder(5*conv,d=conv);
    sphere(d=conv);
    translate([0,conv+wall/2,0]) sphere(d=conv);
    }
}