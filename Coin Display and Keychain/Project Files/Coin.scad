// Coin Holder Keychain
$fn=90;
//customizer variables
/*[Coin Pocket]*/
coin_d=20; //coin diameter
coin_t=2; //coin thickness

/*[Outer Shell]*/
//make these variables be the overage beyond the size of the coin?
case_d=22; //case diameter
case_t=4; //case thickness
keyring=true; //make keyring features
fob_d=6; //diameter of keyring protrusion feature --as percentage of coin/body size?
fob_offset=0.6;//[0.1:0.1:5]
keyhole_d=2; //diameter of keyring hole

/*[Display Features]*/
sides=true;
display_d=0.90; //[0.5:0.5:100]
//embellishments around the edge of the retention face
display_trim=0;//[0:plain,1:lace,2:flags,3:daggers]
//add options for trim size/width/spacing


//pad variables from customizer input?
coin_b=0.25; //buffer coin dimensions by this amount to allow for clearance of the coin into the holder [0:0.05:1]

translate([0,0,case_t/2]) make_shell(case_d,case_t,fob_d,coin_d,coin_t,keyhole_d);
translate([0,case_d,coin_t/2])
make_retainer(case_d,case_t,fob_d,coin_d,coin_t,keyhole_d);

//module make_shell --build main body
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

//module make_retainer
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
