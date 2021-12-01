module HA (
    a, b, sum, carry
);
    input a, b;
    output sum, carry;
    assign carry = a&b;
    assign sum   = a^b;
    
endmodule

module Mux (
    a, b, c
);
    input [2:0] a, b;
    output [2:0] c;
    assign c = (a>b)? a:b;
endmodule

module half_adder (
    x,y,out
);
    input x,y;
    output [1:0] out;
    assign out = x+y;
endmodule

module half_adder_concate (
    x,y,c,s;
);
    input x,y;
    output c,s;

    assign {c,s} = x+y;
endmodule