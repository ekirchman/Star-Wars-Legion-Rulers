function get_movement_ruler_width() = 15;
function get_movement_1_bottom_ruler_length() = 30;
function get_movement_1_top_ruler_length() = 32;

function get_movement_ruler_height() = 4.5;
function get_movement_ruler_pocket_depth() = 3.5;

function get_pivot_outer_rad() = 8.5;
function get_pivot_inner_rad() = 11/2;
function get_pivot_second_inner_rad() = 13/2;

function get_ruler_ridge_length() = 2;

function get_bottom_ruler_indent() = 0.5;

function get_pivot_second_inner_bottom_offset() = 1.5;

function get_miniture_base_rad() = 27/2;

module circle_slice(rad = get_miniture_base_rad(), ang = 60){
    radius = rad;
    angle = ang;   // degrees

    polygon(points = concat(
        [[0,0]],
        [ for (a = [0:1:angle])
            [ radius * cos(a), radius * sin(a) ]
        ]
    ));
}