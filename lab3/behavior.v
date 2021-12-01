module HA (
    a, b, sum, carry
);
    input a, b;
    output reg sum, carry;

    always @(a or b) begin
        sum = a^b;
        carry = a&b;
    end
endmodule

module MUX (
    a, b, c
);
    input [2:0] a,b;
    output reg [2:0]c;

    always @(*) begin
        if(a > b)
            c = a;
        else
            c = b;
    end
endmodule

module half_adder (
    x,y,out
);
    input x,y;
    output [1:0] out;

    reg [1:0] out;

    always @(x or y) begin
        out = x+y;
    end
endmodule

module HA_case (
    input x,y;
    output reg s,c;

    always @(*) begin
        case ({x,y})
            2'b00:begin
                s = 0;
                c = 0;
            end 
            2'b01:begin
                s = 1;
                c = 0;
            end
            2b'10:begin
                s = 1;
                c = 0;
            end
            2b'11:begin
                s = 1;
                c = 1;
            end
        endcase
    end

);
    
endmodule