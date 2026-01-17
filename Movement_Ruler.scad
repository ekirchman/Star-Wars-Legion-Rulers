movement_ruler_width = 15;
movement_ruler_length = 30;

movement_ruler_height = 4.5;
movement_ruler_pocket_depth = 3.5;

pivot_outer_rad = 8.5;
pivot_inner_rad = 11/2;
pivot_second_inner_rad = 13/2;

ruler_ridge_length = 2;

bottom_ruler_indent = 0.5;

pivot_second_inner__bottom_offset = 1.5;

//bottom ruler piece
difference(){
    translate([-movement_ruler_width/2,0,0]){
    difference(){
        cube([ movement_ruler_width, movement_ruler_length, movement_ruler_height]);
        //Bottom large indent
        translate([1,-.01,-1])cube([movement_ruler_width-ruler_ridge_length, movement_ruler_length+0.2, movement_ruler_pocket_depth+1]);
        //top shallow indent for pivot piece
        translate([-1,-7,movement_ruler_height-bottom_ruler_indent])cube([movement_ruler_width+2, movement_ruler_length-14, bottom_ruler_indent+0.1]);
        
        }   //translate([-1,0,movement_ruler_height-bottom_ruler_indent+0.1])cube([movement_ruler_width+2, movement_ruler_length+0.2, bottom_ruler_indent]);
    }
    //larger inner circle which punches through the top
    translate([0,0,-0.1])cylinder(h=movement_ruler_height,r=pivot_inner_rad);
}
difference(){
    cylinder(h=movement_ruler_height,r=pivot_outer_rad);
    //larger inner circle which punches through the top
    translate([0,0,-0.1])cylinder(h=movement_ruler_height,r=pivot_inner_rad);
    //smaller inner circle
    translate([0,0,-0.1])cylinder(h=pivot_second_inner__bottom_offset,r=pivot_second_inner_rad);
    
    //top shallow indent for pivot piece
    translate([0,0,movement_ruler_height-bottom_ruler_indent])cylinder(h=bottom_ruler_indent+0.1,r=pivot_outer_rad+0.1);
}