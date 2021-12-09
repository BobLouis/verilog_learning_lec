`define TimeExpire 32'd25000000

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

module moore (clk_div,rst,in,tmp);
    input clk_div,rst,in;
    output reg[3:0]tmp;
    reg [2:0]state;
    reg [2:0]next_state;
    parameter S0 = 3'b000, S1 = 3'b001,S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;
    always @(posedge clk_div or negedge rst or in) 
        begin
            if(!rst)
            begin
                state <= 0;
                tmp <= 1'b0;
            end
            else
            begin 
                if(in == 1'b1)
                begin
                    case(state)
                        S0:begin
                            next_state = S3;
                        end
                        S1:begin
                            next_state = S5;
                        end
                        S2:begin
                            next_state = S0;
                        end
                        S3:begin
                            next_state = S1;
                        end
                        S4:begin
                            next_state = S2;
                        end
                        S5:begin
                            next_state = S4;
                        end
                    endcase
                end
                else
                begin
                    case(state)
                        S0:begin
                            next_state = S1;
                        end
                        S1:begin
                            next_state = S2;
                        end
                        S2:begin
                            next_state = S3;
                        end
                        S3:begin
                            next_state = S4;
                        end
                        S4:begin
                            next_state = S5;
                        end
                        S5:begin
                            next_state = S0;
                        end
                    endcase
                end
                state <= next_state;
                tmp <= state; 
            end
        end
endmodule

module seven__display (count,out);
input [3:0]count;
output reg [6:0]out;
always @(count) 
begin
    case(count)
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

module test (rst,clk,out);
input rst ,clk;
output [6:0]out;
wire clk_div;
wire [3:0]count;
clk_div u_clk_div(.clk(clk),.rst(rst),.div_clk(clk_div));
moore u_moore(.clk_div(clk_div),.rst(rst),.tmp(count));
seven__display u_dis(.count(count),.out(out));
    
endmodule
