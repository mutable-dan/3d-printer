// drain filter/cover
// infill X% - pattern"
// no supports

include <../lib/BOSL2/std.scad>

// requires lib
// https://github.com/revarbat/BOSL2

tollerance = 1/64;
// outter tube
d = 1+1/8 - tollerance;
h = 1/2;

// inner tube
hi = 1 + 3/8;
di = d - 1/4;

holes = 3/16;
t     = 1/16;

$fn=30;

translate( [0,0,hi-h-t] ) drain_tube( h=h,  d=d, t=t, hole_sz=holes );           // outter tube
                          drain_tube( h=hi-1/2, d=di,t=t, hole_sz=holes*3/4 );   // inner tube

// dome
translate( [0,0,hi-t] )   dome( d, t, holes/2 );
h_sup = 1/4;
translate( [0,0,h+t] )         tube_support( h=h_sup, t=t, d_top=d, d_bot=di );
translate( [0,0,h+t+h_sup] )   top_plate( do=d, di=di,  t=t );

module drain_tube( h, d, t, hole_sz )
{
    difference()
    {
        tube( h=h, id=d-t, od=d );
        for( offset=[0,15] )
        {
            //echo( offset);
            for( h1= [hole_sz: hole_sz+t:h-hole_sz] )
            {
                for( a = [0: 30: 360] )
                {
                    zrot( a=a ) move( x=d/2-t/2, y=0, z=h1 ) xcyl( h=t, d=hole_sz );
                }
            }
        }
    }
}

module tube_support( d_bot, d_top, t, h )
{
    // tube( h=h, id2=d_top-t, id2=d_bot-t, od1=d_top-t, od2=d_top );
    tube( h=h, od2=d_top, od1=d_bot, wall=t );
}

module top_plate( do, di, t )
{
    linear_extrude( height=t ) 
    {
        difference()
        {
            circle( d=do );
            circle( d=di );
        }
    }
}


module dome( d, t, hole_sz )
{
    top_half() 
    {
        difference()
        {
            spheroid( r = d/2 );
            spheroid( r = d/2-t );
            for( h1= [hole_sz: hole_sz+t: d/2-hole_sz] )
            {
                for( a = [0: 20: 360] )
                {
                    zrot( a=a ) move( x=d/2-t/2, y=0, z=h1 ) xcyl( h=1, d=hole_sz );
                }
            }
            zcyl( h=1.5, d=hole_sz );
            zrot_copies( [0,45,90,135,180,225,270,315 ] )
            {
                move( x=d/4-0.07, y=0, z=0 ) zcyl( h=1.5, d=hole_sz*2/3 );
            }
            
        }
    }
}