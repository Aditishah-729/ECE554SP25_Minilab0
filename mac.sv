module MAC #
(
parameter DATA_WIDTH = 8
)
(
input clk,
input rst_n,
input En,
input Clr,
input [DATA_WIDTH-1:0] Ain,
input [DATA_WIDTH-1:0] Bin,
output [DATA_WIDTH*3-1:0] Cout
);

    // Internal signals
    logic [DATA_WIDTH*2-1:0] product;          
    logic [DATA_WIDTH*3-1:0] accumulator;      

    // Multiply operation
    always_comb begin
        product = Ain * Bin;                   
    end

    // Accumulate operation
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            accumulator <= 0;                  
        end else if (Clr) begin
            accumulator <= 0;                 
        end else if (En) begin
            accumulator <= accumulator + product; 
        end
    end

    // Assign output
    assign Cout = accumulator;


endmodule