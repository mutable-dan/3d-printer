// allen socket case

include <../lib/BOSL2/std.scad>
// https://github.com/revarbat/BOSL2


// config
// ******************************************************
// socket dia 30/64 -> 15/32 11.9mm
n    = 8;           // number of sockets in a row
rows = 2;           // number of rows of sockets
d    = 12;          // diameter of hole for socket
tollerance = 0.31;  // wiggle room for error and platic shrink. 0.1 -> does not fit, 0.2 -> too tight, 0.3 -> nice fit

// holes
cyl_h = 17;                             // depth of hole
space_between = 5;                      // space between holes
cyl_offset_from_bottom = 3;             // bottom of hole to bottom of case
// config end
// ******************************************************

// mid-section dim
thickness  = 3;                         // thickness of mid-section and top wall
lip_height = 5;             

w = rows*(d + d/2) + 10; 
h = cyl_h + cyl_offset_from_bottom;     // height of bottom of case
l = n*space_between+n*d + d/2;          // length of case with n holes

$fn=30;

base( l=l, rows=rows, w=w, h=h, d=d+tollerance, space_between=space_between );
translate( [0,0,h] ) mid_section( t=thickness, l=l, w=w, h=lip_height );


module base( n=n, rows=1, l, w, h, d, space_between )
{
    eq_rows = w/rows;
    difference()
    {
        translate( [l/2,w/2,0]) cuboid([l,w,h], rounding=5, anchor=BOTTOM, edges=[BOTTOM+FRONT,BOTTOM+BACK,BOTTOM+RIGHT,BOTTOM+LEFT,FRONT+RIGHT, FRONT+LEFT, BACK+LEFT,BACK+RIGHT]);
        for( row = [1 : 1 : rows ] )
        {
            for( holes = [1 : 1 : n ] )
            {
                offset = (row-1)*eq_rows + eq_rows/2;
                translate( [holes*space_between + (holes-1)*d + d/2,  offset, cyl_offset_from_bottom] ) cylinder( d1=d, d2=d, h=cyl_h, center=false );
            }
        }
    }
}


module mid_section( t, l, w, h )
{
    difference()
    {
        translate( [l/2,w/2,0]) cuboid([l,w,h],     rounding=5, anchor=BOTTOM, edges=[LEFT+FRONT,LEFT+BACK,RIGHT+FRONT,RIGHT+BACK]);
        translate( [l/2,w/2,0]) cuboid([l-t,w-t,h], rounding=5, anchor=BOTTOM, edges=[LEFT+FRONT,LEFT+BACK,RIGHT+FRONT,RIGHT+BACK]);
    }
}

