module testbench;



    reg     [3:0]   data_in;

    wire    [6:0]   data_out;



    special_multiplier special_multiplier_u(.num(data_in), .result(data_out));



    initial begin

        #10





        data_in = 4'd0;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);

        

        

        data_in = 4'd1;

        #5

        if(data_out == 7'b1111001)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 1", data_in, data_out);



        

        data_in = 4'd2;

        #5

        if(data_out == 7'b0100100)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 2", data_in, data_out);



        

        data_in = 4'd3;

        #5

        if(data_out == 7'b0000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 8", data_in, data_out);



       

        data_in = 4'd4;

        #5

        if(data_out == 7'b0001000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 10", data_in, data_out);



        

        data_in = 4'd5;

        #5

        if(data_out == 7'b1000110)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 12", data_in, data_out);



        

        data_in = 4'd6;

        #5

        if(data_out == 7'b0001000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 10", data_in, data_out);



        

        data_in = 4'd7;

        #5

        if(data_out == 7'b1000110)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 12", data_in, data_out);



        

        data_in = 4'd8;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd9;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd10;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd11;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd12;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd13;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd14;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);



        

        data_in = 4'd15;

        #5

        if(data_out == 7'b1000000)

            $display ("correct !!!");

        else

            $display ("wrong, data_in = %d, your answer = %d, expect answer = 0", data_in, data_out);





        $finish;



    end



endmodule









module special_multiplier(num, result);

    input   [3:0]   num;
    output  reg[6:0]   result;
    /* modify the code here */
    always @(num) begin
        case (num)
            4'd0: result =7'b1000000; //0
            4'd1: result =7'b1111001; //1
            4'd2: result =7'b0100100; //2
            4'd3: result =7'b0000000; //8 (3+1)*2
            4'd4: result =7'b0001000; //10 (4+1)*2
            4'd5: result =7'b1000110; //12 (5+1)*2
            4'd6: result =7'b0001000; //10 (6-1)*2
            4'd7: result =7'b1000110; //12 (7-1)*2
            default: result = 7'd64;
        endcase
    end
    

endmodule