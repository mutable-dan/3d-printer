// flashlight stand
// infill X% - pattern"
// no supports

include <../lib/BOSL2/std.scad>

d      = 25;
d_base = 65;
h      = 25;
t      = 1.5;

$fn=100;

up( t )
{
    tube(  h = h, id = d, wall= t );
    tube(  h = h-2*t, id2 = d+t, od1=d_base, wall= t );
}
zcyl( h = t, r = d_base/2, anchor=BOTTOM );
