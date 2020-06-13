// Drying stand for 1-gallon glass jugs

/*changes:
remove OD cone
add body support ring
keep center post to help with centering bottle neck
add air passages to center post for forced-air drying?
*/

// measure these and make sure
inside_d=25.4;
outside_d=38;

difference(){
    union(){
    cylinder(60,d=inside_d-10);
        translate([0,0,5]){
    cube([75,15,15],center=true);
    cube([15,75,15],center=true);
}
}
    translate([0,0,5]){
        cylinder(60,d=8);
        rotate([0,90,0]) cylinder(60,d=8);
        sphere(d=8);
    }
    
}

*difference(){
    cylinder(40,d1=outside_d+10,d2=outside_d+20);
    cylinder(40,d1=outside_d,d2=outside_d+10);
}