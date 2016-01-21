// ===================================================================
// TITLE : example Lampy LEDs
//
//   DEGISN : S.OSAFUNE (J-7SYSTEM WORKS LIMITED)
//   DATE   : 2016/01/20 -> 2016/01/20
//   UPDATE : 
//
// ===================================================================
// *******************************************************************
//   Copyright (C) 2016 J-7SYSTEM WORKS LIMITED. All rights Reserved.
//
// * This module is a free sourcecode and there is NO WARRANTY.
// * No restriction on use. You can use, modify and redistribute it
//   for personal, non-profit or commercial products UNDER YOUR
//   RESPONSIBILITY.
// * Redistributions of source code must retain the above copyright
//   notice.
// *******************************************************************

`timescale 1ns / 100ps

module sample_top (
	input			CLOCK_50,
	input			RESET_n,
	output [4:0]	LED
);

	reg [26:0]		clkdiv_count_reg;
	wire			pwmtiming_sig;
	wire [7:0]		pwmwidth_sig;
	wire [7:0]		pwmcompare_sig;
	wire [7:0]		pwmcount_sig;
	wire			pwmupdown_sig;
	reg				pwmout_reg;


	assign pwmupdown_sig = clkdiv_count_reg[26];
	assign pwmwidth_sig = clkdiv_count_reg[25:18];
	assign pwmcount_sig = clkdiv_count_reg[7:0];
	assign pwmcompare_sig = (pwmupdown_sig)? ~pwmwidth_sig : pwmwidth_sig;

	always @(posedge CLOCK_50 or negedge RESET_n)
	begin
		if (!RESET_n) begin
			clkdiv_count_reg <= 1'd0;
			pwmout_reg <= 1'b0;
		end
		else begin
			clkdiv_count_reg <= clkdiv_count_reg + 1'd1;

			if (pwmcount_sig == pwmcompare_sig) begin
				pwmout_reg <= 1'b1;
			end
			else if (pwmcount_sig == 0) begin
				pwmout_reg <= 1'b0;
			end
		end
	end

	assign LED = {pwmout_reg, ~pwmout_reg, pwmout_reg, ~pwmout_reg, pwmout_reg};


	dual_image_boot u0(
		.clk_clk       (CLOCK_50),
		.reset_reset_n (RESET_n)
	);

endmodule
