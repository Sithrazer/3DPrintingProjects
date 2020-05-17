/* Coin Holder Keychain */

/*customizer variables*/
$fn=120;
coin_d=20; //coin diameter
coin_t=2; //coin thickness
outer_d=2; //how much larger the outside diameter is than the coin
t_dia=coin_d+outer_d; //total outside diameter
display_d=15; //defines retention lip and how much of the coin face is displayed --as percentage? [0:0.5:100]
coin_b=0.5; //buffer coin dimensions by this amount to allow for clearance of the coin into the holder [0:0.1:1]
keyring=true; //make keyring features
fob_d=6; //diameter of keyring protrusion feature --as percentage of coin/body size?
keyhole_d=2; //diameter of keyring hole --scaleable to accomodate other affixations

/*pad variables from customizer input*/

difference(){
    hull(){
        cylinder(coin_t+outer_d,d=coin_d+outer_d,center=true);
        translate([coin_d*.6,0,0]) cylinder(coin_t+outer_d,d=6,center=true);
    }
    cylinder(coin_t,d=coin_d,center=true);
    cylinder(coin_t+outer_d,d=display_d,center=true);
}
//module make_shell --build main body

//module make_retainer --build insert to fill coin ingress/egress slot