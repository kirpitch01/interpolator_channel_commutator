`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.07.2026 09:22:15
// Design Name: 
// Module Name: InterpolChCommutator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module InterpolChCommutator
#(
parameter data_width = 32,
parameter num_of_ch = 4


)

(    
    input clk,
    input valid_in,
    input  [ ( data_width * num_of_ch )- 1 : 0] data_in,
    output reg  [ data_width - 1 : 0 ] data_out
    );
    reg [  $clog2(num_of_ch)-1:0 ]cnt =  { $clog2( num_of_ch ){1'b0}};
    reg [( data_width * num_of_ch )- 1 : 0  ] data_reg;
    reg first_valid = 1'b0;
//    integer k;


// assign data_out = data_reg[(data_width * cnt +1) -1: data_width*(cnt)];
    always @(posedge clk)
        begin
        cnt <= cnt + 1;
            data_reg <= data_in;
            if (valid_in)
                begin
                    cnt <= { $clog2(num_of_ch){1'b0}};
                    first_valid <= 1'b1;
                end 
            else
                begin
                
                end
   
        end
        
    genvar k;
    generate   for (k = 0 ; k < num_of_ch; k = k +1)
            begin 
//                always_comb    
//                if (cnt == k)
////                data_out = data_reg[(data_width * (num_of_ch - k)) -1: data_width*(num_of_ch - k -1)];
//                data_out = data_reg[(data_width * (k+1)) -1: data_width*(k)];
              always @(posedge clk)    
                if (cnt == k)
//                data_out = data_reg[(data_width * (num_of_ch - k)) -1: data_width*(num_of_ch - k -1)];
                data_out <= data_reg[(data_width * (k+1)) -1: data_width*(k)];
        end
    
    endgenerate 
    
endmodule
