`define TimeExpire 32'd2500
`define Time 32'd25000000

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

module clk_sec(clk,rst,div_sec);
input clk,rst;
output reg div_sec;

reg [31:0]count;

always @(posedge clk or negedge rst)
    begin 
        if(!rst)
        begin 
            count <= 32'd0;
            div_sec <= 1'b0;
        end
        else
        begin 
            if(count == `Time)
            begin 
                count <= 32'd0;
                div_sec <= ~div_sec;
            end
            else
            begin
                count <= count + 32'd1;
            end
        end
    end
endmodule

module dot_control (clk_div,rst,outs,row,col);
    input clk_div,rst;
    input [1:0]outs;
    output reg [7:0] row,col;
    reg [2:0] state;
    state=0;
    always @(posedge clk_div or negedge rst or outs) begin
        if(!rst)
        begin
            case (state)
                3'd0:begin row <= 8'b11111110; col <= 8'b00001100; end
                3'd1:begin row <= 8'b11111101; col <= 8'b00001100; end
                3'd2:begin row <= 8'b11111011; col <= 8'b00011001; end
                3'd3:begin row <= 8'b11110111; col <= 8'b01111110; end
                3'd4:begin row <= 8'b11101111; col <= 8'b10011000; end
                3'd5:begin row <= 8'b11011111; col <= 8'b00011000; end
                3'd6:begin row <= 8'b10111111; col <= 8'b00101000; end
                3'd7:begin row <= 8'b01111111; col <= 8'b01001000; end
            endcase
            state <= state + 1'b1;
        end
        else
        begin
          case(outs)
            2'b00:begin
             case (state)
                3'd0:begin row <= 8'b11111110; col <= 8'b00001100; end
                3'd1:begin row <= 8'b11111101; col <= 8'b00001100; end
                3'd2:begin row <= 8'b11111011; col <= 8'b00011001; end
                3'd3:begin row <= 8'b11110111; col <= 8'b01111110; end
                3'd4:begin row <= 8'b11101111; col <= 8'b10011000; end
                3'd5:begin row <= 8'b11011111; col <= 8'b00011000; end
                3'd6:begin row <= 8'b10111111; col <= 8'b00101000; end
                3'd7:begin row <= 8'b01111111; col <= 8'b01001000; end
            endcase
                state <= state + 1'b1;
            end
            2'b01:begin
             case (state)
                3'd0:begin row <= 8'b11111110; col <= 8'b00000000; end
                3'd1:begin row <= 8'b11111101; col <= 8'b00100100; end
                3'd2:begin row <= 8'b11111011; col <= 8'b00111100; end
                3'd3:begin row <= 8'b11110111; col <= 8'b10111101; end
                3'd4:begin row <= 8'b11101111; col <= 8'b11111111; end
                3'd5:begin row <= 8'b11011111; col <= 8'b00111100; end
                3'd6:begin row <= 8'b10111111; col <= 8'b00111100; end
                3'd7:begin row <= 8'b01111111; col <= 8'b00000000; end
            endcase
                state <= state + 1'b1;
            end

            2'b10:begin
             case (state)
                3'd0:begin row <= 8'b11111110; col <= 8'b00011000; end
                3'd1:begin row <= 8'b11111101; col <= 8'b00011000; end
                3'd2:begin row <= 8'b11111011; col <= 8'b00111100; end
                3'd3:begin row <= 8'b11110111; col <= 8'b00111100; end
                3'd4:begin row <= 8'b11101111; col <= 8'b01011010; end
                3'd5:begin row <= 8'b11011111; col <= 8'b00011000; end
                3'd6:begin row <= 8'b10111111; col <= 8'b00011000; end
                3'd7:begin row <= 8'b01111111; col <= 8'b00100100; end
            endcase
                state <= state + 1'b1;
            end
            
          endcase
        end
    end
endmodule

module count(clk_sec,rst,outstate,out_sec);
    input clk_sec,rst;
    output reg [1:0]outstate;
    output reg [3:0]out_sec;
    always@(posedge clk_sec or negedge rst) begin
        if(!rst) begin
            outstate<=2'b00;
            out_sec<=4'd15;
        end
        else begin
            case(outstate)
                2'b00:   
                    if(out_sec==4'd0) begin
                        outstate<=2'01;
                        out_sec<=4'd5;
                    end
                    else begin
                        out_sec<=out_sec-4'd1;
                    end     
                2'b01:
                    if(out_sec==4'd0) begin
                        outstate<=2'10;
                        out_sec<=4'd10;
                    end
                    else begin
                        out_sec<=out_sec-4'd1;
                    end            
                2'b10:
                    if(out_sec==4'd0) begin
                        outstate<=2'00;
                        out_sec<=4'd15;
                    end
                    else begin
                        out_sec<=out_sec-4'd1;
                    end            
            endcase 
        end
    end
endmodule

module sevendisplay(in,out);
    input [3:0]in;
    output reg [6:0]out;
    always@(in)
    begin
    case(in)
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

module test (rst,clk,row,col);
input rst ,clk;
output [7:0] row,col;
output [6:0] out;
wire clk_div;
wire clk_sec;
wire [3:0]out_sec;
wire [1:0]outstate;
clk_div u_clk_div (.clk(clk),.rst(rst),.div_clk(clk_div));
clk_sec u_clk_sec (.clk(clk),.rst(rst),.div_sec(clk_sec);
count u_count(.clk_sec(clk_sec),.rst(rst),.outstate(outstate),.out_sec(out_sec);
dot_control u_dot_control (.clk_div(clk_div),.rst(rst),.outs(outstate),.row(row),.col(col));
sevendisplay u_sevendisplay(.in(out_sec),.out(out));

    
endmodule