`default_nettype none
`timescale 1ns / 1ps

module ether (
                input wire clk,             //50MHz clock
                input wire rst,             //reset signal
                input wire crsdv,           //CarrieR Sense/Data Valid
                input wire [1:0] rxd,       //Current Transmission (Big Endian Order)

                output logic axiov,           //AXI output, valid signal
                output logic [1:0] axiod    //AXI output, data bus
            );

    logic preamble_SFD_search;
    logic [4:0] preamble_SFD_counter;
    logic start_invalid;
    logic transmit;
    logic [13:0] transmit_counter;

    always_ff @(posedge clk) begin
        if (rst) begin
            preamble_SFD_search <= 0;
            preamble_SFD_counter <= 0;
            start_invalid <= 0;
            transmit <= 0;
            transmit_counter <=0;
        end else begin

            if (crsdv) begin
                if(~start_invalid) begin

                    if(~preamble_SFD_search & ~transmit & (rxd == 2'b01)) begin     //ready to accept and matching first transmission
                        preamble_SFD_search <= 1'b1;
                        preamble_SFD_counter <= 1'b1;
                        axiov <= 0;
                    end 
                    
                    else if (preamble_SFD_search) begin             //already checking valid preamble and SFD
                        if(preamble_SFD_counter == 31) begin        //last group
                            if (rxd == 2'b11) begin
                                transmit <= 1'b1;
                            end else begin
                                start_invalid <= 1'b1;
                            end
                            preamble_SFD_search <= 0;
                            preamble_SFD_counter <= 0;
                        end else if (rxd == 2'b01)begin                
                            preamble_SFD_counter <= preamble_SFD_counter + 1'b1;
                        end else begin
                            start_invalid <= 1'b1;
                            preamble_SFD_search <= 0;
                            preamble_SFD_counter <= 0;                            
                        end
                        axiov <= 0;
                    end 
                    
                    if (transmit) begin
                        //updating data_length
                        if (crsdv) begin
                            axiov <= 1'b1;
                            axiod <= rxd;
                        end else begin
                            transmit <= 0;
                            axiov <= 0;
                        end
                    end
                end else begin
                    axiov <= 0;
                end
            end else begin
                preamble_SFD_search <= 0;
                preamble_SFD_counter <= 0;
                start_invalid <= 0;
                transmit <= 0;
                transmit_counter <=0;
                axiov <= 0;
            end
        end
                
    end

endmodule

`default_nettype wire