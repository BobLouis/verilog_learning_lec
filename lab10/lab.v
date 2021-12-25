`define TimeExpire 2500

module clk_div(clk,rst,div_clk);
input clk,rst;
output div_clk;

reg div_clk;
reg [31:0]count;

always @(posedge clk or negedge rst)
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


module keypad (clk, rst, keyRow, keyCol, keyBuf);
    input clk, rst;
    input [3:0]keyCol;
    output reg [3:0]keyRow;
    output reg [3:0] keyBuf;
    reg [31:0] keyDelay;
    always @(posedge clk or negedge rst)begin
        if(!rst)
        begin
            keyDelay <= 31'd0;
            keyBuf <= 4'b0;
            keyRow <= 4'b1110; 
        end
        else
        begin
            case({keyRow, keyCol})
                8'b1110_1110 : keyBuf <= 4'h7;
                8'b1110_1101 : keyBuf <= 4'h4;
                8'b1110_1011 : keyBuf <= 4'h1;
                8'b1110_0111 : keyBuf <= 4'h0;

                8'b1101_1110 : keyBuf <= 4'h8;
                8'b1101_1101 : keyBuf <= 4'h5;
                8'b1101_1011 : keyBuf <= 4'h2;
                8'b1101_0111 : keyBuf <= 4'ha;

                8'b1011_1110 : keyBuf <= 4'h9;
                8'b1011_1101 : keyBuf <= 4'h6;
                8'b1011_1011 : keyBuf <= 4'h3;
                8'b1011_0111 : keyBuf <= 4'hb;

                8'b0111_1110 : keyBuf <= 4'hc;
                8'b0111_1101 : keyBuf <= 4'hd;
                8'b0111_1011 : keyBuf <= 4'he;
                8'b0111_0111 : keyBuf <= 4'hf;
            endcase
            case(keyRow)
                4'b1110 : keyRow <= 4'b1101;
                4'b1101 : keyRow <= 4'b1011;
                4'b1011 : keyRow <= 4'b0111;
                4'b0111 : keyRow <= 4'b1110;
                default : keyRow <= 4'b1110;
            endcase
        end
    end
endmodule


module dot_control (clk_div,rst,keyBuf,row,col);
    input clk_div,rst;
    input [3:0]keyBuf;
    output reg [7:0] row,col;
    reg [2:0] state;
    always @(posedge clk_div or negedge rst) begin
        if(rst == 0)
        begin
            row <= 8'd0;
            col <= 8'd0;
        end
        else
        begin
            case(keyBuf)
                4'd0:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b11000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b11000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd1:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00110000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00110000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd4:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00001100; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00001100; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd7:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000011; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000011; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd10:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b11000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b11000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd2:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00110000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00110000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd5:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00001100; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00001100; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd8:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000011; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000011; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd11:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b11000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b11000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd3:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00110000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00110000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd6:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00001100; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00001100; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd9:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000011; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000011; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd15:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b11000000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b11000000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd14:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00110000; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00110000; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd13:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00001100; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00001100; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
                4'd12:
                begin
                    case (state)
                        3'd0:begin row <= 8'b01111111; col <= 8'b00000011; end
                        3'd1:begin row <= 8'b10111111; col <= 8'b00000011; end
                        3'd2:begin row <= 8'b11011111; col <= 8'b00000000; end
                        3'd3:begin row <= 8'b11101111; col <= 8'b00000000; end
                        3'd4:begin row <= 8'b11110111; col <= 8'b00000000; end
                        3'd5:begin row <= 8'b11111011; col <= 8'b00000000; end
                        3'd6:begin row <= 8'b11111101; col <= 8'b00000000; end
                        3'd7:begin row <= 8'b11111110; col <= 8'b00000000; end
                    endcase
                    state <= state + 1'b1;
                end
            endcase
        end
    end
endmodule

module test (clk, rst, keyRow,keyCol, outRow, outCol);
input clk,rst;
input [3:0] keyCol;
output [3:0] keyRow;
output [7:0] outRow;
output [7:0] outCol;
wire clk_div;
wire [3:0] keyBuf;
clk_div u_clk_div(.clk(clk),.rst(rst),.div_clk(clk_div));
keypad u_keypad (.clk(clk_div), .rst(rst), .keyRow(keyRow), .keyCol(keyCol), .keyBuf(keyBuf));
dot_control u_dot_control (.clk_div(clk_div),.rst(rst),.keyBuf(keyBuf),.row(outRow),.col(outCol));
endmodule