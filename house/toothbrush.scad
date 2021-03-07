include <modules.scad>

thickness = 3/32;
width     = 3;
depth     = 2.25;

// brush dim
brush_width  = 1 + 3/32;   // 1 3/32
brush_length = 1 + 3/16;   // 1 3/16

$fn=40;

module outline(wall = 1) {
  difference() {
    offset(wall / 2) children();
    offset(-wall / 2) children();
  }
}

module right_triangle( s1=1, s2=1, r=0, h=1 )
{
    hull()
    {
        cylinder( r=r, h=h );
        translate([s1-r*2, 0, 0]) cylinder( r=r, h=h );
        translate([0, s2-r*2, 0]) cylinder( r=r, h=h );
    }
}

module right_triangle2( s1=1, s2=1, r=0, h=1 )
{
    hull()
    {
        cylinder( r=r, h=h );
        translate([s1-r*2, 0, 0]) cylinder( r=r, h=h );
        translate([0, s2-r*2, 0]) cylinder( r=r, h=h );
    }
}

// base
translate([0,0,0])
{
    color( "white" )
    // cube([width, depth, thickness]);
    linear_extrude( thickness ) offset(r=.1) square( [width, depth] );
}

// side supports
translate([width, 0, thickness]) 
{
    // rotate( [0,-90,0] ) linear_extrude(1/32) square(size=[1, 1], center=false);    
    rotate( [0,-90,0] ) right_triangle2( 1, 1, .1, thickness );
}
translate([thickness, 0, thickness]) 
{
    // rotate( [0,-90,0] ) linear_extrude(1/32) square(size=[1, 1], center=false);    
    rotate( [0,-90,0] ) right_triangle2( 1, 1, .1, thickness );
}

// holder
translate( [1.5, 1.25, thickness] )
{
    linear_extrude( 1 )
    {
        difference()
        {
            // resize([1, 1+2/32 , 0]) scale([1/100, 1/100, 1/100]) 
            //resize([1+2/32, 1+4/32 , 0]) scale([1/100, 1/100, 1/100]) 
            resize([brush_width+5/32, brush_length+5/32 , 0]) scale([1/100, 1/100, 1/100]) 
            {
                difference()
                {
                    {
                        circle( 100 ); 
                        circle(  90 );
                    }
                }
            }
            translate( [0,0.15, 0])
            {
                rotate(45) square( [1,1] );
            }
        }
    }
}

//measure holder
*translate( [width/3.15, depth/1.9, 1+thickness]) cube( [brush_width, 1/32, 1/32] );
*translate( [depth/1.5, width/4.6, 1+thickness]) rotate(90) cube( [brush_length, 1/32, 1/32] );

// back wall
translate([0, 0, 0]) 
{
    color( "white" ) rotate( [90,0,0] ) roundedcube( [width, 1.1, thickness], radius=.05, apply_to="zmax");
    // color( "white" ) rotate( [90,0,0] ) linear_extrude( 2/32 ) offset(r=.1) square( [width, 1.5]);
    // color( "white" ) rotate( [90,0,0] ) linear_extrude( thickness ) square( [width, 1.5]);
}

// brush support
translate( [width/3.2,  depth/1.9, thickness]) cube( [ 7/32, 2/32, 2/32 ]);
translate( [width/1.63, depth/1.9, thickness]) cube( [ 7/32, 2/32, 2/32 ]);
translate( [width/1.95, depth/3.5, thickness]) rotate( [0,0,90] ) cube( [ 7/32, 2/32, 2/32 ]);

//feet
// for( x=[0:.2:width+thickness] )
// {
//     // echo( x )
//     translate( [width+.05 - x,-0.05,-2/32] )
//     {
//         rotate( [0,0,90]) linear_extrude(2/32) square( [depth+thickness, thickness] );
//     }
// }
// translate( [width-.01 -.1,0,-2/32] )
// {
//     rotate( [0,0,90]) linear_extrude(2/32) square( [depth, thickness] );
// }

