
 module VGA_CONTROLLER(output wire H_SYNC,V_SYNC,R,G,B,input cry_clk);
 
 parameter HEIGHT = 768,WIDTH = 683;
 parameter H_F_P = 32,H_S = 56,H_B_P = 125,H_L = 896;
 parameter V_F_P = 3,V_S = 6,V_B_P = 18,V_L = 795;
 
 wire clk;
 wire [$clog2(H_L)-1:0] H_count;
 wire [$clog2(V_L)-1:0] V_count;
 wire L_data,areset,locked;
 
 assign areset = 0;
 
 PLL CLK(areset,cry_clk,clk,locled);  // generating the clock of 42.75MHZ frequency.
 
 SYNC_GEN_COUNTER #(.HEIGHT(768),.WIDTH(683),
                    .H_F_P(32),.H_S(56),.H_B_P(125),.H_L(896),
						  .V_F_P(3),.V_S(6),.V_B_P(18),.V_L(795))   
							SYNC_1( H_count,V_count, L_data,H_SYNC,V_SYNC,cry_clk);
							
 PIXEL_RAM #(.H_L(896),.V_L(795),.HEIGHT(683),.WIDTH(768))
            RAM({R,G,B} , H_count, V_count,L_data);
												

												
//assign R = (V_count[5])?H_count[2]:!H_count[0];
//assign G = (V_count[6])?H_count[1]:!H_count[3];
//assign B = (V_count[7])?H_count[5]:!H_count[9];
  
 
 
 endmodule 
 