`timescale  1ns / 1ps
`define CYCLE_TIME 1000
`define CYCLE 10
module tb_LSFR;

// LSFR Parameters
parameter S_WIDTH    = 8;
parameter IND_WIDTH  = 2;
parameter RND_WIDTH  = 6;

parameter RANDOM_SEED_1 = 8'd125;
parameter RANDOM_SEED_2 = 8'd87;
parameter RANDOM_SEED_3 = 8'd24;

reg clk=0;
reg flag=0;
reg [9:0] count=0;
reg rst_n,in_valid;

// LSFR Outputs
wire[S_WIDTH-1:0] random_num_ff_1 ;
wire[S_WIDTH-1:0] random_num_ff_2 ;
wire[S_WIDTH-1:0] random_num_ff_3 ;

reg [IND_WIDTH-1:0] random_num_ff_2_o;
reg [RND_WIDTH-1:0] random_num_ff_3_o;

//clk
always
begin
  #(`CYCLE/2) clk = ~clk;
end

initial
begin
    rst_n = 0;
    in_valid = 0;
    #12 rst_n = 1;
    @(negedge clk)
    in_valid = 1;
    @(negedge clk)
    flag = 1;
    in_valid = 0;
    #`CYCLE_TIME;
    flag = 0;
    $finish;
end

always@(posedge clk)
begin
    if(flag) begin
        count = count + 1;
        random_num_ff_2_o = random_num_ff_2[IND_WIDTH-1:0];
        random_num_ff_3_o = random_num_ff_3[RND_WIDTH-1:0];
        $display("----------- display number %3d ------------",count);
        $display("8 bit random_number : %3d,random_seed_1 is %3d",random_num_ff_1,RANDOM_SEED_1);
        $display("2 bit random_number : %3d,random_seed_2 is %3d",random_num_ff_2_o,RANDOM_SEED_2);
        $display("6 bit random_number : %3d,random_seed_3 is %3d",random_num_ff_3_o,RANDOM_SEED_3);
        $display("----------- ---------- ------------");
    end
end

//module
    LSFR #(
            .S_WIDTH(S_WIDTH),
            .RANDOM_SEED(RANDOM_SEED_1)
        ) inst_LSFR_1 (
            .clk             (clk),
            .rst_n           (rst_n),
            .in_valid        (in_valid),
            .random_num_ff_o (random_num_ff_1)
        );

    LSFR #(
            .S_WIDTH(S_WIDTH),
            .RANDOM_SEED(RANDOM_SEED_2)
        ) inst_LSFR_2 (
            .clk             (clk),
            .rst_n           (rst_n),
            .in_valid        (in_valid),
            .random_num_ff_o (random_num_ff_2)
        );


    LSFR #(
            .S_WIDTH(S_WIDTH),
            .RANDOM_SEED(RANDOM_SEED_3)
        ) inst_LSFR_3 (
            .clk             (clk),
            .rst_n           (rst_n),
            .in_valid        (in_valid),
            .random_num_ff_o (random_num_ff_3)
        );


endmodule