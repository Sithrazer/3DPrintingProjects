// Coin Holder Keychain
// by Sithrazer
// https://github.com/Sithrazer/3DPrintingProjects
// License CC BY-NC-SA
// https://creativecommons.org/licenses/by-nc-sa/4.0/

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
keyring=1; //[0:False,1:True]
//Diameter of the keyring feature
fob_d=10;
//Keyring feature offset
fob_offset=0.6;//[0.1:0.1:5]
//Diameter of keyring hole
keyhole_d=6;
//Add case trim?
case_trim=0; //[0:False,1:True]
//Case trim style
case_trim_style=0; //[0:Scales,1:Flags,2:Daggers,3:Scallops]
//As a percentage of the case size
case_trim_size=0.50; //[0.05:0.05:2.00]
//Number of trim pieces
case_trim_num=8; //[1:20]
//Width of trim pieces as percentage of spacing
case_trim_width=1.0; //[0.05:0.05:2.0]
//Adjust position of case trim around periphery
case_trim_r=0.0; //[0.0:0.5:180]

/*[Display Features]*/
//Display both sides?
sides=1; //[0:False,1:True]
//Percentage of coin face to display
display_d=0.95; //[0.05:0.05:1]
//embellishments around the edge of the retention face
display_trim=0;//[0:Plain,1:Scales,2:Flags,3:Daggers,4:Lace,5:Scallops,6:Wave,7:Sawtooth]
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
//Make case body?
body=1; //[0:False,1:True]
//Make case retainer?
retainer=1; //[0:False,1:True]
//Make retainer detents?
detent=1; //[0:False,1:True]
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
            if (detent){
                rotate([0,0,-30]) make_ring(3,90){ //snap-fit detent recesses
                    translate([detent_r,0,coin_ft/2]) cylinder(detent_sr*2,r=detent_sr,center=true);
                }
            }
        }
    }
}

if(retainer){ //make retainer with unbuffered coin vars
    translate([0,case_fd,coin_t/2]){
        make_retainer(case_fd,case_ft,fob_d,coin_d,coin_t,keyhole_d);
        if (detent){
            rotate([0,0,-30]) make_ring(3,90){ //snap-fit detents
                translate([detent_r,0,(coin_t/2)-(detent_sr*0.3)]) sphere(detent_sr*0.9);
            }
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
        if(case_trim){
            make_case_trim(case_ft,case_fd,case_trim_style,case_trim_num,case_trim_size,case_trim_width,case_trim_r);
        }
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
        intersection(){
        make_ring(trim_num){
            rotate([0,0,feature_r]) translate([cn_d/2-feat_t/3,0,0]) cube([feat_t,feat_w,cs_t],center=true);
        }
        cylinder(cs_t+1,d=cn_fd,center=true);
    }
    }
    else if (display_trim==3){ //make dagger (triangular) retainers
        intersection(){
        make_ring(trim_num){
            rotate([0,0,feature_r]) translate([cn_d/2,0,-(cs_t/2)]) linear_extrude(height=cs_t) polygon(points=[[0,-(feat_w/2)],[2,0],[0,feat_w/2],[-(feat_t),0]]);
        }
        cylinder(cs_t+1,d=cn_fd,center=true);
    }
    }
    else if (display_trim==4){ //make lace retainers
        intersection(){
            make_ring(trim_num){
                difference(){
                rotate([0,0,feature_r]) translate([cn_d/2,0,0]) resize([feat_t*2,0,0]) cylinder(cs_t,d=feat_w,center=true);
                rotate([0,0,feature_r]) translate([cn_d/2,0,0]) resize([(feat_t*2)*0.5,0,0]) cylinder(cs_t+1,d=feat_w*0.5,center=true);
                }
            }
            cylinder(cs_t+1,d=cn_fd,center=true);
        }
    }
    else if (display_trim==5){ //make scallops
        difference(){
            cylinder(cs_t,d=cn_fd,center=true);
            cylinder(cs_t+1,d=cn_d*dis_d,center=true);
            make_ring(trim_num){
                rotate([0,0,feature_r]) translate([(cn_d*dis_d)/2,0,0]) resize([feat_t*2,0,0]) cylinder(cs_t+1,d=feat_w,center=true);
            }
        }
    }
}

module make_case_trim(cs_t,cs_d,trim_style,trim_num,trim_s,trim_w,trim_rot){
    echo(cs_d);
    //radial thickness of features
    feat_t=cs_d/2*trim_s;
    //circumferential width of features
    feat_w=(cs_d/trim_num)*trim_w;
    
    difference(){
        if (trim_style==0){ //Scales
            make_ring(trim_num){
                rotate([0,0,trim_rot]) translate([0,(cs_d/2)*.95,0]) resize([feat_w*2,0,0]) cylinder(cs_t,d=feat_t,center=true);
            }
        }
        else if (trim_style==1){ //Flags
            make_ring(trim_num){
                rotate([0,0,trim_rot]) translate([cs_d/2,0,0]) cube ([feat_t,feat_w*2,cs_t],center=true);
            }
        }
        else if (trim_style==2){ //Daggers
            make_ring(trim_num){
                rotate([0,0,trim_rot]) translate([-(cs_d/2)*0.95,0,-(cs_t/2)])linear_extrude(height=cs_t) polygon(points=[[0,-(feat_w)],[2,0],[0,feat_w],[-(feat_t),0]]);
            }
        }
        else if (trim_style==3){ //Scales
            difference(){
                cylinder(cs_t,d=cs_d+feat_t,center=true);
                make_ring(trim_num){
                rotate([0,0,trim_rot]) translate([0,(cs_d/2)+(feat_t/2),0]) resize([feat_w*2,0,0]) cylinder(cs_t+1,d=feat_t,center=true);
                }
            }
        }
        cylinder(cs_t+1,d=coin_fd,center=true);
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
            //coin slot region
            hull(){
                cylinder(cn_t,d=cn_d,center=true);
                translate([cs_d*fob_offset+fob_d,0,0]) cylinder(cn_t,d=cn_d,center=true);
            }
        }
        //coin space
        cylinder(cs_t,d=coin_fd,center=true);
        //keyhole space
        translate([cs_d*fob_offset,0,0]) cylinder(cs_t,d=kh_d,center=true);
    }
}