// omnipod dash - stand
// infill 5% - pattern cubic
// no supports

include <../lib/BOSL2/std.scad>

// requires lib
// https://github.com/revarbat/BOSL2



name = "NAME HERE";

dash_len        = 95;
dash_width      = 71; 
dash_depth      = 15.5; 

font_sz = 7.5;
t = 5;                  // wall thickness
$fn=25;

fillet = 5;

rotate( [90,0,0] )
{
    difference()
    {
        rotate( [0,0,0] ) linear_extrude( dash_width+2*t ) trapezoid( w1=dash_len,w2=0, h=dash_len, rounding=[fillet, fillet, fillet, 0], anchor=LEFT );

        #translate( [dash_depth+2*t,t,t ]) rotate( [0,0,63.5] ) cube( [dash_len, dash_depth, dash_width] );    // pocket
        translate( [2*t+2,2*t,t+t])        rotate( [0,0,63.5] ) cube( [dash_len, t+5, dash_width-2*t] );  // holder
    }
    translate( [3.5, t+2, dash_width/2+t] ) rotate( [90,-90,-120] ) linear_extrude( height=3 ) text( name, size=font_sz, valign="center", halign="center" );
}

