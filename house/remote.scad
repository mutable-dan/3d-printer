// remote - stand
// infill 15% - pattern cubic
// no supports

include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

// requires lib
// https://github.com/revarbat/BOSL2

// hold two remotes bottom to bottom to take up less space
// 

h = 100;
w =  60;  // width of remotes
d =  50;  // thickness of remote
t =   2;  // wall thickness
d1=  d + 2*t;  // add walls and separator, cube dist is to outside of wall
w1=  w + 2*t;  // add walls, cube dist is to outside of wall
rounding = 4;
$fn=30;


translate( [0,-d1/2,0]) cube( [t,d1,h] );
rect_tube( size=[w1,d1], wall=t, h=h, rounding=rounding, irounding=rounding*2 )
{
    // make base
    attach( BOTTOM) prismoid( size1=[w1+2*t, d1+2*t], size2=[w1+w1*2/3, d1/2+d1*2/3+10], h=20, rounding1=rounding*2, rounding2=2 );
}

// test dims
*translate( [0,0,h] ) cube( [t, d,t], center=true );
*translate( [0,0,h] ) cube( [w, t,t], center=true );


