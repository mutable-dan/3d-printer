// t-hex key holder

// https://github.com/revarbat/BOSL2
include <../lib/BOSL2/std.scad>

hex_english = [ 3/32, 7/64, 1/8, 5/32, 3/16, 7/32, 1/4 ];
hex_metric  = [  2.5,    3,    4,   5,    6,    8,  10 ];

hex_metric_txt  = [  "2.5",    "3",    "4",   "5",    "6",    "8",  "10" ];
hex_english_txt = [ "3/32", "7/64", "1/8", "5/32", "3/16", "7/32", "1/4" ];

// hex_metric      = [  2.5,     5,   10 ];     // testing
// hex_metric_txt  = [  "2.5",   "5",  "10" ];  // testing

isMetric = true;

if( isMetric )
{
    echo( len(hex_metric), " metric wrenches" );
    mm_tolerance = 0.5;
    space_between = 24;
    edge = 8;
    x = ((len(hex_metric)) * space_between)-edge + edge;
    y = 20;
    z = 15;

    positions = [ for (a = [0 : len(hex_metric)-1]) let (b = a*space_between) b ];
    echo( "positions=",  positions );

    difference()
    {
        cube( [x, y, z] );
        for( i = [0 : 1 : len(hex_metric)-1] )
        {
            hx = edge + positions[i];
            hr = hex_metric[i] + mm_tolerance;
            echo( "hex:", positions[i], hex_metric[i], mm_tolerance );
            translate( [hx, y/2, 0] ) linear_extrude( z ) hexagon( id = hr );
        }
    }
    for( i = [0 : 1 : len(hex_metric)-1] )
    {
        hx = edge + positions[i];
        hr = hex_metric[i] + mm_tolerance;
        translate( [hx-4, 0, z/2] ) rotate( [90,0,0]) linear_extrude( 1 ) text( size=5, valign="center", hex_metric_txt[i] );
    }

} else
{
    echo( "english wrenches" );
    echo( len(hex_english), " english wrenches" );
    
    in_tolerance = 1/64;
    space_between = 7/8;
    edge = 5/16;
    x = ((len(hex_english)) * space_between)-edge + edge;
    y = 25/32;
    z = 18/32;

    positions = [ for (a = [0 : len(hex_english)-1]) let (b = a*space_between) b ];
    echo( "positions=",  positions );

    difference()
    {
        cube( [x, y, z] );
        position = 0;
        for( i = [0 : 1 : len(hex_english)-1] )
        {
            hx = edge + positions[i];
            hr = hex_english[i] + in_tolerance;
            echo( "hex:", positions[i], hex_english[i] );
            translate( [hx, y/2, 0] ) linear_extrude( z ) hexagon( id = hr );
        }
    }
    for( i = [0 : 1 : len(hex_metric)-1] )
    {
        hx = edge + positions[i];
        hr = hex_metric[i] + in_tolerance;
        translate( [hx-1/4, 0, z/2] ) rotate( [90,0,0]) linear_extrude( 1/32 ) text( size=1/4, valign="center", hex_english_txt[i] );
    }

}
