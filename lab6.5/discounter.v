`define TimeExpire 32'd25000000

module clk_div(clk,rst,div_clk);
	input clk,rst;
	output reg div_clk;
	reg [31:0]cnt;
	
	always@(posedge clk or negedge rst)
	begin 
		if(!rst)
		begin 
			cnt <= 32'd0;
			div_clk <= 1'b0;
		end
		else
		begin
			if(cnt == `TimeExpire)
			begin
				cnt <= 32'd0;
				div_clk <= ~div_clk;
			end
			else
			begin 
				cnt <= cnt + 32'd1;
			end
		end
	end
endmodule

module counter(div_clk,rst,set,cnt);
	input div_clk,rst,set;
	output reg [3:0]cnt;
	
	always@(posedge div_clk,negedge rst)
	begin
		if(!rst)
		begin
			cnt <= 4'd0;
		end
		else
		begin
			if(set == 1'b1)
			begin
				cnt <= cnt + 4'd1;
			end
			else
			begin 
				cnt <= cnt - 4'd1;
			end
		end
	end
endmodule

module seven_display (cnt,out);
input [3:0]cnt;
output reg [6:0]out;
always @(cnt) 
begin
    case(cnt)
        4'd0:
        out=7'b1000000;
        4'd1:
        out=7'b1111001;
        4'd2:
        out=7'b0100100;
        4'd3:
        out=7'b0110000;
        4'd4:
        out=7'b0011001;
        4'd5:
        out=7'b0010010;
        4'd6:
        out=7'b0000010;
        4'd7:
        out=7'b1111000;
        4'd8:
        out=7'b0000000;
        4'd9:
        out=7'b0010000;
        4'd10:
        out=7'b0001000;
        4'd11:
        out=7'b0000011;
        4'd12:
        out=7'b1000110;
        4'd13:
        out=7'b0100001;
        4'd14:
        out=7'b0000110;
        4'd15:
        out=7'b0111000;
    endcase
end
endmodule

module test(rst,clk,set,out);
	input rst, clk,set;
	output [6:0]out;
	wire div_clk;
	wire[3:0]cnt;

	clk_div u_clk_div(.clk(clk),.rst(rst),.div_clk(div_clk));
	counter u_counter(.div_clk(div_clk),.rst(rst),.set(set),.cnt(cnt));
	seven_display (.cnt(cnt),.out(out));
endmodule