module	morse_code_top
       (ClkPort,                                    // System Clock
        MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS,
        BtnL, BtnU, BtnR, BtnD, BtnC,	             // the Left, Up, Right, Down, and Center buttons
        Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7,     // 8 Switches
        Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7,     // 8 LEDs
		  An0, An1, An2, An3,                         // 4 seven-LEDs
		  Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
		  vga_r, vga_g, vga_b, vga_h_sync, vga_v_sync
		  );
                                    
	input    ClkPort;
	input    BtnL, BtnU, BtnD, BtnR, BtnC;
	input    Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7;
	output   Ld0, Ld1, Ld2, Ld3, Ld4,Ld5, Ld6, Ld7;
	output   An0, An1, An2, An3;
	output   Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	  
	// ROM drivers: Control signals on Memory chips (to disable them) 	
	output 	MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS;  

	// local signal declaration
	wire Reset;
	wire board_clk;
	wire Clk;
	wire Done;
	wire PbInput;
	wire PbEnd;
	wire Short;
	wire Long;
	wire Strobe;

	wire [4:0] Letter;
	reg [4:0] VgaLetter;

	always @(posedge Strobe)
	begin
		VgaLetter <= Letter;
	end

	assign Reset = BtnC;	

	// Disable the three memories so that they do not interfere with the rest of the design.
	assign {MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS} = 5'b11111;

	assign PbInput   =  BtnR;
	assign PbEnd = BtnL;
	assign Clk   =  board_clk; 

	button_decoder buttondecoder(.CLK(Clk), .RESET(Reset), PB(PbInput), .SHORT(Short), .LONG(Long));

	alphabet letterdecoder(.RESET(Reset), .Clk(Clk), .LONG(Long), .SHORT(Short), .END_CHAR(PbEnd), .LETTER(Letter), .STROBE(Strobe));

	vga vgamodule(.ClkPort(Clk), .LETTER(VgaLetter), .BtnC(BtnC), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b),
	.St_ce_bar(), .St_rp_bar(), .Mt_ce_bar(), .Mt_St_oe_bar(), .Mt_St_we_bar());


	// // Turn 4 seven-LEDs on all the time
	// assign {An0, An1, An2, An3} = 4'b0000;

endmodule