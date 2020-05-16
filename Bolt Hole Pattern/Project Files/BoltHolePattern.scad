/*[ALL DIMENSIONS IN MILLIMETERS]*/
//1 inch equals 25.4 mm
one_inch=25.4;
/*[Bolt Pattern]*/
//Hole Diameter
diameter=9.5; // 3/8in
//Width On-Center
width=44.5; // ~1 3/4in
//Length On-Center
length=74.6; // ~2 15/16in

/*[Template Features]*/
//Border Around Features
border=3; //[2:8]
//Template Thickness
thick=2; //[2:20]
//Clamp Tabs
tabs=false;

/*[Edge Guide]*/
//Edge Guide
guide=false;
//Edge Guide Side
guide_side=0;//[0:Short Side,1:Long Side]
//Edge Guide Distance On-Center
guide_dist=10;
//Edge Guide Height
guide_height=10; //[2:20]

//Useful calculations
//total length including all features
t_length=length+diameter+border*2;
//total width including all features
t_width=width+diameter+border*2;
radius=diameter/2;

//Assemble Template Basics
make_plate(thick, border, t_width, t_length);
translate([length/2,width/2,0])
    make_hole(thick, border, radius);
translate([-(length/2),width/2,0])
    make_hole(thick, border, radius);
translate([length/2,-(width/2),0])
    make_hole(thick, border, radius);
translate([-(length/2),-(width/2),0])
    make_hole(thick, border, radius);
    
//Assemble Clamp Tabs
if (tabs){
    //long side tab
    translate([0,-(t_width/8)+t_width/2,0])
    cube([length/2, t_width/4,thick],center=true);
    //short side tab
    translate([-(t_length/8)+t_length/2,0])
    cube([t_length/4, width/2,thick],center=true);
}

//Assemble Edge Guides
if((guide)&&(guide_side==0)){
    make_guide(thick, border, width-diameter, guide_dist, guide_height, length);
}
if((guide)&&(guide_side==1)){
    rotate([0,0,90])
    make_guide(thick, border, length-diameter, guide_dist, guide_height, width);
}

module make_plate(thick, border, width, length){
    difference(){
        cube([length, width, thick],center=true);
        cube([length-border*2, width-border*2, thick+1],center=true);
    }
}

module make_hole(thick, border, radius){
    difference(){
        cylinder(thick,r=radius+border,center=true);
        cylinder(thick+1,r=radius,center=true);
    }
}

module make_guide(thick, border, width, guide_dist, guide_height, to_center){
    translate([to_center/2,0,-(thick/2)])
    union(){
        //Assemble stop
        translate([guide_dist,-(width/2),0])
        cube([border,width,guide_height+thick],center=false);
        //Assemble bracket
        translate([0,-(width/2),0]){
            difference(){
                cube([guide_dist,width,thick]);
                translate([border,border,-1])
                cube([guide_dist-border*2,width-border*2,thick+2]);
            }
        }
    }
}