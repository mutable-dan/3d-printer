include <../lib/BOSL2/std.scad>

// requires lib
// https://github.com/revarbat/BOSL2


// phone stand
phone = true;


if( phone == true )
{
    // phone dims
    echo( "phone" );
    phone_len        = 95;
    phone_width      = 70;
    phone_depth      = 15.5; //  0.5" -> 12.7mm -- used to size phone holder
    t = 5;                  // wall thickness
    draw( device_len=phone_len, device_width=phone_width, cradle_len=phone_depth, thickness=t );
} else
{
    // tablet dims
    echo( "tablet" );
    tablet_len        = 120;
    tablet_width      = 100;
    tablet_depth      = 20; //  0.5" -> 12.7mm -- used to size phone holder
    t = 5;                  // wall thickness
    draw( device_len=tablet_len, device_width=tablet_width, cradle_len=tablet_depth, thickness=t );
}
$fn=25;

fillet = 5;


module draw( device_len, device_width, cradle_len, thickness )
{
    wall = 10;
    difference()
    {
        rotate( [0,0,0] ) linear_extrude( device_width ) trapezoid( w1=device_len,w2=0, h=device_len, rounding=[fillet, fillet, fillet, 0], anchor=LEFT );
        translate( [wall/2, wall/2, 0] )
        {
            rotate( [0,0,0] ) linear_extrude( device_width ) trapezoid( w1=device_len-wall,w2=0, h=device_len-wall, rounding=[fillet, fillet, fillet, 0], anchor=LEFT );
        }
    }

    rotate( [0,0,-30]) 
    {
        translate( [-cradle_len-thickness,0,0])             cube( [cradle_len+thickness, thickness, device_width] );
        translate( [-cradle_len-thickness,thickness,0])     cube( [thickness, thickness, device_width] );
        translate( [-cradle_len-thickness/2,thickness*2,0]) cylinder( d=thickness, h=device_width );
        
    }
}
