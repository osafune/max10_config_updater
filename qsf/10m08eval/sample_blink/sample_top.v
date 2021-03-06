// ===================================================================
// TITLE : example Blink LEDs
//
//   DEGISN : S.OSAFUNE (J-7SYSTEM WORKS LIMITED)
//   DATE   : 2016/01/21 -> 2016/01/21
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

	reg [25:0]		clkdiv_count_reg;
	wire			ledout_sig;


	always @(posedge CLOCK_50 or negedge RESET_n)
	begin
		if (!RESET_n) begin
			clkdiv_count_reg <= 1'd0;
		end
		else begin
			clkdiv_count_reg <= clkdiv_count_reg + 1'd1;
		end
	end

	assign ledout_sig = clkdiv_count_reg[25];
	assign LED = {ledout_sig, ~ledout_sig, ledout_sig, ~ledout_sig, ledout_sig};


	dual_image_boot u0(
		.clk_clk       (CLOCK_50),
		.reset_reset_n (RESET_n)
	);

endmodule
