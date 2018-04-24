`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module vga(ClkPort, LETTER, BtnC, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	);
	input ClkPort;
	input [4:0] LETTER;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, ClkPort, board_clk, clk, button_clk;
	
	BUF BUF1 (board_clk, ClkPort); 	
	BUF BUF2 (reset, BtnC);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];
	assign	clk = DIV_CLK[1];
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	reg [9:0] position;
	

	wire R = (CounterX>=370 && CounterX<=430 && CounterY>=170 && CounterY<=200) || 
	(CounterX>=340 && CounterX<=370 && CounterY>=200 && CounterY<=350) ||
	(CounterX>=430 && CounterX<=460 && CounterY>=200 && CounterY<=350) ||
	(CounterX>=370 && CounterX<=430 && CounterY>=260 && CounterY<=290);
	wire G = R;
	wire B = R;
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
endmodule
