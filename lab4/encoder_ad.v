module testbench;



    reg [3:0] in;



    wire [1:0] out;

    wire valid;



    encoder u1(.in(in),.valid(valid),.out(out));



    initial begin

        

        in = 4'b0001;



        #5

        

        if(valid)

            $display ("in = %b; Output is valid, out = %b", in, out);

        else

            $display ("in = %b; Output is not valid, out = %b", in, out);



        #20

        

        in = 4'b1010;



        #5

        

        if(valid)

            $display ("in = %b; Output is valid, out = %b", in, out);

        else

            $display ("in = %b; Output is not valid, out = %b", in, out);



        #20

        

        in = 4'b0100;



        #5

        

        if(valid)

            $display ("in = %b; Output is valid, out = %b", in, out);

        else

            $display ("in = %b; Output is not valid, out = %b", in, out);



        #20

        

        in = 4'b1000;



        #5

        

        if(valid)

            $display ("in = %b; Output is valid, out = %b", in, out);

        else

            $display ("in = %b; Output is not valid, out = %b", in, out);



        #20

        

        in = 4'b0000;



        #5

        

        if(valid)

            $display ("in = %b; Output is valid, out = %b", in, out);

        else

            $display ("in = %b; Output is not valid, out = %b", in, out);



        #20

        

        in = 4'b1111;



        #5

        

        if(valid)

            $display ("in = %b; Output is valid, out = %b", in, out);

        else

            $display ("in = %b; Output is not valid, out = %b", in, out);





        $finish;



    end



endmodule



module encoder(in, valid, out);
    input [3:0] in;
    output reg valid;
    output reg [1:0] out;
    /* modify the code here*/
    always@(in)begin
        if(in[3] == 1'b1)
        begin
            out = 2'b11;
        end
        else if(in[2] == 1'b1)
        begin
            out = 2'b10;
        end
        else if(in[1] == 1'b1)
        begin
            out = 2'b01;
        end
        else
        begin
            out = 2'b00;
        end
    end   
endmodule