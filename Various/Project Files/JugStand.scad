// Drying stand for 1-gallon glass jugs

/*changes:
intersect
    OD cone (support neck up to where it starts to flare)
    tall cubes (make cone into butresses)
    rotate extrude square (ring base to stabilize butresses)

add air passages to center post for forced-air drying?
id=28.3
od=34.55
shoulder=42
rim thickness=6.25
*/

$fn=40;
in_conv=25.4;

// measure these and make sure
inside_d=25.4;
outside_d=38;
difference(){
    union(){
        intersection(){
            cylinder(42,d1=76.2,d2=45);
            translate([0,0,21]){
                cube([15,76.2,42],center=true);
                cube([76.2,15,42],center=true);
            }
        }
        rotate_extrude(angle=360) translate([30,0,0]) square(10);
    }
    cylinder(45,d=30);
}

*difference(){
    union(){
        cylinder(60,d=inside_d-10);
        translate([0,0,5]){
            cube([in_conv*6,15,15],center=true);
            cube([15,in_conv*6,15],center=true);
        }
    }
    translate([0,0,5]){ //air channel
        cylinder(in_conv*6,d=8);
        rotate([0,90,0]) cylinder(in_conv*6,d=8);
        sphere(d=8);
    }
}