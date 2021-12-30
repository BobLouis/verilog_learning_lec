`define TimeExpire_VSync 32'd60

module clk_div(clk,rst,div_clk);
input clk,rst;
output div_clk;

reg div_clk;

always @(posedge clk or negedge rst)
    begin 
        if(!rst)
        begin 
            div_clk <= 1'b0;
        end
        else
        begin 
            div_clk = ~div_clk;
        end
    end
endmodule

module clk_div_VSync(clk,rst,div_clk);
input clk,rst;
output reg div_clk;


always @(posedge clk or negedge rst)
    begin 
        if(!rst)
        begin 
            count <= 32'd0;
            div_clk <= 1'b0;
        end
        else
        begin 
            if(count == `TimeExpire_VSync)
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

module color_control (clk, rst, but_R, but_G, but_B, out_R, out_G, out_B);
    input clk, rst, but_R, but_G, but_B;
    output reg[3:0] out_R, out_G, out_B;

    always @(negedge rst) begin
            out_R <= 4'd0;
            out_G <= 4'd0;
            out_B <= 4'd0;
    end
    always @(posedge but_R ) begin
        out_R <= out_R + 4'd1;
    end      
    always @(posedge but_G ) begin
        out_G <= out_G + 4'd1;
    end      
    always @(posedge but_B ) begin
        out_B <= out_B + 4'd1;
    end      

endmodule

module sync_control (clk,Hsync,Vsync);
input clk;//25MHz
output reg Hsync, Vsync;
reg [9:0]counter_x, counter_y;
// counter and sync generation
	always @(posedge clk)  // horizontal counter
		begin 
			if (counter_x < 10'd799)
				counter_x <= counter_x + 10'd1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				counter_x <= 10'd0;              
		end  // always 
	
	always @ (posedge clk)  // vertical counter
		begin 
			if (counter_x == 10'd799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (counter_y < 10'd525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						counter_y <= counter_y + 10'd1;
					else
						counter_y <= 10'd0;              
				end  // if (counter_x...
		end  // always
	// end counter and sync generation  

    always @(posedge clk) begin
        Hsync <= (counter_x >= 10'd0 && counter_x < 10'd96) ? 1'b0:1'b1;  // hsync low for 96 counts                                                 
        Vsync <= (counter_y >= 10'd0 && counter_y < 10'd2) ? 1'b0:1'b1;   // vsync low for 2 counts
    end
        
	// hsync and vsync output assignments
	// assign Hsync = (counter_x >= 10'd0 && counter_x < 10'd96) ? 1'b0:1'b1;  // hsync low for 96 counts                                                 
	// assign Vsync = (counter_y >= 10'd0 && counter_y < 10'd2) ? 1'b0:1'b1;   // vsync low for 2 counts
	// end hsync and vsync output assignments
    
endmodule

module  VGA_control(clk, rst, but_R, but_G, but_B, out_R, out_G, out_B,Hsync,Vsync,);
    input clk, rst, but_R, but_G, but_B;
    output reg[3:0] out_R, out_G, out_B;
    input clk;//25MHz
    output reg Hsync, Vsync;
    reg [9:0]counter_x, counter_y;
    // counter and sync generation
        always @(posedge clk)  // horizontal counter
            begin 
                if (counter_x < 10'd799)
                    counter_x <= counter_x + 10'd1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
                else
                    counter_x <= 10'd0;              
            end  // always 
        
        always @ (posedge clk)  // vertical counter
            begin 
                if (counter_x == 10'd799)  // only counts up 1 count after horizontal finishes 800 counts
                    begin
                        if (counter_y < 10'd525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
                            counter_y <= counter_y + 10'd1;
                        else
                            counter_y <= 10'd0;              
                    end  // if (counter_x...
            end  // always
        // end counter and sync generation  

        always @(posedge clk) begin
            Hsync <= (counter_x >= 10'd0 && counter_x < 10'd96) ? 1'b0:1'b1;  // hsync low for 96 counts                                                 
            Vsync <= (counter_y >= 10'd0 && counter_y < 10'd2) ? 1'b0:1'b1;   // vsync low for 2 counts
        end
            
        // hsync and vsync output assignments
        // assign Hsync = (counter_x >= 10'd0 && counter_x < 10'd96) ? 1'b0:1'b1;  // hsync low for 96 counts                                                 
        // assign Vsync = (counter_y >= 10'd0 && counter_y < 10'd2) ? 1'b0:1'b1;   // vsync low for 2 counts
        // end hsync and vsync output assignments
        
    
endmodule

module test (
    clk,rst,but_R,but_G,but_B,out_R,out_G,out_B,Hsync,Vsync
);
    input clk,rst,but_R,but_G,but_B;
    output [3:0] out_R,out_G,out_B;
    output Hsync, Vsync;
    wire div_clk;
    clk_div u_clk_div(.clk(clk),.rst(rst),.div_clk(div_clk));
    color_control u_clk_div(.clk(clk), .rst(rst), .but_R(but_R), .but_G(but_G), .but_B(but_B), .out_R(out_R), .out_G(out_G), .out_B(out_B));
    sync_control u_sync_control(.clk(div_clk),.Hsync(Hsync),.Vsync(Vsync));
endmodule