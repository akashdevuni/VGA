
 module PIXEL_RAM #(parameter H_L = 896,V_L = 795,HEIGHT = 683,WIDTH = 768)(output wire [2:1] OUT ,input [$clog2(H_L)-1:0] H_count,input [$clog2(V_L)-1:0] V_count,input SEL);
 
 
 reg [2:0] PIXEL[HEIGHT-1:0][WIDTH-1:0];
 
 assign OUT = (SEL)?PIXEL[H_count][V_count]:0;
 
 //initial $readmemb("pixel_file.mem",PIXEL);
 
 /* 
 $readmemh("hex_memory_file.mem", memory_array, [start_address], [end_address])
 $readmemb("bin_memory_file.mem", memory_array, [start_address], [end_address])
 */
 
 endmodule
 