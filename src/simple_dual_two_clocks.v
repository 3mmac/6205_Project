// Simple Dual-Port Block RAM with Two Clocks, No-Change
// File: simple_dual_two_clocks.v

`default_nettype wire
module simple_dual_two_clocks 

    #(  parameter RAM_WIDTH = 32, // Specify RAM data width
        parameter RAM_DEPTH = 256 // Specify RaM data depth 
    )(   
        input clka,                             // Port A Clock
        input clkb,                             // Port B Clock
        input ena,                              // Port A RAM enable
        input enb,                              // Port B RAM enable
        input wea,                              // Port A write enable
        input [clogb2(RAM_DEPTH-1)-1:0] addra,  // Port A address bus, width determined from RAM_DEPTH
        input [clogb2(RAM_DEPTH-1)-1:0] addrb,  // Port B address bus, width determined from RAM_DEPTH
        input [RAM_WIDTH-1:0] dia,              // Port A input data
        output [RAM_WIDTH-1:0] dob              // Port B output data
    );   

    reg [RAM_WIDTH-1:0] ram [RAM_DEPTH-1:0];
    reg [RAM_WIDTH-1:0] dob;

    always @(posedge clka)
    begin
        if (ena) begin
            if (wea) ram[addra] <= dia;
        end
    end

    always @(posedge clkb) begin
        if (enb) begin
            dob <= ram[addrb];
        end
    end

endmodule

`default_nettype none