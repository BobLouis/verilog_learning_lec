`define TimeExpire 32'd5000

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

module dot_control (clk_div,rst,row,col);
    input clk_div,rst;
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
            case (state)
                0:begin row <= 8'b11111110; col <= 8'b00011000; end
                1:begin row <= 8'b11111101; col <= 8'b00100100; end
                2:begin row <= 8'b11111011; col <= 8'b01000010; end
                3:begin row <= 8'b11110111; col <= 8'b11000011; end
                4:begin row <= 8'b11101111; col <= 8'b01000010; end
                5:begin row <= 8'b11011111; col <= 8'b01000010; end
                6:begin row <= 8'b10111111; col <= 8'b01000010; end
                7:begin row <= 8'b01111111; col <= 8'b01111110; end
            endcase
            state <= state + 1'b1;
        end
    end
endmodule

module test (rst,clk,row,col);
input rst ,clk;
output [7:0] row,col;
wire clk_div;
clk_div u_clk_div (.clk(clk),.rst(rst),.div_clk(clk_div));
dot_control u_dot_control (.clk_div(clk_div),.rst(rst),.row(row),.col(col));
    
endmodule