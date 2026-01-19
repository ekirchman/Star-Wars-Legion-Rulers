use <Movement_Ruler_lib.scad>;
movement_ruler_width = get_movement_ruler_width();
movement_ruler_length = get_movement_1_top_ruler_length(); //should be 32

movement_ruler_height = get_movement_ruler_height();
movement_ruler_pocket_depth = get_movement_ruler_pocket_depth();

pivot_outer_rad = get_pivot_outer_rad();
pivot_inner_rad = get_pivot_inner_rad();
pivot_second_inner_rad = get_pivot_second_inner_rad();

ruler_ridge_length = get_ruler_ridge_length();

bottom_ruler_indent = get_bottom_ruler_indent();

pivot_second_inner_bottom_offset = get_pivot_second_inner_bottom_offset();

miniture_base_rad = get_miniture_base_rad();

bottom_jut_length = pivot_outer_rad*2;
bottom_jut_length_straight = bottom_jut_length-7;

bottom_inner_most_rad = 9/2;

clip_cube_depth=2;
clip_cube_width=2;
clip_cube_height=movement_ruler_pocket_depth;

module pie_slice(){
    radius = 16;
    angle = 60;   // degrees

    polygon(points = concat(
        [[0,0]],
        [ for (a = [0:1:angle])
            [ radius * cos(a), radius * sin(a) ]
        ]
    ));
}



module create_clip(){  
    
    translate([0,0,0.5])
    union(){
        translate([0,0,0.5])cube([clip_cube_width, clip_cube_depth, movement_ruler_pocket_depth]);
        translate([clip_cube_width,0,0.5])rotate([-90,0,90])linear_extrude(clip_cube_width)polygon(points=[
        [0, 0],      // right angle corner
        [clip_cube_depth+1, 0],     // base
        [0, 1]      // height
        ]);
    }
}

//top ruler piece
translate([0,bottom_jut_length/2,bottom_ruler_indent+0.1]){
difference(){
    translate([-movement_ruler_width/2,-2,0]){
        difference(){
            cube([ movement_ruler_width, movement_ruler_length, movement_ruler_height]);
            //Bottom large indent
            translate([1,-.01,-1])cube([movement_ruler_width-ruler_ridge_length, movement_ruler_length+0.2, movement_ruler_pocket_depth+1]);
            //cut circle for miniature base
            translate([movement_ruler_width/2,movement_ruler_length+(miniture_base_rad*.7),-1])cylinder(h=movement_ruler_height+2,r=miniture_base_rad);        
            }
            //round edge for miniature base
            
            //translate([movement_ruler_width/2,movement_ruler_length+(miniture_base_rad*0.7)-2,-1])cylinder(h=movement_ruler_height+2,r=miniture_base_rad); //translate([movement_ruler_width/2,movement_ruler_length+(miniture_base_rad*0.7)-2,-2])cylinder(h=movement_ruler_height+4,r=miniture_base_rad*0.85);
            difference(){
                translate([movement_ruler_width/2,movement_ruler_length+(miniture_base_rad*0.7)-2,0])rotate([0,0,-123.5])linear_extrude(movement_ruler_height)circle_slice(rad=miniture_base_rad,ang=67);
                translate([movement_ruler_width/2,movement_ruler_length+(miniture_base_rad*0.7),-1.9])rotate([0,0,-123.5])linear_extrude(movement_ruler_height+2)circle_slice(rad=miniture_base_rad,ang=67);
            }
            
            
         //top shallow indent for pivot piece
            translate([0,-(bottom_jut_length_straight-0.1),movement_ruler_height-(movement_ruler_height-movement_ruler_pocket_depth)])cube([movement_ruler_width, bottom_jut_length_straight, movement_ruler_height-movement_ruler_pocket_depth]);   
        }  
    }
    pivot_cutout_outside = pivot_outer_rad+2.5;
    pivot_cutout_inside = pivot_cutout_outside-2;
    difference(){
        //translate([0,-pivot_outer_rad+0.5,0])cylinder(h=movement_ruler_height,r=pivot_cutout_outside);
       translate([0,-pivot_cutout_outside+1,0])rotate([0,0,50])linear_extrude(movement_ruler_height)circle_slice(rad=pivot_cutout_outside+0.5, ang=80); //translate([0,-pivot_outer_rad+0.5,-2.01])cylinder(h=movement_ruler_height+1,r=pivot_cutout_inside);
      translate([0,-pivot_cutout_outside-1,-2])rotate([0,0,50])linear_extrude(movement_ruler_height+2)circle_slice(rad=pivot_cutout_outside+1.05, ang=80);
        
        //Cut the pivot circle. Yes, this is a mess
        //translate([-pivot_cutout_outside,-pivot_cutout_outside-pivot_outer_rad-(pivot_outer_rad/3-0.3),-0.9])cube([pivot_cutout_outside*2, pivot_cutout_outside*2, movement_ruler_height+1]);
    }
   
   //translate([0,-pivot_outer_rad+0.5,-2.1])cylinder(h=movement_ruler_height+1,r=pivot_cutout_inside); //translate([-pivot_cutout_outside,-pivot_cutout_outside-pivot_outer_rad-(pivot_outer_rad/3-0.2),-2])cube([pivot_cutout_outside*2, pivot_cutout_outside*2, movement_ruler_height+1]);
    
    translate([0,-pivot_outer_rad+0.5,movement_ruler_height-1])cylinder(h=1,r=pivot_outer_rad);
}


difference(){
    
    translate([0,0,-0.1])cylinder(h=movement_ruler_height,r=pivot_inner_rad);
    
    translate([0,0,-movement_ruler_pocket_depth])cylinder(h=movement_ruler_height,r=pivot_inner_rad+0.1);
    
    translate([0,0,-0.2])cylinder(h=movement_ruler_height,r=bottom_inner_most_rad);
    
    translate([0,0,-1])linear_extrude(movement_ruler_height+1)pie_slice();
    rotate(120)translate([0,0,-1])linear_extrude(movement_ruler_height+1)pie_slice();
    rotate(240)translate([0,0,-1])linear_extrude(movement_ruler_height+1)pie_slice();
    
}
rotate([0,0,-60])translate([-clip_cube_width/2,bottom_inner_most_rad-clip_cube_depth+1,0])create_clip();
rotate([0,0,-180])translate([-clip_cube_width/2,bottom_inner_most_rad-clip_cube_depth+1-0.2,0])create_clip();
rotate([0,0,60])translate([-clip_cube_width/2,bottom_inner_most_rad-clip_cube_depth+1-0.2,0])create_clip();


//translate([0,movement_ruler_length+(miniture_base_rad*1.3),0])cylinder(h=movement_ruler_height,r=miniture_base_rad);