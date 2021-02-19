
l = 60;
w = 50;
d = 5;

translate( [l/2, 0, d] ) resize([l, w, d]) rotate( [0, 90, 90]) import( "Jacket4.stl" );

tag_l = 40;
tag_w = 20;
tag_d = 4;
t = 3;

difference()
{
    difference()
    {
        translate( [0, -tag_w/2-t/2, -tag_d-t] ) cube( [tag_l+t, tag_w+t, tag_d+t] );
        translate( [0, -tag_w/2, -tag_d] ) cube( [tag_l, tag_w, tag_d] );
    }

    size = 10;
    translate( [size+size/2, size/2, -d-t+2] ) rotate( [0,180,90]) linear_extrude( 1 ) text( "R", size=size );
}