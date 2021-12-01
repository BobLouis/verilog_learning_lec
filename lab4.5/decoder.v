module testbench;
    reg     [2:0]   in;
    reg             enable;
    wire    [7:0]   out;
    decoder u1(.in(in),.enable(enable),.out(out));
    initial begin
        // enable = 0
        enable = 1'b0;
        in = 3'b000;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b001;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b010;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b011;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b100;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b101;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b110;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b111;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        // enable = 1
        enable = 1'b1;
        in = 3'b000;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b001;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b010;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b011;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b100;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b101;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b110;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        #20
        in = 3'b111;
        #5
        $display ("in = %b, enable = %b; out = %b", in, enable, out);
        $finish;
    end
endmodule

module decoder(in, enable, out);

    input       [2:0]   in;
    input               enable;
    output reg  [7:0]   out;
    /* modify the code here*/    
    always@(in)begin
        if(enable == 0)begin
            out = 8'b0;  //8represent all bits quantity
        end
        else begin
            case(in)
                3'b000: out = 8'b00000001;
                3'b001: out = 8'b00000010;
                3'b010: out = 8'b00000100;
                3'b011: out = 8'b00001000;
                3'b100: out = 8'b00010000;
                3'b101: out = 8'b00100000;
                3'b110: out = 8'b01000000;
                3'b111: out = 8'b10000000;
            endcase
        end
    end
endmodule


