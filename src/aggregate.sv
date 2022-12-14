// `default_nettype none
// `timescale 1ns / 1ps


// module aggregate #( parameter MAX_ELEMENT_SIZE = 8,
//                     parameter MAX_ROW_SIZE_A = 32,
//                     parameter MAX_COL_SIZE_A = 32)
//                 (
//                 input wire clk,
//                 input wire rst,
//                 input wire axiiv,
//                 input wire [1:0] axiid,

//                 output logic axiov,
//                 output logic [MAX_ELEMENT_SIZE+$clog2(MAX_ROW_SIZE_A)+$clog2(MAX_COL_SIZE_A)-1:0] axiod 
//                 );
    
//     //Input: Ethernet DIbits that arfe in MSBit/MSByte
//     //Output: {Element's Type, Element's Row, Element's Col, Element's Value}
//     //         [0]             [MAX_ROW_SIZE_A-1:0] [] []

//     logic [$clog2(MAX_ROW_SIZE_A)-1:0] row_buffer;
//     logic [$clog2(MAX_COL_SIZE_A)-1:0] col_buffer;
    
//     logic [5:0] bit_counter;
//     logic prev_axiiv;
//     logic packet;

//     always_comb begin
//         if(bit_counter == 6'd32) begin
//             axiod = data_buffer;
//             axiov = 1'b1;
//         end else begin
//             axiod = 0;
//             axiov = 0;
//         end
//     end

//     always_ff @(posedge clk) begin
//         if(rst) begin
//             data_buffer <= 0;
//             bit_counter <= 0;
//             prev_axiiv <= axiiv;
//             packet <= 0;
//         end else begin
//             prev_axiiv <= axiiv;

//             if(~prev_axiiv & axiiv) begin
//             //axiiv rising edge: START OF PACKET
//                 packet <= 1'b1;
//                 data_buffer[31:30] <= axiid;
//                 bit_counter <= 1'b1;
//             end else if(prev_axiiv & axiiv & packet) begin
//             //axiiv heald high: PACKET TRANSMIT
//                 case (bit_counter)
//                     6'd1: data_buffer[29:28] <= axiid;
//                     6'd2: data_buffer[27:26] <= axiid;
//                     6'd3: data_buffer[25:24] <= axiid;
//                     6'd4: data_buffer[23:22] <= axiid;
//                     6'd5: data_buffer[21:20] <= axiid;
//                     6'd6: data_buffer[19:18] <= axiid;
//                     6'd7: data_buffer[17:16] <= axiid;
//                     6'd8: data_buffer[15:14] <= axiid;
//                     6'd9: data_buffer[13:12] <= axiid;
//                     6'd10: data_buffer[11:10] <= axiid;
//                     6'd11: data_buffer[9:8] <= axiid;
//                     6'd12: data_buffer[7:6] <= axiid;
//                     6'd13: data_buffer[5:4] <= axiid;
//                     6'd14: data_buffer[3:2] <= axiid;
//                     6'd15: data_buffer[1:0] <= axiid;
//                     default: packet <= 1'b1;
//                 endcase

//                 if (bit_counter == 6'd32) begin
//                     bit_counter <= 0;
//                 end else begin
//                     bit_counter <= (bit_counter)? bit_counter + 1'b1: 0;
//                 end
//             end else if (prev_axiiv & ~axiiv & packet) begin
//             //axiiv falling edge: EDGE OF PACKET
//                 bit_counter <= 0;
//             end

//         end
//     end

// endmodule

// `default_nettype wire