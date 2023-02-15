
 module SYNC_GEN_COUNTER#(parameter HEIGHT = 768,WIDTH = 683,
                                    H_F_P = 32,H_S = 56,H_B_P = 125,H_L = 896,
												V_F_P = 3,V_S = 6,V_B_P = 18,V_L = 795)   
												(output reg [$clog2(H_L)-1:0] H_count,output reg [$clog2(V_L)-1:0] V_count, output L_data,H_sync,V_sync,
												 input clk);
												 
 wire H_F_P_S, H_S_S, H_B_P_S, H_reset;
 wire V_F_P_S, V_S_S, V_B_P_S, V_reset;
 

 
 
 always@(posedge clk) begin  /// HORIZANTAL COUNTER
 if(H_reset) H_count <= 0;
 else H_count = H_count + 1;
 end
 
 always@(posedge clk) begin  /// VIRTICAL COUNTER
 if(H_reset) V_count <= V_count + 1;
 else if (V_reset) V_count <= 0;
 end
 
 // combinational sync signals generation 
 
 assign H_reset = (H_count == H_L);
 assign V_reset = (V_count == V_L);
 assign H_sync  = !(H_S_S&(!H_B_P_S));     // horizantal sync signal 
 assign V_sync  = !(V_S_S&(!V_B_P_S));     // vertical sinc signal 
 assign L_data  = !(H_F_P_S||V_F_P_S);
 
 ///////////// horizantal signals ///////////////
 
 always@(*) begin                    // latch for horizantal front pouch signal
 if(H_count == WIDTH) H_F_P_S = 1;
 else if(H_reset) H_F_P_S = 0;
 end
 
  always@(*) begin                    // latch for horizantal sync signal
 if(H_count == (WIDTH + H_F_P)) H_S_S = 1;
 else if(H_reset) H_S_S = 0;
 end
 
   always@(*) begin                    // latch for horizantal back pouch signal
 if(H_count == (H_L - H_B_P)) H_B_P_S = 1;
 else if(H_reset) H_B_P_S = 0;
 end
 
 ////////// vertical signals //////////////////
 
  always@(*) begin                    // latch for vertical front pouch signal
 if(V_count == HEIGHT) V_F_P_S = 1;
 else if(V_reset) V_F_P_S = 0;
 end
 
  always@(*) begin                    // latch for vertical sync signal
 if(V_count == (HEIGHT + V_F_P)) V_S_S = 1;
 else if(V_reset) V_S_S = 0;
 end
 
   always@(*) begin                    // latch for vertical back pouch signal
 if(V_count == (V_L - V_B_P)) V_B_P_S = 1;
 else if(V_reset) V_B_P_S = 0;
 end
 
 
 endmodule
 