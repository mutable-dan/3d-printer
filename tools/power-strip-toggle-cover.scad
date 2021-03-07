include <../lib/BOSL2/std.scad>

// requires library
// https://github.com/revarbat/BOSL2


// on belkin power strip+surge the toggle switch is sensitive to accidental turning off
// this cover will protect

// |---- w1 ----|
// -------------- ----
// |            | |
// |            | h1
// |            | |
// --          -- ----
//   |         |   |
//   |         |   h2
//   |         |   |
//   |---w2 ---| -----

tolerance = 0.20;

t = 1.5;  // wall thickness

h1 = 21 + t;
h2 =  5;
w1 = 50 + 2*t + +tolerance;
w2 = 47 + 2*t + tolerance;
l  = 40;
r  =  1;


w_top = w1 - 5;
l_top = 20;

$fn=30;


difference()
{
    union()
    {
        difference()
        {
            cuboid( [l, w1, h1], rounding=r, anchor=BOTTOM );
            translate( [0, 0, t/2] ) cuboid( [l, w1-t, h1-t], rounding=r, anchor=BOTTOM );
            translate( [0, 0,-t] ) cuboid( [l, w2-t, h1],                 anchor=BOTTOM );
        }
        difference()
        {
            cuboid( [l, w2, h2], anchor=TOP );
            translate( [0, 0,0] ) cuboid( [l, w2-t, h2], anchor=TOP );
        }
    }
    translate( [0,0,h1] ) cube( [l_top, w_top-5,t], center=true );
}

translate( [0,0,h1-t/2] ) top( w_top, l_top/2 );

module top( length, radius )
{
    r = radius;
    l = length - 5;
    difference()
    {
        ycyl( l=l,   r=r );
        ycyl( l=l-t, r=r-t );
        translate( [0,0,-r/2])    cube( [r*2,l,r], center=true);
    }
}