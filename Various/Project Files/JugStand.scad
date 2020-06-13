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

cylinder(40,d1=inside_d-10,d2=inside_d-10);
translate([0,0,5]){
    cube([outside_d,10,10],center=true);
    cube([10,outside_d,10],center=true);
}

difference(){
    cylinder(40,d1=outside_d+10,d2=outside_d+20);
    cylinder(40,d1=outside_d,d2=outside_d+10);
}