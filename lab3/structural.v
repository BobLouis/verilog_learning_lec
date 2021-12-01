module HA (
    a, b, sum, carry
);
    input a, b;
    output sum, carry;

    and(carry, a, b);  //and gate
    xor(sum, a, b);    //xor gate
endmodule