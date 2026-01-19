use <Movement_Ruler_lib.scad>;
movement_ruler_width = get_movement_ruler_width();
movement_ruler_length = get_movement_1_bottom_ruler_length(); //should be 30

movement_ruler_height = get_movement_ruler_height();
movement_ruler_pocket_depth = get_movement_ruler_pocket_depth();

pivot_outer_rad = get_pivot_outer_rad();
pivot_inner_rad = get_pivot_inner_rad();
pivot_second_inner_rad = get_pivot_second_inner_rad();

ruler_ridge_length = get_ruler_ridge_length();

bottom_ruler_indent = get_bottom_ruler_indent();

pivot_second_inner_bottom_offset = get_pivot_second_inner_bottom_offset();

miniture_base_rad = get_miniture_base_rad();

//bottom ruler piece
difference(){
    translate([-movement_ruler_width/2,0,0]){
    difference(){
        cube([ movement_ruler_width, movement_ruler_length+pivot_outer_rad, movement_ruler_height]);
        //Bottom large indent
        translate([1,-.01,-1])cube([movement_ruler_width-ruler_ridge_length, movement_ruler_length+pivot_outer_rad+0.2, movement_ruler_pocket_depth+1]);
        //top shallow indent for pivot piece
        translate([-1,-movement_ruler_length,movement_ruler_height-bottom_ruler_indent])cube([movement_ruler_width+2, movement_ruler_length+pivot_outer_rad+1, bottom_ruler_indent+0.1]);
        translate([movement_ruler_width/2,movement_ruler_length+pivot_outer_rad+2.4+(miniture_base_rad*.7),-1])cylinder(h=movement_ruler_height+2,r=miniture_base_rad);
        }
        
         difference(){
            translate([movement_ruler_width/2,movement_ruler_length+pivot_outer_rad+2.4+(miniture_base_rad*0.7)-2,0])rotate([0,0,-123.5])linear_extrude(movement_ruler_height)circle_slice(rad=miniture_base_rad,ang=67);
            translate([movement_ruler_width/2,movement_ruler_length+pivot_outer_rad+2.4+(miniture_base_rad*0.7),-1.9])rotate([0,0,-123.5])linear_extrude(movement_ruler_height+2)circle_slice(rad=miniture_base_rad,ang=67);
            }
        //translate([-1,0,movement_ruler_height-bottom_ruler_indent+0.1])cube([movement_ruler_width+2, movement_ruler_length+pivot_outer_rad+0.2, bottom_ruler_indent]);
    }
    //larger inner circle which punches through the top
    translate([0,0,-0.1])cylinder(h=movement_ruler_height,r=pivot_inner_rad);
}
difference(){
    cylinder(h=movement_ruler_height,r=pivot_outer_rad);
    //larger inner circle which punches through the top
    translate([0,0,-0.1])cylinder(h=movement_ruler_height,r=pivot_inner_rad);
    //smaller inner circle
    translate([0,0,-0.1])cylinder(h=pivot_second_inner_bottom_offset,r=pivot_second_inner_rad);
    
    //top shallow indent for pivot piece
    translate([0,0,movement_ruler_height-bottom_ruler_indent])cylinder(h=bottom_ruler_indent+0.1,r=pivot_outer_rad+0.1);
}