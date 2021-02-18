include <../lib/BOSL2/std.scad>

// requires lib
// https://github.com/revarbat/BOSL2


// phone stand



phone_len        = 95;
phone_width      = 70;
phone_depth      = 15.5; //  0.5" -> 12.7mm -- used to size phone holder
t = 5;                  // wall thickness
$fn=25;

fillet = 5;

rotate( [0,0,0] ) linear_extrude( phone_width ) trapezoid( w1=phone_len,w2=0, h=phone_len, rounding=[fillet, fillet, fillet, 0], anchor=LEFT );


 rotate( [0,0,-30]) 
 {
     translate( [-phone_depth-t,0,0]) cube( [phone_depth+t, t, phone_width] );
     translate( [-phone_depth-t,t,0]) cube( [t, t, phone_width] );
     translate( [-phone_depth-t/2,t*2,0]) cylinder( d=t, h=phone_width );
     
 }
