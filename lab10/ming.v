`define TimeExpire 32'd100


module clk_div(clk,rst,div_clk);
input clk,rst;
output reg div_clk;

reg [31:0]count;

always@(posedge clk or negedge rst)
    begin 
        if(!rst)
        begin 
            count <= 32'd0;
            div_clk <= 1'b0;
        end
        else
        begin 
            if(count == `TimeExpire)
            begin 
                count <= 32'd0;
                div_clk <= ~div_clk;
            end
            else
            begin
                count <= count + 32'd1;
            end
        end
    end

endmodule

module keypad(clk,rst,keypadrow,keypadcol,keypadbuf);
input clk,rst;
input [3:0]keypadcol;
output reg[3:0]keypadrow;
output reg[3:0]keypadbuf;


always@(posedge clk)
begin
	if(!rst)
	begin
		keypadrow<=4'b1110;
		keypadbuf<=4'b0000;
	
	end
	else
	begin
			case({keypadrow,keypadcol})
                8'b1110_1110:keypadbuf<=4'h7;
                8'b1110_1101:keypadbuf<=4'h4;
                8'b1110_1011:keypadbuf<=4'h1;
                8'b1110_0111:keypadbuf<=4'h0;
                8'b1101_1110:keypadbuf<=4'h8;
                8'b1101_1101:keypadbuf<=4'h5;
                8'b1101_1011:keypadbuf<=4'h2;
                8'b1101_0111:keypadbuf<=4'ha;
                8'b1011_1110:keypadbuf<=4'h9;
                8'1011_1101:keypadbuf<=4'h6;
                8'1011_1011:keypadbuf<=4'h3;
                8'1011_0111:keypadbuf<=4'hb;
                8'0111_1110:keypadbuf<=4'hc;
                8'0111_1101:keypadbuf<=4'hd;
                8'0111_1011:keypadbuf<=4'he;
                8'0111_0111:keypadbuf<=4'hf;
			    default:keypadbuf<=keypadbuf;
			endcase
			case(keypadrow)
				4'b1110:keypadrow<=4'b1101;
				4'b1101:keypadrow<=4'b1011;
				4'b1011:keypadrow<=4'b0111;
				4'b0111:keypadrow<=4'b1110;
			default:keypadrow=4'b1110;
			endcase
		end
end
endmodule	
module dot_control (clk_div,rst,keypadbuf,dot_row,dot_col);
    input clk_div,rst;
	input [3:0]keypadbuf
    output reg [7:0] dot_row,dot_col;
	 
	 always@(posedge clk_div or negedge rst)begin
	 if(!rst)begin
		dot_row<=8'b1;
		dot_col<=8'b0;
	 end
	 else begin
		case(keypadBuf)
			4'h7:dot_row<=8'b11111100,dot_col<=8'b00000011;
			4'h4:dot_row<=8'b11110011,dot_col<=8'b00001100;
			4'h1:dot_row<=8'b11001111,dot_col<=8'b00110000;
			4'h0:dot_row<=8'b00111111,dot_col<=8'b11000000;
			4'h8:dot_row<=8'b11111100,dot_col<=8'b00000011;
			4'h5:dot_row<=8'b11110011,dot_col<=8'b00001100;
			4'h2:dot_row<=8'b11001111,dot_col<=8'b00110000;
			4'ha:dot_row<=8'b00111111,dot_col<=8'b11000000;
			4'h9:dot_row<=8'b11111100,dot_col<=8'b00000011;
			4'h6:dot_row<=8'b11110011,dot_col<=8'b00001100;
			4'h3:dot_row<=8'b11001111,dot_col<=8'b00110000;
			4'hb:dot_row<=8'b00111111,dot_col<=8'b11000000;
			4'hc:dot_row<=8'b11111100,dot_col<=8'b00000011;
			4'hd:dot_row<=8'b11110011,dot_col<=8'b00001100;
			4'he:dot_row<=8'b11001111,dot_col<=8'b00110000;
			4'hf:dot_row<=8'b00111111,dot_col<=8'b11000000;
		
		endcase
		
	 
	 end


end
endmodule


module test(rst,clk,dot_row,dot_col);
input rst,clk;
output [7:0]dot_row,dot_col;
wire clock_div;
wire [7:0]keypadbuf;

clk_div clkd(.clk(clk),.rst(rst),.div_clk(clock_div);
keypad keyp(.clk(clk_div),.rst(rst),.keypadrow(keypadrow),.keypadcol(keypadcol),.keypadbuf(keypadbuf));
dot_control(.clk_div(clk_div),.rst(rst),.keypadbuf(keypadbuf),.dot_row(dot_row),.dot_col(dot_col));

endmodule