`timescale 1ns / 100ps

module button_decoder(CLK, RESET, PB, DPB, SHORT, LONG);

input CLK, RESET, PB;
output DPB, SHORT, LONG;

reg [5:0] state;
reg [27:0] counter;
reg [0:0] short_reg;
reg [0:0] long_reg;

assign SHORT = short_reg;
assign LONG = long_reg;

localparam
	INI	= 6'b000001,
	WAIT = 6'b000010,
	BP = 6'b000100,
	SHORT = 6'b001000,
	LONGWAIT = 6'b010000,
	LONG = 6'b100000;

always @(posedge CLK, posedge RESET)
	begin
		if(RESET)
			begin
				state <= INI;
				short_reg <= 1'b0;
				long_reg <= 1'b0; 
				counter <= 28'b0000000000000000000000000000;
			end
		else 
			case (state)
				INI: begin
					//RTL
					short_reg <= 1'b0;
					long_reg <= 1'b0;
					counter <= 28'b0000000000000000000000000000;

					//NSL
					if(PB)
						begin
							state <= WAIT;
						end
				end

				WAIT: begin
					//RTL
					counter <= counter + 1;

					//NSL
					if(!PB)
						begin
							state <= INI;
						end
					else if (counter[23]) 
						begin
							state <= BP;
						end
				end

				BP: begin
					//RTL
					counter <= counter + 1;

					//NSL
					if(PB)
						begin
							if(counter[25])
								begin
									state <= LONGWAIT;
								end
						end
					else //if !PB
						begin
							if(counter[24])
								begin
									state <= LONG;
								end
							else if
								begin
									state <= SHORT;
								end
						end
				end

				SHORT: begin
					//RTL
					short_reg <= 1'b1;

					//NSL
					state <= INI;
					
				end

				LONGWAIT: begin
					//NSL
					if(!PB)
					 	begin
					 		state <= LONG;
					 	end
				end

				LONG: begin
					//RTL
					long_reg <= 1'b1;

					//NSL
					state <= INI;
				end
	end

