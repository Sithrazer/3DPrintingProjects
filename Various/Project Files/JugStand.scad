// Drying stand for 1-gallon glass jugs

/*changes:
add air passages to center post for forced-air drying?
add fan mount features for 40mm case fan


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
            cylinder(52,d1=76.2,d2=50);
            translate([0,0,21]){
                cube([12,76.2,52],center=true);
                cube([76.2,12,52],center=true);
            }
        }
        rotate_extrude(angle=360) translate([30,0,0]) square(10);
    }
    translate([0,0,10]) cylinder(45,d=42);
    *translate([0,0,10]) rotate_extrude(angle=360) translate([((6.25/2)+28.3)/2,0,0]) circle(d=6.25);
    translate([0,0,5]){
        cylinder(60,d=8);
        sphere(d=8);
        rotate([-90,0,0]) cylinder(60,d=8);
    }
}