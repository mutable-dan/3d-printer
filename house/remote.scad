// remote - stand
// infill 15% - pattern cubic
// no supports

include <../lib/BOSL2/std.scad>
include <../lib/BOSL2/hull.scad>

// requires lib
// https://github.com/revarbat/BOSL2

// hold two remotes bottom to bottom to take up less space
// 

h = 100;         // height of silo
t =   2;         // wall thickness
w1 = 25;         // thickness remote 1
w2 = 30;         // thickness remote 2
w =  w1 + w2;    // width of remotes
wt=  w + 2*t+t;  // add walls, cube dist is to outside of wall and wall thickness of spacer
d =  65;         // thickness of remote
dt=  d + 2*t;    // add walls and separator, cube dist is to outside of wall
// ------------- ----
// | xxxxxxxxx |  |
// |  xxxxxxx  |  |
// |-----------|  w
// | xxxxxxxxx |  |
// |  xxxxxxx  |  |
// ------------- ----
// |---- d ----|

rounding = 4;
$fn=30;

o0 = (w2-w1)/2-t/2;
translate( [o0,-dt/2,0]) cube( [t,dt,h] );
rect_tube( size=[wt,dt], wall=t, h=h, rounding=rounding, irounding=rounding*2 )
{
    // make base
    attach( BOTTOM) prismoid( size1=[wt+2*t, dt+2*t], size2=[wt+wt*2/3, dt/2+dt*2/3+10], h=20, rounding1=rounding*2, rounding2=2 );
}

// test dims
 *translate( [0,0,h] ) cube( [t, dt,t], center=true );
 *translate( [0,0,h] ) cube( [wt, t,t], center=true );

o2 = -wt/2+t;
o1 = o0+t;
#translate( [o1,0,h] ) cube( [w1, t,t], center=false );
#translate( [o2,5,h] ) cube( [w2, t,t], center=false );




