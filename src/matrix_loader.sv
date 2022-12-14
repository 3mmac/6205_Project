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
                        input wire [1:0] axiid,

                        input wire valid_request,
                        input wire [$clog2(MAX_SIZE_A)-1:0] requested_a_row,
                        input wire [$clog2(MAX_SIZE_B)-1:0] requested_b_col,

                        output logic valid_out,
                        output logic [$clog2(MAX_SIZE_A)-1:0] a_addr_out,
                        output logic [$clog2(MAX_SIZE_B)-1:0] b_addr_out,
                        output logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] a_row_out,
                        output logic [MAX_SIZE_A*MAX_ELEMENT_SIZE-1:0] b_col_out,
                        output logic complete
                    );

    // BRAM address = 0 through 31
    // BRAM value = an 256 bit number
    
    logic bram_rst;
    logic bad;

    logic downtime;
    logic loading;
    logic transmitting;

    logic A;
    logic B;

    logic [5:0] element_buffer; // storing current element
    logic [1:0] element_counter; // 4 clock cycles per element
    logic [255:0] row_buffer; // storing row
    logic [9:0] matrix_counter; // 1024 elements in matrix
    
    logic [4:0] A_addra, A_addrb, B_addra, B_addrb; //BRAM address
    logic [255:0] A_dina, B_dina, A_dout, B_dout; //BRAM data
    logic A_wea, B_wea, A_enb, B_enb, A_regceb, B_regceb;
 
    logic [1:0] [4:0] A_addr_buffer;
    logic [1:0] [4:0] B_addr_buffer;
    logic [1:0] valid_data_buffer;

    always_comb begin
      bram_rst = rst | bad;
      A_addrb = requested_a_row;
      B_addrb = requested_b_col;
    end              


    always_ff @(posedge eth_refclk) begin
        if (rst) begin
            downtime <= 1'b1;
            loading <= 0;

            element_counter <= 0;
            matrix_counter <= 0;

            A <= 0;
            B <= 0;

            complete <= 0;
        end               
        
        else if (downtime) begin
          if (axiiv) begin
              downtime <= 0;
              loading <= 1'b1;
              row_buffer <= {axiid, 254'd0};
              matrix_counter <=  1'b1;
              A <= 1'b1;
          end

          //nothing with BRAM port a should be happening
          A_wea <= 0;
          B_wea <= 0;
          complete <= 0;

        end
        
        else if (loading) begin
          if (axiiv) begin
            //element filled
            if (element_counter == 2'b11) begin
              //filled matrixrequested_b_row
              if(matrix_counter == 10'd1023) begin
                matrix_counter <= 0;
                element_counter <= 0;
          
                if (A) begin
                  A_dina <= {row_buffer[255:8], element_buffer, axiid};
                  A_addra <= 5'b11111;
                  A_wea <= 1'b1;
                  A <= 0;
                  B <= 1'b1;
                end else if (B) begin
                  B_dina <= {row_buffer[255:8], element_buffer, axiid};
                  B_addra <= 5'b11111;
                  B_wea <= 1'b1;
                  loading <= 0;
                  transmitting <= 1'b1;
                  complete <= 1'b1;
                  B <= 0;
                end
              end
              
              //only a filling row
              else begin
                complete <= 0;
                element_counter <= 0;
                matrix_counter <= matrix_counter + 1'b1;
                
                //filled row
                if ((matrix_counter+1)%32 == 0) begin
                  if(A) begin
                    A_dina <= {row_buffer[255:8], element_buffer, axiid};
                    A_addra <= matrix_counter/32;
                    A_wea <= 1'b1;
                  end else if (B) begin
                    B_dina <= {row_buffer[255:8], element_buffer, axiid};
                    B_addra <= matrix_counter/32;
                    B_wea <= 1'b1;
                  end
                end 
                
                else begin
                  row_buffer[(255-(matrix_counter%32))-:8] <= {element_buffer, axiid};
                  A_wea <= 0;
                  B_wea <= 0;
                end
              end
            end
            //filling element
            else begin
              element_counter <= element_counter + 1'b1;
              element_buffer[(5-element_counter*2)-: 2] <= axiid;
              A_wea <= 0;
              B_wea <= 0;
            end
          end
        end

        else if (transmitting)begin
          complete <= 0;
          
          //BRAM no longer allowing writes
          A_wea <= 0;
          B_wea <= 0;
        end
    end


    always_ff @(posedge inter_refclk) begin
        if (rst) begin
          A_enb <= 0;
          A_regceb <= 0;

          B_enb <= 0;
          B_regceb <= 0;

          valid_out <= 0;
        end

        else if (transmitting) begin
          //BRAM allowing reads
          A_enb <= 1'b1;
          A_regceb <= 1'b1;
          B_enb <= 1'b1;
          B_regceb <= 1'b1;

          A_addr_buffer[0] <= requested_a_row;
          A_addr_buffer[1] <= A_addr_buffer[0];
          a_addr_out <= A_addr_buffer[1];
          B_addr_buffer[0] <= requested_b_col;
          B_addr_buffer[1] <= B_addr_buffer[0];
          b_addr_out <= B_addr_buffer[1];
          valid_data_buffer[0] <= valid_request;
          valid_data_buffer[1] <= valid_data_buffer[0];
          valid_out <= valid_data_buffer[1];

          a_row_out <= A_dout;
          b_col_out <= B_dout;

        end

        else begin
          A_enb <= 0;
          A_regceb <= 0;


          B_enb <= 0;
          B_regceb <= 0;

          valid_out <= 0;
        end
    end


//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_SIZE_A*MAX_ELEMENT_SIZE),                       // Specify RAM data width
    .RAM_DEPTH(MAX_SIZE_A),                     // Specify RAM depth (number of entries)
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
    .doutb(A_dout)     // RAM output data, width determined from RAM_WIDTH
  );

//  Xilinx Simple Dual Port 2 Clock RAM
  xilinx_simple_dual_port_2_clock_ram #(
    .RAM_WIDTH(MAX_SIZE_B*MAX_ELEMENT_SIZE),                       // Specify RAM data width
    .RAM_DEPTH(MAX_SIZE_B),                     // Specify RAM depth (number of entries)
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
    .doutb(B_dout)     // RAM output data, width determined from RAM_WIDTH
  );


endmodule

`default_nettype wire