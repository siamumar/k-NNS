module taxicab_distance #(parameter N = 32)(
	input [N-1:0] x1, y1, x2, y2,
	output [N+1:0] dist
);

wire signed [N:0] dist_x12, dist_x21, dist_xabs, dist_y12, dist_y21, dist_yabs;

SUB_ #(.N(N)) diff_x12 (.A(x1), .B(x2), .O(dist_x12));
SUB_ #(.N(N)) diff_x21 (.A(x2), .B(x1), .O(dist_x21));
MUX #(.N(N+1)) abs_x (.A(dist_x12), .B(dist_x21), .S(dist_x12[N]), .O(dist_xabs));
SUB_ #(.N(N)) diff_y12 (.A(y1), .B(y2), .O(dist_y12));
SUB_ #(.N(N)) diff_y21 (.A(y2), .B(y1), .O(dist_y21));
MUX #(.N(N+1)) abs_y (.A(dist_y12), .B(dist_y21), .S(dist_y12[N]), .O(dist_yabs));
ADD_ #(.N(N+1))t_d (.A(dist_xabs), .B(dist_yabs), .O(dist));

endmodule 
