`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2024 17:35:21
// Design Name: 
// Module Name: tb
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

interface dec_1101_intf();
logic clk;
logic din;
logic rst;
logic dout;
endinterface

class transaction;
randc bit din;
bit clk;
bit rst;
bit dout;
endclass

class generator;
mailbox mbx;
transaction t;
integer i;
event done;

function new(mailbox mbx);
this.mbx=mbx;
endfunction

task run();
for(i=0; i<20; i++)
begin
t=new();
t.randomize();
mbx.put(t);
#10;
end
-> done;
endtask
endclass



class driver;
mailbox mbx;
transaction t;
virtual dec_1101_intf vif;

function new(mailbox mbx);
this.mbx = mbx;
endfunction

task run();
forever begin
t=new();
mbx.get(t);
vif.din = t.din;
#10;
end
endtask
endclass

module tb;
dec_1101_intf vif();
generator gen;
driver drv;
transaction t;
mailbox mbx;

dec_1101 dut(vif.clk, vif.din, vif.rst, vif.dout);
initial begin
vif.clk = 1'b0;
forever #2 vif.clk = ~vif.clk;
end

initial begin
vif.rst=1'b1;
#20;
vif.rst = 1'b0;
end


initial begin
t=new();
mbx=new();
gen=new(mbx);
drv=new(mbx);
drv.vif=vif;

fork
gen.run();
drv.run();
join_any
wait(gen.done.triggered);
end
endmodule
