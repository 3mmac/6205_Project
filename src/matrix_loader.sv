`default_nettype none
`timescale 1ns / 1ps

//Potential Alteration, send out addr when added and then the module can request when its addr is seen
//NEED TO ADD CHECK SYSTEM

module matrix_loader #( parameter MAX_ELEMENT_SIZE = 8, //ASsUME EVEN ONLY
                        parameter MAX_SIZE_A = 32,
                        parameter MAX_SIZE_B = 32)

                    (   input wire inter_refclk,
                        input wire eth_refclk,
                        input wire rst,

                        input wire axiiv,
                        input wire axiid,

                        input wire requested_a_row,
                        input wire requested_b_col,

                        
                        output logic addr_out;
                        output logic [MAX_ROW_SIZE_A*MAX_ELEMENT_SIZE-1:0] a_row_out,
                        output logic [MAX_ROW_SIZE_A*MAX_ELEMENT_SIZE-1:0] b_col_out,
                        output logic complete
                    );

    // BRAM address = 0 through 31
    // BRAM value = an 256 bit number
    
    logic bram_rst;
    logic bad;

    logic downtime;
    logic loading;
    logic transmitting;


    logic [:0] element_buffer; // storing current element
    logic [1:0] element_counter; // 4 clock cycles per element
    logic [255:0] row_buffer; // storing row
    logic [9:0] matrix_counter; // 1024 elements in matrix
    
    logic [4:0] A_addra; //matrix A loading address
    logic [4:0] A_addrb; //matrix A recieving address
    logic [4:0] B_addra; //matrix B loading address
    logic [4:0] B_addrb; //matrix B recieving address
    logic [255:0] A_dina; //matrix A element value 
    
    always_comb begin
      bram_rst = rst | bad;
    end


    always_ff @(posedge eth_refclk) begin
        if (rst) begin
            downtime <= 1'b1;
            loading <= 0;
            transmitting <= 0;
            element_data <== 0;
        end
        
        else if (downtime) begin
          if (axiiv) begin
              downtime <= 0;
              loading <= 1'b1;
              row_buffer <= {axiid, 0};
              matrix_counter <=  1'b1;
          end
        end
        
        else if (loading) begin
          if (axiiv) begin
            //element filled
            if (element_counter == 2'b11) begin
              //filled matrix
              if(matrix_counter == 10'd1023) begin
                matrix_counter <= 0;
                loading <= 0;
                complete <= 1'b1;
              end

              element_counter <= 0;
              matrix_counter <= matrix_counter + 1'b1;
              
              //for testing purposes
              if (matrix_counter%32 == 0) begin
                a_row_out = row_buffer;
              end
              //for testing purposes

              row_buffer[255-(matrix_counter%32)*8:248-(matrix_counter%32)*8] <= {element_buffer, axiid} // 31 different areas of 8
            end
            //filling element
            else begin
              element_counter <= element_counter + 1'b1;
              element_buffer[5-element_counter*2:4-element_counter*2] <= axiid;// 00=[7:6], 01=[5:4], 10=[3:2], 11=[1:0]
            end
          end
        end

        else if (transmitting)begin
          complete <= 1'b1;
          
        end
    end



    always_ff @(posedge inter_refclk) begin
        if (retrieving) begin
        end

        else begin
        end
    end


//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_COL_SIZE_A),                       // Specify RAM data width
    .RAM_DEPTH(MAX_ELEMENT_SIZE*MAX_ROW_SIZE_A),                     // Specify RAM depth (number of entries)
    .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    .INIT_FILE("")                        // Specify name/location of RAM initialization file if using one (leave blank if not)
  ) Matrix_A_BRAM (
    .addra(A_addra),    // Write address bus, width determined from RAM_DEPTH
    .addrb(A_addrb),    // Read address bus, width determined from RAM_DEPTH
    .dina(A_dina),      // RAM input data, width determined from RAM_WIDTH
    .clka(eth_refclk),      // Write clock
    .clkb(inter_refclk),      // Read clock
    .wea(A_wea),        // Write enable
    .enb(A_enb),        // Read Enable, for additional power savings, disable when not in use
    .rstb(rst),      // Output reset (does not affect memory contents)
    .regceb(A_regceb),  // Output register enable
    .doutb(a_row_out)     // RAM output data, width determined from RAM_WIDTH
  );

//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_ROW_SIZE_B),                       // Specify RAM data width
    .RAM_DEPTH(MAX_ELEMENT_SIZE*MAX_COL_SIZE_B),                     // Specify RAM depth (number of entries)
    .RAM_PERFORMANCE("HIGH_PERFORMANCE"), // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
    .INIT_FILE("")                        // Specify name/location of RAM initialization file if using one (leave blank if not)
  ) Matrix_B_BRAM (
    .addra(B_addra),    // Write address bus, width determined from RAM_DEPTH
    .addrb(B_addrb),    // Read address bus, width determined from RAM_DEPTH
    .dina(B_dina),      // RAM input data, width determined from RAM_WIDTH
    .clka(eth_refclk),       // Write clock
    .clkb(inter_refclk),      // Read clock
    .wea(B_wea),        // Write enable
    .enb(B_enb),        // Read Enable, for additional power savings, disable when not in use
    .rstb(rst),      // Output reset (does not affect memory contents)
    .regceb(B_regceb),  // Output register enable
    .doutb(b_col_out)     // RAM output data, width determined from RAM_WIDTH
  );


endmodule

`default_nettype wire