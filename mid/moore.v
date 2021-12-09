//非同步復源 reset -> 8 state -> 0 
module test(clk,reset, out, in);

input clk,reset, in;

reg[3:0] state;
reg[31:0] clock_div;
reg flag;
output reg[6:0] out;

//clock div
always @(posedge clk or negedge reset) begin
  if (!reset) begin
		clock_div <= 0;
		flag <= 0;
  end
  else begin
	  if(clock_div == 32'd25000000)begin
		 clock_div <= 0;
		 flag <= ~flag;
	  end
	  else begin
		 clock_div <= clock_div + 1;
	  end
   end
end

//state change
always @(posedge flag or negedge reset) begin

  if(!reset)begin
    out <= 7'b0000000;
    state <= 0;
  end
  else begin
   if (!in) begin
		case(state)
			4'b0000:begin
				 state <= 4'b0001;
			end
			4'b0001:begin
				 state <= 4'b0010;
			end
			4'b0010:begin
				 state <= 4'b0011;
			end
			4'b0011:begin
				 state <= 4'b0100;
			end
			4'b0100:begin
				 state <= 4'b0101;
			end
			4'b0101:begin
				 state <= 4'b0000;
			end
		endcase
	end
	else begin
		case(state)
			4'b0000:begin
				 state <= 4'b0011;
			end
			4'b0001:begin
				 state <= 4'b0101;
			end
			4'b0010:begin
				 state <= 4'b0000;
			end
			4'b0011:begin
				 state <= 4'b0001;
			end
			4'b0100:begin
				 state <= 4'b0010;
			end
			4'b0101:begin
				 state <= 4'b0100;
			end
		endcase
	end
  end
end
//7th display
always@(*)begin
  if(in == 1)begin
    out = 7'b0000000;
  end
  else begin
    case(state)
    4'b0000:begin
      out = 7'b1000000;
    end
    4'b0001:begin
      out = 7'b1111001;
    end
    4'b0010:begin
      out = 7'b0100100;
    end
    4'b0011:begin
      out = 7'b0110000;
    end
    4'b0100:begin
      out = 7'b0011001;
    end
    4'b0101:begin
      out = 7'b0010010;
    end
    4'b0110:begin
      out = 7'b0000010;
    end
    4'b0111:begin
      out = 7'b1111000;
    end
    4'b1000:begin
      out = 7'b0000000;
    end
    4'b1001:begin
      out = 7'b0010000;
    end
    4'b1010:begin
      out = 7'b0001000;
    end
    4'b1011:begin
      out = 7'b0000011;
    end
    4'b1100:begin
      out = 7'b1000110;
    end
    4'b1101:begin
      out = 7'b0100001;
    end
    4'b1110:begin
      out = 7'b0000110;
    end
    4'b1111:begin
      out = 7'b0001110;
    end
    endcase
  end
  

end
endmodule 
