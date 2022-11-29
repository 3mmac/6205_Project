`default_nettype none
`timescale 1ns / 1ps


module bitorder_out (
                input wire clk,
                input wire rst,
                input wire axiiv,
                input wire [1:0] axiid,

                output logic axiov,
                output logic [1:0] axiod 
                );

    //recieved in four clock cycles - 7:6 -> 5:4 -> 3:2 -> 1:0
    //output in four clock cycle - 1:0 -> 3:2 -> 5:4 -> 7:6

    logic [7:0] bufferA;
    logic [7:0] bufferB;
    logic [1:0] counter_in;
    logic [2:0] counter_out;
    logic hotswap;
    logic completeA; 

    always_ff @(posedge clk) begin
        if (rst) begin
            bufferA <= 0;
            bufferB <= 0;
            counter_in <= 0;
            counter_out <= 0;
            hotswap <= 0;
            completeA <= 0;
        end else begin
            
            //FILLING BUFFERa, OUTPUTTING BUFFERb
            if(~hotswap) begin
                //INPUT
                if (axiiv) begin
                    counter_in <= (counter_in == 2'b11)? 0: counter_in + 1'b1;

                    case(counter_in)
                        0: bufferA[1:0] <= axiid;
                        2'b01: bufferA[3:2] <= axiid;
                        2'b10: bufferA[5:4] <= axiid;
                        2'b11: begin
                                bufferA[7:6] <= axiid;
                                hotswap <= 1'b1;
                                completeA <= 1'b1;
                        end
                    endcase
                end else begin
                    bufferA <= 0;
                    counter_in <= 0;
                end
                //OUTPUT
                if (~completeA) begin
                    axiov <= 0;
                end else begin
                    case(counter_out)
                        0: begin
                            axiod <= bufferB[7:6];
                            axiov <= 1'b1;
                            counter_out <= 3'b001;
                        end 
                        3'b001: begin
                            axiod <= bufferB[5:4];
                            axiov <= 1;
                            counter_out <= 3'b010;
                        end 
                        3'b010: begin
                            axiod <= bufferB[3:2];
                            axiov <= 1'b1;
                            counter_out <= 3'b011;
                        end 
                        3'b011: begin
                            axiod <= bufferB[1:0];
                            axiov <= 1'b1;
                            counter_out <= ((counter_in == 2'b11) & axiiv)? 0: 3'b100;
                        end
                        default: begin
                            axiov <= 0;
                            counter_out <= ((counter_in == 2'b11) & axiiv)? 0: 3'b100;
                        end
                    endcase
                end
            end
            //FILLING BUFFERa, OUTPUT BUFFERb
            if(hotswap) begin
                //INPUT
                if (axiiv) begin
                    counter_in <= (counter_in == 2'b11)? 0: counter_in + 1'b1;

                    case(counter_in)
                        0: bufferB[1:0] <= axiid;
                        2'b01: bufferB[3:2] <= axiid;
                        2'b10: bufferB[5:4] <= axiid;
                        2'b11: begin
                                bufferB[7:6] <= axiid;
                                hotswap <= 0;
                        end
                    endcase
                end else begin
                    bufferB <= 0;
                    counter_in <= 0;
                end
                //OUTPUT
                case(counter_out)
                    0: begin
                        axiod <= bufferA[7:6];
                        axiov <= 1'b1;
                        counter_out <= 3'b001;
                    end 
                    3'b001: begin
                        axiod <= bufferA[5:4];
                        axiov <= 1'b1;
                        counter_out <= 3'b010;
                    end 
                    3'b010: begin
                        axiod <= bufferA[3:2];
                        axiov <= 1'b1;
                        counter_out <= 3'b011;
                    end 
                    3'b011: begin
                        axiod <= bufferA[1:0];
                        axiov <= 1'b1;
                        counter_out <= ((counter_in == 2'b11) & axiiv)? 0: 3'b100;
                    end
                    default: begin
                        axiov <= 0;
                        counter_out <= ((counter_in == 2'b11) & axiiv)? 0: 3'b100;
                    end
                endcase
            end
        end

    end
endmodule

`default_nettype wire