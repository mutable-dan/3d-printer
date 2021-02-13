include <../lib/BOSL2/std.scad>

// phone stand



phone_width      = 70;
phone_thickness  = 14; //  0.5" -> 12.7mm -- used to size phone holder
charge_space     = 30; // virtical space from top of base ro bottom of front face, room for charger cord
//
//           /\
//          /  \
//         /    \   --------
//               \     charge0._space
//        ________\ ________

$fn = 100;

// x, z position of circle (fillet) center
// used also to make reduce lenghs of base and back face 
function rear_fillet_x( a, r ) = cos(-a/2)/sin(a/2)*r;
function rear_fillet_z( r ) = r;

// front face - back of phone
// where charge_space -> c
//       t            -> thickness
//       a            -> angle
//       f            -> face lengh that phpne rests against
function face_size( length, c, a ) = length - (c/sin(a));  // len of face phone rests against
function lip_z   ( c ) = c;
function face_z   ( c, t ) = c+t;
function face_x   ( c, t, a ) = (c+t)/tan(a);

// dim mm
base_len   = 100;
thickness  = 5;
radius     = 10;
angle      = 60;
base       = [ base_len-rear_fillet_x(angle, radius), thickness ];
back       = [ base_len, thickness ];
front_face = [ base_len, thickness ];

rotate( [90, 0, 0])
difference()
{
    linear_extrude( phone_width )
    {
        rotate( [0,0,0] ) union() 
        {
            draw_base();
            draw_back_face_fillet();
            translate([base_len,0,0]) 
            {
                draw_rear_angle( len=60, t=thickness, angle=60, fillet=radius );
            }
            translate([0,0,0])
            {
                draw_top_angle( L=base_len, len=30, t=thickness, angle=60, fillet=5 );
            } 

            draw_phone_craddle();
        }
    }

    cube_h = base_len/2;
    cube_w = phone_width/2;
    cube_d = base_len;
    y = thickness;
    z = cube_w/2;
    translate( [0, y, z]) cube(  [cube_d, cube_h, cube_w], center=false );

    r = cube_w/2;
    translate( [0,r+thickness+cube_h/2+r/2, phone_width/2] ) rotate( [0, 90, 0] ) cylinder( h=base_len, r=r, center=false );
}



// base - chop of front part and then add fillet front fillet
module draw_base()
{
    union()
    {
        difference()
        {
            square( base );  // base
            square( [thickness/2, thickness] ); 
        }
        translate( [thickness/2, thickness/2, 0] ) circle( thickness/2 );  // front fillet circle
    }
}

module draw_back_face_fillet()
{
    // back face + fillet
    translate( [base_len, 0, 0] ) rotate( [0, 0, 180-angle ])
    {
        union()
        {
            difference()
            {
                rotate( [0,  0, 0] ) square( back );  // back
                rotate( [0, 0, 0] ) square(  [ rear_fillet_x(angle,radius), thickness ] );  // back
            }
            translate( [base_len, thickness/2, 0])  circle( thickness/2 );
        }
    }
}

module draw_rear_fillet()
{
    translate( [base_len-rear_fillet_x(angle, radius), 0, rear_fillet_z(radius) ] ) rotate( [90, 0, 0] ) circle( radius ); 
}

module draw_phone_craddle()
{
    union()
    { 
        // phone stand 
      translate( [face_x(charge_space+thickness/4, thickness/2, angle), face_z(charge_space, thickness/2), 0] ) 
        rotate( [0,0,angle] )
        {
            union()
            {
                // face and fillet on top
                union()
                {
                    translate( [thickness/2, 0, 0] ) square( [face_size( base_len-thickness, charge_space, angle)-thickness/2, thickness] );  // front face rect
                    translate([face_size( base_len-thickness, charge_space, angle), thickness/2, 0]) circle( thickness/2 );
                }

                // bottom lip
                union()
                {
                    rotate( [0,0,-90]) 
                    translate( [-thickness/2, 0, 0] )
                    {
                        union()
                        {
                            rotate([-180, 0,-180]) square( [phone_thickness+thickness/4, thickness] );  // bottom 
                            translate( [-phone_thickness, 0, 0] ) 
                            union()  // lip
                            {
                                translate( [thickness/4,thickness/2,0] ) rotate( [0,0,90]) square( [thickness+thickness/2,thickness]);  
                                translate( [-thickness/4,thickness/2, 0]) circle(thickness/2);
                                translate( [-thickness/4,thickness*2, 0]) circle(thickness/2);
                            }
                        }
                    }
                    translate( [thickness/2, thickness/2, 0]) circle( thickness/2 );
                }
            }
        }
    }
}




module draw_rear_angle( len, angle, t, fillet )
{
    // radius = len*sin(angle)*sin(angle);  // 15
    a = angle/2;
    w = t/tan(a);
    l = len - w;

    AB = l;
    BE = AB*sin(a);
    r  = BE/sin(90-a)-t;
    BG = r/tan(a);

    x = len - AB;
    y = r+t;

    //echo( "len=",len, "w=",w, "AB=",AB, "r=",r, "BE=",BE, "BG=",BG,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        "x=",x, "y=",y );

    translate( [-len,0,0])
    difference()
    {
        rotate([0,0,0]) trapezoid( w1=len,w2=0, angle=a, rounding=[0, 0, fillet, 0], anchor=LEFT );
        translate( [x, y, 0] ) rotate( [0, 0, 0] ) circle( r );
        translate( [0,  thickness,  0] ) rotate([0,0,0])     square( [3/2*t,3/2*t] );  // bottom
        
        h = 2*BE*sin(90-a);
        ww = 2*BE*cos(90-a);
        translate( [l-ww-5.8, h, 0] ) rotate([0,0,-60]) square( [3/2*t,3/2*t] );  // top
    }
}


module draw_top_angle( L, len, angle, t , fillet ) 
{
    a = angle/2;
    h = L*sin(angle) -len + t;
    x = L - L*cos(angle) - len/2 +7 -t/tan(a);
    r = len/2;
    echo( "L=", L, "h=",h, "x=",x, "len=",len );

    translate([x-1, h, 0 ]) 
    difference()
    {
        rotate([180,0,0]) trapezoid( w1=0,w2=len, angle=a, rounding=[0, 0, fillet, 0], anchor=LEFT );    
        translate( [len/2, -thickness/2-2.8, 0]) rotate([180,0,0]) circle( r-2.5 );
    }
}

