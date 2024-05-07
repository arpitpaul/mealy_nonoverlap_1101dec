`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2024 17:22:25
// Design Name: 
// Module Name: dec_1101
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


module dec_1101(
input clk,din,rst,
output reg dout
    );
    
    reg [1:0] ps;
    parameter s0=2'd0, s1=2'd1, s2= 2'd2, s3= 2'd3;
    
    
    always@(posedge clk)
    begin
    if(rst)
    begin
    ps <= s0;
    dout <= 1'b0;
    end
    
    else
    begin
    case(ps)
    s0: begin
    if(din)
    begin
    ps <= s1; dout <= 1'b0;
    end
    else
    begin
    ps <= s0;
    dout <= 1'b0;
    end
    
    end
    
    
    s1: begin
    if(din)
    begin
    ps <= s2; dout <= 1'b0;
    end
    
    else
    begin
    ps <= s0; dout <= 1'b0;
    end
    
    end
    
    
    s2: begin
    if(din)
    begin
    ps <= s2; dout <= 1'b0;
    end
    
    else
    begin
    ps <= s3; dout <= 1'b0;
    end
    
    end
    
    s3: begin
    if(din)
    begin
    ps <= s0; dout <= 1'b1;
    end
    
    else
    begin
    ps <= s0; dout <= 1'b0;
    end
    
    end
    
    default: begin
    ps <= s0; dout <= 1'b0;
    end
    
    endcase
    end
    end
endmodule
