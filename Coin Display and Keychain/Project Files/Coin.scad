// Coin Holder Keychain

//To Do:
//Move building of display features in to own module
//Correct display features to use unbuffered coin dimensions
//*BUG* keyhole feature on retainer restricted by coin diameter

/*[Coin Pocket]*/
//Coin Diameter
coin_d=24.25;
//Coin Thickness
coin_t=1.75;

/*[Outer Shell]*/
//How much wider than the coin to make the case
case_d=8;
//How much thicker than the coin to make the case
case_t=4; //case thickness
//Make keyring features?
keyring=true;
//Diameter of the keyring feature
fob_d=10;
//Keyring feature offset
fob_offset=0.6;//[0.1:0.1:5]
//Diameter of keyring hole
keyhole_d=6;

/*[Display Features]*/
//Display both sides?
sides=true;
//Percentage of coin face to display
display_d=0.95; //[0.05:0.05:0.95]
//embellishments around the edge of the retention face
//display_trim=0;//[0:plain,1:lace,2:flags,3:daggers]
//add options for trim size/width/spacing

/*[Advanced]*/
//pad variables from customizer input
//buffer coin dimensions by this amount to allow for clearance of the coin into the holder
coin_b=0.2; //[0:0.05:1]
//Circle resolution; higher values may result in increased rendering, slicing and print times.
$fn=40; //[4:360]
coin_fd=coin_d+coin_b; //buffer coin diameter
coin_ft=coin_t+coin_b; //buffer coin thickness
case_fd=coin_d+case_d; //final diameter of case
case_ft=coin_t+case_t; //final thickness of case

//make shell with buffered coin vars
translate([0,0,case_t/2]) make_shell(case_fd,case_ft,fob_d,coin_fd,coin_ft,keyhole_d);

//make retainer with unbuffered coin vars
translate([0,case_fd,coin_t/2])
make_retainer(case_fd,case_ft,fob_d,coin_d,coin_t,keyhole_d);

//build main body
module make_shell(cs_d,cs_t,k_d,cn_d,cn_t,kh_d){
    difference(){
        //shell
        hull(){
            cylinder(cs_t,d=cs_d,center=true);
            if(keyring){
                translate([cs_d*fob_offset,0,0]) cylinder(cs_t,d=k_d,center=true);
            }
        }
        //coin pocket
        hull(){
            cylinder(cn_t,d=cn_d,center=true);
            translate([cs_d*fob_offset,0,0]) cylinder(cn_t,d=cn_d,center=true);
        }
        //keyhole
        if (keyring){
            translate([cs_d*fob_offset,0,0]) cylinder(cs_t,d=kh_d,center=true);
        }
        //display opening
        if (sides) {
            cylinder(cs_t,d=cn_d*display_d,center=true);
        }
        else {
            translate([0,0,case_t/2]) cylinder(cs_t,d=cn_d*display_d,center=true);
        }
    }
    
}


//build display features
module make_display(){
}

//build retention insert
module make_retainer(cs_d,cs_t,k_d,cn_d,cn_t,kh_d){
    difference(){
        intersection(){
            //base shape
            hull(){
                //shell
                cylinder(cn_t,d=cs_d,center=true);
                //keyhole
                if (keyring){
                    translate([cs_d*fob_offset,0,0]) cylinder(cn_t,d=k_d,center=true);
                }
            }
            //coin region
            hull(){
                cylinder(cn_t,d=cn_d,center=true);
                translate([cs_d*fob_offset,0,0]) cylinder(cn_t,d=cn_d,center=true);
            }
        }
        //coin space
        cylinder(cn_t,d=cn_d,center=true);
        //keyhole space
        translate([cs_d*fob_offset,0,0]) cylinder(cs_t,d=kh_d,center=true);
    }
}
