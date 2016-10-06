module first_nns_seq #(	parameter W = 15)(
	input clk, rst,
	input [2*W-1:0] g_input, e_input,
	output [2*W-1:0] o
);

	function integer log2;
		input [31:0] value;
		reg [31:0] temp;
	begin
		temp = value;
		for (log2=0; temp>0; log2=log2+1)
			temp = temp>>1;
	end
	endfunction

	localparam LOGW = log2(W);

	
	wire [W-1:0] x1, y1, x2, y2;
	
	assign x1 = e_input[2*W-1:W];
	assign y1 = e_input[W-1:0];
	assign x2 = g_input[2*W-1:W];
	assign y2 = g_input[W-1:0];

	wire [W+1:0] dist;

	wire [W-1:0] min_val_x[N-1:0];
	wire [W-1:0] min_val_y[N-1:0];
	wire [W+1:0] min_dist;
	wire gt_dist;

	reg [W-1:0] min_val_x_reg[N-1:0];
	reg [W-1:0] min_val_y_reg[N-1:0];
	reg [W+1:0] min_dist_reg;


	taxicab_distance #(.N(W)) taxicab_distance_ (
		.x1(x1), .y1(y1), .x2(x2), .y2(y2),
		.dist(dist)
	);


	COMP #(.N(W+2)) COMP_(
		.A(min_dist_reg),
		.B(dist),
		.O(gt_dist)
	);

	MUX #(.N(2*W))MUX_1(
		.A({x1, y1}),
		.B({min_val_x_reg, min_val_y_reg}),
		.S(gt_dist),
		.O({min_val_x, min_val_y})
	);
	
	MUX #(.N(W+2))MUX_2(
		.A(dist),
		.B(min_dist_reg),
		.S(gt_dist),
		.O(min_dist)
	);

	assign o = min_val;


	always@(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			min_val_x_reg <=  0;
			min_val_y_reg <=  0;
			min_dist_reg <= {(W+2){1'b1}};		
		end
		else 
		begin
			min_val_x_reg <= min_val_x;
			min_val_y_reg <= min_val_y;
			min_dist_reg <= min_dist;
		end
	end



endmodule
