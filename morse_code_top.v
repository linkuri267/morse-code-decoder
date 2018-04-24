module	morse_code_top
       (ClkPort,                                    // System Clock
        MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS,
        BtnL, BtnU, BtnR, BtnD, BtnC,	             // the Left, Up, Right, Down, and Center buttons
        Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7,     // 8 Switches
		  vga_r, vga_g, vga_b, vga_h_sync, vga_v_sync
		  );
                                    
	input    ClkPort;
	input    BtnL, BtnU, BtnD, BtnR, BtnC;
	input    Sw0, Sw1, Sw2, Sw3, Sw4, Sw5, Sw6, Sw7;
	input 	vga_r, vga_g, vga_b, vga_h_sync, vga_v_sync;

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
	wire vga_r_l;
	wire vga_g_l;
	wire vga_b_l;
	wire vga_h_sync_l;
	wire vga_v_sync_l;
	
	assign vga_r_l = vga_r;
	assign vga_g_l = vga_g;
	assign vga_b_l = vga_b;
	assign vga_h_sync_l = vga_h_sync;
	assign vga_v_sync_l = vga_v_sync;

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

	button_sm buttonsm(.CLK(Clk), .RESET(Reset), .PB(PbInput), .SHORT(Short), .LONG(Long));

	alphabet letterdecoder(.RESET(Reset), .Clk(Clk), .LONG(Long), .SHORT(Short), .END_CHAR(PbEnd), .LETTER(Letter), .STROBE(Strobe));

	vga vgamodule(.ClkPort(Clk), .LETTER(VgaLetter), .BtnC(BtnC), .vga_h_sync(vga_h_sync_l), .vga_v_sync(vga_v_sync_l), .vga_r(vga_r_l), .vga_g(vga_g_l), .vga_b(vga_b_l),
	.St_ce_bar(), .St_rp_bar(), .Mt_ce_bar(), .Mt_St_oe_bar(), .Mt_St_we_bar());


	// // Turn 4 seven-LEDs on all the time
	// assign {An0, An1, An2, An3} = 4'b0000;

endmodule