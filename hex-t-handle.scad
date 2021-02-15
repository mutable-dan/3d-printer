// t-hex key holder

include <lib/BOSL2/std.scad>

hex_english = [ 3/32, 7/64, 1/8, 5/32, 3/16, 7/32, 1/4 ];
hex_metric  = [  2.5,    3,    4,   5,    6,    8,  10 ];

echo( hex_metric );
echo( hex_english );

isMetric = false;
pct_tolerance = 5;

if( isMetric )
{
    echo( len(hex_metric), " metric wrenches" );
    space_between = 22;
    edge = 10;
    x = (len(hex_metric)) * space_between + edge;
    y = 28;
    z = 20;

    positions = [ for (a = [0 : len(hex_metric)-1]) let (b = a*space_between) b ];
    echo( "positions=",  positions );

    difference()
    {
        cube( [x, y, z] );
        position = 0;
        for( i = [0 : 1 : len(hex_metric)-1] )
        {
            hx = edge + positions[i];
            hr = hex_metric[i] + hex_metric[i]*pct_tolerance/100;
            echo( "hex:", positions[i], hex_metric[i] );
            translate( [hx, y/2, 0] ) linear_extrude( z ) hexagon( or = hr );
        }
    }
} else
{
    echo( "english wrenches" );
    echo( len(hex_english), " english wrenches" );
    space_between = 1;
    edge = 3/4;
    x = (len(hex_english)) * space_between + edge;
    y = 1+1/4;
    z = 1;

    positions = [ for (a = [0 : len(hex_english)-1]) let (b = a*space_between) b ];
    echo( "positions=",  positions );

    difference()
    {
        cube( [x, y, z] );
        position = 0;
        for( i = [0 : 1 : len(hex_english)-1] )
        {
            hx = edge + positions[i];
            hr = hex_english[i] + hex_english[i]*pct_tolerance/100;
            echo( "hex:", positions[i], hex_english[i] );
            translate( [hx, y/2, 0] ) linear_extrude( z ) hexagon( or = hr );
        }
    }
}