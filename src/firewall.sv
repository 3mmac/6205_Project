`default_nettype none
`timescale 1ns / 1ps


module firewall (
                input wire clk,
                input wire rst,
                input wire axiiv,
                input wire [1:0] axiid,

                output logic axiov,
                output logic [1:0] axiod,
                output logic led 
                );

    //recieved in four clock cycle - 7:6 -> 5:4 -> 3:2 -> 1:0
    //accept packet personal(Testbest - 69:69:5A:06:54:91 Personal - FE:ED:B0:BA:F1:DD) 
    //and broadcast (FF:FF:FF:FF:FF:FF) packets    

    logic prev_axiiv;
    logic [5:0] addr_counter;
    logic invalid_b;
    logic invalid_p;

    logic [47:0] broadcast_MAC;
    logic [47:0] personal_MAC;
    assign broadcast_MAC = 48'hFF_FF_FF_FF_FF_FF;
    assign personal_MAC = 48'hFE_ED_B0_BA_F1_DD;

    assign axiod = axiid;

    always_comb begin
        if(axiiv) begin
            if (~prev_axiiv) begin
                axiov = 0;
                led = 0;
            end else if(addr_counter < 56) begin
                led = 0;
                axiov = 0;
            end else if (invalid_b & invalid_p) begin
                axiov = 0;
                led = 0;
            end else begin
                axiov = axiiv;
                led = 1;
            end
        end else if(~axiiv) begin
            axiov = 0;
            led = 0;
        end else begin
            axiov = 0;
            led = 0;
        end
    end


    always_ff @(posedge clk) begin
        if(rst) begin
            prev_axiiv <= axiiv;
            addr_counter <= 0;
            invalid_b <= 0;
            invalid_p <= 0;
        end
        else begin
            prev_axiiv <= axiiv;

            if (~prev_axiiv & axiiv) begin
            //Rising edge indicates start of new packet
                invalid_b <= (axiid == broadcast_MAC[47:46])? 1'b0: 1'b1;  
                invalid_p <= (axiid == personal_MAC[47:46])? 1'b0:1'b1;
                addr_counter <= 1'b1;
            end else if (axiiv) begin
            //Continous high edge is packet still transmitting
                if (addr_counter < 24) begin
                    //transmitting DA
                    case(addr_counter)
                        6'd1: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[45:44])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[45:44])? 0: 1'b1);                           
                        end
                        6'd2: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[43:42])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[43:42])? 0: 1'b1);                           
                        end
                        6'd3: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[41:40])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[41:40])? 0: 1'b1);                           
                        end
                        6'd4: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[39:38])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[39:38])? 0: 1'b1);                           
                        end
                        6'd5: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[37:36])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[37:36])? 0: 1'b1);                           
                        end
                        6'd6: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[35:34])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[35:34])? 0: 1'b1);                           
                        end
                        6'd7: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[33:32])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[33:32])? 0: 1'b1);                           
                        end
                        6'd8: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[31:30])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[31:30])? 0: 1'b1);                           
                        end
                        6'd9: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[29:28])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[29:28])? 0: 1'b1);                           
                        end
                        6'd10: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[27:26])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[27:26])? 0: 1'b1);                           
                        end
                        6'd11: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[25:24])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[25:24])? 0: 1'b1);                           
                        end
                        6'd12: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[23:22])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[23:22])? 0: 1'b1);                           
                        end
                        6'd13: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[21:20])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[21:20])? 0: 1'b1);                           
                        end
                        6'd14: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[19:18])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[19:18])? 0: 1'b1);                           
                        end
                        6'd15: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[17:16])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[17:16])? 0: 1'b1);                           
                        end
                        6'd16: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[15:14])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[15:14])? 0: 1'b1);                           
                        end
                        6'd17: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[13:12])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[13:12])? 0: 1'b1);                           
                        end
                        6'd18: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[11:10])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[11:10])? 0: 1'b1);                           
                        end
                        6'd19: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[9:8])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[9:8])? 0: 1'b1);                           
                        end
                        6'd20: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[7:6])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[7:6])? 0: 1'b1);                           
                        end
                        6'd21: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[5:4])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[5:4])? 0: 1'b1);                           
                        end
                        6'd22: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[3:2])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[3:2])? 0: 1'b1);                           
                        end
                        6'd23: begin
                            invalid_b <= (invalid_b)? 1'b1: ((axiid == broadcast_MAC[1:0])? 0: 1'b1);
                            invalid_p <= (invalid_p)? 1'b1: ((axiid == personal_MAC[1:0])? 0: 1'b1);                           
                        end
                        default: begin
                            invalid_b <= 1;
                            invalid_p <= 1;
                        end
                    endcase
                    addr_counter <= addr_counter + 1'b1;
                end else if (addr_counter < 56) begin
                    //transmitting non-DA Header
                    addr_counter <= addr_counter + 1'b1;
                end 
                // else begin
                //     //transmitting Data and FCS
                //     if(invalid_b & invalid_p) begin
                //         axiov <= 0;
                //     end else begin
                //         axiov = axiiv;
                //         axiod = axiid;
                //     end
                // end
            end 
            // else begin
            // //No packets transmitting
            //     axiov = 0;
            // end

        end
    end

endmodule

`default_nettype wire