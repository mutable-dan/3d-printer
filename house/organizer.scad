// organizer
// infill X% - pattern"
// no supports

include <../lib/BOSL2/std.scad>

// requires lib
// https://github.com/revarbat/BOSL2


l = 100;
w =  50;
h =  50;

l1 = 20;
h2 = 35;

t = 2;
r = 5;

include <../lib/BOSL2/rounding.scad>
$fn=36;

difference()
{
    cuboid( [l,w,h], rounding=r, edges=[BOTTOM+RIGHT+LEFT, RIGHT+FRONT, LEFT+FRONT, BACK+RIGHT,BACK+LEFT], anchor=BOTTOM+LEFT+FRONT );
    up( t  ) right(t)      back(t)     cuboid( [l-l1-t, w-2*t, h], rounding=r, edges=[BOTTOM+RIGHT+LEFT, RIGHT+FRONT, LEFT+FRONT, BACK+RIGHT,BACK+LEFT], anchor=BOTTOM+LEFT+FRONT );
    up( t  ) right(l-l1+t) back(t)     cuboid( [l1-2*t, w/2-2*t, h], rounding=r, edges=[BOTTOM+RIGHT+LEFT, RIGHT+FRONT, LEFT+FRONT, BACK+RIGHT,BACK+LEFT], anchor=BOTTOM+LEFT+FRONT );
    up( t  ) right(l-l1+t) back(w/2+t) cuboid( [l1-2*t, w/2-2*t, h], rounding=r, edges=[BOTTOM+RIGHT+LEFT, RIGHT+FRONT, LEFT+FRONT, BACK+RIGHT,BACK+LEFT], anchor=BOTTOM+LEFT+FRONT );
    up( h2 )                           cuboid( [l-l1, w, h2], rounding=r, edges=[BOTTOM+RIGHT], anchor=BOTTOM+LEFT+FRONT);
}
