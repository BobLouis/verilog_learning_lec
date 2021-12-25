`define TimeExpire_dot 32'd2500
`define TimeExpire_key 32'd6250000

module clk_div_dot(clk,rst,div_clk);
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
            if(count == `TimeExpire_dot)
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

module clk_div_key(clk,rst,div_clk);
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
            if(count == `TimeExpire_key)
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

module dot_control (clk,pos,row,col);
    input clk;
    input [3:0] pos;
    output reg [7:0] row;
    output reg [15:0] col;
    reg [2:0] state;
    always @(posedge clk) begin
        case(pos)
            4'd0:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000000011100; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000000000010110; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000000000011110; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000000111000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0000000010111110; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000000011111000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000000001111000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000000101000; end
                endcase
                state <= state + 1'b1;
            end
            4'd1:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000000001110; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000000000001011; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000000000001111; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000000011100; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0000000001011111; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000000001111100; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000000000111100; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000000010100; end
                endcase
                state <= state + 1'b1;
            end
            4'd2:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000000000111; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b1000000000000101; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b1000000000000111; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000000001110; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b1000000000101111; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000000000111110; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000000000011110; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000000001010; end
                endcase
                state <= state + 1'b1;
            end
            4'd3:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b1000000000000011; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b1100000000000010; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b1100000000000011; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000000000111; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b1100000000010111; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000000000011111; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000000000001111; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000000000101; end
                endcase
                state <= state + 1'b1;
            end
            4'd4:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b1100000000000001; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0110000000000001; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b1110000000000001; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b1000000000000011; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b1110000000001011; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b1000000000001111; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b1000000000000111; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b1000000000000010; end
                endcase
                state <= state + 1'b1;
            end
            4'd5:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b1110000000000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b1011000000000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b1111000000000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b1100000000000001; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b1111000000000101; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b1100000000000111; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b1100000000000011; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0100000000000001; end
                endcase
                state <= state + 1'b1;
            end
            4'd6:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0111000000000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0101100000000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0111100000000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b1110000000000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b1111100000000010; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b1110000000000011; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b1110000000000001; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b1010000000000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd7:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0011100000000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0010110000000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0011110000000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0111000000000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0111110000000001; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b1111000000000001; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b1111000000000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0101000000000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd8:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0001110000000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0001011000000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0001111000000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0011100000000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b1011111000000000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b1111100000000000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0111100000000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0010100000000000; end
                endcase
                state <= state + 1'b1;
            end
        
            4'd9:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000111000000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000101100000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000111100000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0001110000000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0101111100000000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0111110000000000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0011110000000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0001010000000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd10:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000011100000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000010110000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000011110000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000111000000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0010111110000000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0011111000000000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0001111000000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000101000000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd11:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000001110000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000001011000000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000001111000000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000011100000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0001011111000000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0001111100000000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000111100000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000010100000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd12:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000111000000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000000101100000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000000111100000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000001110000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0000101111100000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000111110000000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000011110000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000001010000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd13:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000011100000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000000010110000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000000011110000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000111000000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0000010111110000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000011111000000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000001111000000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000101000000; end
                endcase
                state <= state + 1'b1;
            end
            4'd14:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000001110000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000000001011000; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000000001111000; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000011100000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0000001011111000; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000001111100000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000000111100000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000010100000; end
                endcase
                state <= state + 1'b1;
            end
            4'd15:
            begin
                case (state)
                    3'd0:begin row <= 8'b01111111; col <= 16'b0000000000111000; end
                    3'd1:begin row <= 8'b10111111; col <= 16'b0000000000101100; end
                    3'd2:begin row <= 8'b11011111; col <= 16'b0000000000111100; end
                    3'd3:begin row <= 8'b11101111; col <= 16'b0000000001110000; end
                    3'd4:begin row <= 8'b11110111; col <= 16'b0000000101111100; end
                    3'd5:begin row <= 8'b11111011; col <= 16'b0000000111110000; end
                    3'd6:begin row <= 8'b11111101; col <= 16'b0000000011110000; end
                    3'd7:begin row <= 8'b11111110; col <= 16'b0000000001010000; end
                endcase
                state <= state + 1'b1;
            end

        endcase
    end
endmodule

module key_control (clk,rst,r_sig,l_sig,pos);
    input clk,rst,r_sig,l_sig;
    output reg [3:0]pos;
    always @(posedge clk or negedge rst) begin
        if(!rst)
        begin
            pos <= 4'b0;
        end
        else
        begin
            case({r_sig,l_sig})
                2'b01:
                begin
                    pos <= pos - 2'b01;
                end
                2'b10:
                begin
                    pos <= pos + 2'b01;
                end
            endcase
        end
    end
endmodule

module test (clk,rst,l_sig,r_sig,row,col);
    input clk,rst,l_sig,r_sig;
    output [7:0]row;
    output [15:0]col;
    wire div_dot, div_key;
    wire [3:0] pos;
    clk_div_dot u_clk_div_dot(.clk(clk),.rst(rst),.div_clk(div_dot));
    clk_div_key u_clk_div_key(.clk(clk),.rst(rst),.div_clk(div_key));
    dot_control u_dot_control(.clk(div_dot),.pos(pos),.row(row),.col(col));
    key_control u_key_control (.clk(div_key),.rst(rst),.r_sig(r_sig),.l_sig(l_sig),.pos(pos));
endmodule