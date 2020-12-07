scaling = 1;

difference(){
    linear_extrude(4) circle(d=(40 * scaling));
    color("blue") linear_extrude(2) import(file = "celtic-knot-5.svg", center = true, dpi = (1100 / scaling));
}