// Coin Holder Keychain

//To Do:
//Expand display features

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
display_d=0.95; //[0.05:0.05:1]
//embellishments around the edge of the retention face
display_trim=0;//[0:plain,1:scales,2:flags,3:daggers]
//Number of trim pieces, no effect on 'plain'
trim_num=8;//[2:20]
//Width of trim pieces as percentage of spacing
trim_width=1;//[0.1:0.05:2]
//Adjust position of display features around periphery 
feature_r=0;//[0:0.5:180]
//add options for trim size/width/spacing

/*[Advanced]*/
//pad variables from customizer input
//buffer coin dimensions by this amount to allow for clearance of the coin into the holder
coin_b=0.2; //[0:0.05:1]
//Circle resolution; higher values may result in increased rendering, slicing and print times.
$fn=40; //[4:360]
//Uncheck to exclude case body
body=true;
//Uncheck to exclude case retainer
retainer=true;
coin_fd=coin_d+coin_b; //buffer coin diameter
coin_ft=coin_t+coin_b; //buffer coin thickness
case_fd=coin_fd+case_d; //final diameter of case
case_ft=coin_t+case_t; //final thickness of case
coin_c=PI*(coin_d/2); //coin circumference
detent_r=(case_fd/2-coin_fd/2)/2+coin_fd/2;
detent_sr=1;

if(body){ //make shell with buffered coin vars
    translate([0,0,case_ft/2]){ //correct vertical offset
        difference(){
            make_shell(case_fd,case_ft,fob_d,coin_fd,coin_ft,keyhole_d);
            rotate([0,0,-30]) make_ring(3,90){ //snap-fit detent recesses
                translate([detent_r,0,-(coin_ft/2)]) sphere(detent_sr);
            }
        }
    }
}

if(retainer){ //make retainer with unbuffered coin vars
    translate([0,case_fd,coin_t/2]){
        make_retainer(case_fd,case_ft,fob_d,coin_d,coin_t,keyhole_d);
        rotate([0,0,-30]) make_ring(3,90){ //snap-fit detents
            translate([detent_r,0,(coin_t/2)-(detent_sr*.3)]) sphere(detent_sr);
        }
    }
}

//build main body
module make_shell(cs_d,cs_t,k_d,cn_d,cn_t,kh_d){
    difference(){
    union(){//shell w/through hole
        difference(){
            //shell
            hull(){
                cylinder(cs_t,d=cs_d,center=true);
                if(keyring){
                    translate([cs_d*fob_offset,0,0]) cylinder(cs_t,d=k_d,center=true);
                }
            }
            //face through-hole
            cylinder(cs_t+2,d=cn_d,center=true);
        }
        make_display(sides,case_ft,coin_d,display_d,coin_fd,coin_ft);
    }
        //coin slot
        hull(){
            cylinder(cn_t,d=cn_d,center=true);
            if (keyring){ //unessesary?
                translate([cs_d*fob_offset+fob_d,0,0]) cylinder(cn_t,d=cn_d,center=true);
            }
            else {
                translate([cs_d,0,0]) cylinder(cn_t,d=cn_d,center=true);
            }
        }
        //keyhole
        if (keyring){
            translate([cs_d*fob_offset,0,0]) cylinder(cs_t+1,d=kh_d,center=true);
        }
    }
}


//build display features
module make_display(sides,cs_t,cn_d,dis_d,cn_fd,cn_ft){
    //radial thickness of display features
    feat_t=cn_d/2-(cn_d/2)*dis_d;
    //circumferential width of display features
    feat_w=(coin_c/trim_num)*trim_width;
    
    //close backside if single-sided
    if (!sides) {
        translate([0,0,-(cs_t/2)]) cylinder(cs_t/2-cn_ft/2,d=cn_fd,center=!true);
        echo();
    }
    
    //choose display feature type
    if (display_trim==0){ //make plain retainer
        difference(){
            cylinder(cs_t,d=cn_fd,center=true);
            cylinder(cs_t+1,d=cn_d*dis_d,center=true);
        }
    }
    else if (display_trim==1){ //make scales (round) retainers
        intersection(){
        make_ring(trim_num){
            rotate([0,0,feature_r]) translate([cn_d/2,0,0])
            resize([feat_t*2,0,0]) cylinder(cs_t,d=feat_w,center=true);
        }
        cylinder(cs_t+1,d=cn_fd,center=true);
    }
    }
    else if (display_trim==2){ //make flag (square) retainers
        make_ring(trim_num){
            rotate([0,0,feature_r]) translate([cn_d/2-feat_t/3,0,0]) cube([feat_t,feat_w,cs_t],center=true);
        }
    }
}

//rotator function for display features
module make_ring(count,degrees=360){
    for( i = [0:count-1]){
        angle = i * degrees / count;
        rotate([0,0,angle])
        children();
    }
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
                translate([cs_d*fob_offset+fob_d,0,0]) cylinder(cn_t,d=cn_d,center=true);
            }
        }
        //coin space
        cylinder(cs_t,d=cn_d,center=true);
        //keyhole space
        translate([cs_d*fob_offset,0,0]) cylinder(cs_t,d=kh_d,center=true);
    }
}