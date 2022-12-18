module fitness_eval #(
           parameter NUM_PARTICLE_TYPE        = 3  ,
           parameter DATA_WIDTH               = 4  ,
           parameter PARTICLE_LENGTH          = 2  ,
           parameter LATTICE_LENGTH           = 11 ,
           parameter SELF_FIT_LENGTH          = 10 ,
           parameter SELF_ENERGY_VEC_LENGTH   = NUM_PARTICLE_TYPE,
           parameter INTERACTION_MATRIX_LENGTH = (NUM_PARTICLE_TYPE**2),
           parameter INDIVIDUAL_LENGTH        = LATTICE_LENGTH * PARTICLE_LENGTH,
           parameter POP_SIZE                 = 50,
           parameter IDX_WIDTH                = 8,
           parameter PTR_LENGTH               = 2
       ) (
           //Inputs
           input clk_i,
           input rst_n,
           input [DATA_WIDTH   -1 : 0 ]                 self_energy_i,
           input [DATA_WIDTH   -1 : 0]                  interact_energy_i,
           input [INDIVIDUAL_LENGTH   -1 :0]            individual_vec_i,
           input  wrSelfEnergyValid_i,
           input  wrInteractEnergyValid_i,
           input  in_valid_i,
           input [IDX_WIDTH -1 :0]  ind_idx_i,

           //Outputs
           output reg out_valid_ff_o,
           output reg done_ff_o,
           output reg[SELF_FIT_LENGTH-1:0] total_energy_ff_o,
           output reg[INDIVIDUAL_LENGTH - 1 :0] individual_vec_ff_o,
           output reg[IDX_WIDTH-1:0] ind_wb_idx_ff_o
       );
//================================================================
//  LOCAL PARAMETERS
//================================================================
//SelfEnergy = SE
//IneractEnergy = IE
localparam SE_DF_ADD1_PIPE_DEPTH = LATTICE_LENGTH;
localparam IE_DF_ADD1_PIPE_DEPTH = LATTICE_LENGTH - 1;

localparam LV1_SE_ADDER_NUM = 6;
localparam LV1_IE_ADDER_NUM = 5;

localparam LV2_SE_ADDER_NUM = 3;
localparam LV2_IE_ADDER_NUM = 3;

localparam LV3_ADDER_NUM = 3;

localparam LV1_ADD_RESULT_WIDTH  = DATA_WIDTH + 2;
localparam LV2_ADD_RESULT_WIDTH  = DATA_WIDTH + 3;
localparam LV3_ADD_RESULT_WIDTH  = DATA_WIDTH + 4;
localparam LV4_ADD_RESULT_WIDTH  = DATA_WIDTH + 5;
localparam LV5_ADD_RESULT_WIDTH  = SELF_FIT_LENGTH;

localparam DF_ADD1_PIPE_WIDTH    = DATA_WIDTH + 1;
localparam PARTIAL_ENERGY_PIPE_WIDTH   = LV3_ADD_RESULT_WIDTH;

localparam CNT_WIDTH = 8;

//================================================================
//  INNER COMPONENTS
//================================================================
// Interact matrix ptr
wire[PTR_LENGTH-1:0] interactMatrix_RowPtr;
wire[PTR_LENGTH-1:0] interactMatrix_ColPtr;

// SelfEnergy ptr
wire[PTR_LENGTH-1:0] selfEnergyPtr;

// Buffer stage
reg[PARTICLE_LENGTH - 1 :0] individual_buffer[0:LATTICE_LENGTH-1];
reg in_valid_buf;
reg[IDX_WIDTH-1:0] ind_idx_buf;

// DF stage
reg[DATA_WIDTH - 1 :0] self_energy_vec_rf[0:NUM_PARTICLE_TYPE-1];
reg[DATA_WIDTH - 1 :0] interact_matrix_rf[0:NUM_PARTICLE_TYPE-1][0:NUM_PARTICLE_TYPE-1];

reg[DF_ADD1_PIPE_WIDTH - 1: 0] self_energy_DF_ADD1_pipe[0:SE_DF_ADD1_PIPE_DEPTH-1];
reg[DF_ADD1_PIPE_WIDTH - 1: 0] interact_energy_DF_ADD1_pipe[0:IE_DF_ADD1_PIPE_DEPTH-1];
reg in_valid_DF_ADD1_pipe;
reg[IDX_WIDTH -1 :0] ind_idx_DF_ADD1_pipe;
reg[INDIVIDUAL_LENGTH  - 1 :0] individual_vec_DF_ADD1_pipe;

// ADD1 stage
wire[LV1_ADD_RESULT_WIDTH-1:0]      self_energy_add_tree_lv1          [0:LV1_SE_ADDER_NUM -1];
wire[LV2_ADD_RESULT_WIDTH-1:0]      self_energy_add_tree_lv2          [0:LV2_SE_ADDER_NUM -1];

wire[LV1_ADD_RESULT_WIDTH-1:0]      interact_energy_add_tree_lv1      [0:LV1_IE_ADDER_NUM - 1];
wire[LV2_ADD_RESULT_WIDTH-1:0]      interact_energy_add_tree_lv2      [0:LV2_IE_ADDER_NUM - 1];

wire[LV3_ADD_RESULT_WIDTH-1:0]      partial_energy_add_tree_lv3       [0:LV3_ADDER_NUM-1];

reg[PARTIAL_ENERGY_PIPE_WIDTH-1 : 0]     partial_energy_ADD1_ADD2_pipe[0:LV3_ADDER_NUM-1];
reg[INDIVIDUAL_LENGTH        -1 : 0]     individual_vec_ADD1_ADD2_pipe;
reg[IDX_WIDTH-1:0]                       ind_idx_add1_add2_pipe;
reg in_valid_ADD1_ADD2_pipe;

//ADD2 and output stage

reg[CNT_WIDTH -1:0] individual_cnt;

wire wrInteractMatrix_done_flag ;
wire wrSelfEnergy_done_flag;

wire[LV5_ADD_RESULT_WIDTH-1: 0] total_energy_wr;
wire done_flag;
wire wrInteractRight_bound_reach_flag = interactMatrix_ColPtr == NUM_PARTICLE_TYPE-1;
wire wrInteractLower_bound_reach_flag = interactMatrix_RowPtr == NUM_PARTICLE_TYPE-1;


//================================================================
//  GENERATE VARAIBLE
//================================================================
genvar adder_idx;
integer pipe_idx;
integer i,j;

//================================================================
//  MAIN DESIGN
//================================================================
//===============================//
//  BUFFER STAGE                 //
//===============================//
always @(posedge clk_i or negedge rst_n )
begin : IN_VALID_BUF
    if(~rst_n)
    begin
        in_valid_buf <= 1'b0;
        ind_idx_buf  <= 1'b0;
    end
    else
    begin
        in_valid_buf <= in_valid_i;
        ind_idx_buf  <= ind_idx_i;
    end
    // in_valid_buf <= ~rst_n ? 1'b0 : in_valid_i;
    // ind_idx_buf  <= ~rst_n ? 1'b0 : ind_idx_i;
end


always @(posedge clk_i or negedge rst_n)
begin: IND_BUF
    // for(i=0;i<LATTICE_LENGTH;i=i+1)
    // begin
    if(~rst_n)
    begin
        for(i=0;i<LATTICE_LENGTH;i=i+1)
        begin
            individual_buffer[i] <= 'd0;
        end
    end
    else
    begin
        for(i=0;i<LATTICE_LENGTH;i=i+1)
        begin
            individual_buffer[i] <= in_valid_i ? individual_vec_i[INDIVIDUAL_LENGTH-1 - PARTICLE_LENGTH*i -: PARTICLE_LENGTH] : 'd0;
        end
    end
    // end
end

//==============================//
//  Data Fetch(DF) stage        //
//==============================//
always @(posedge clk_i or negedge rst_n)
begin: SELF_ENERGY_VEC_RF
    // for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
    // begin
    if(~rst_n)
    begin
        for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
        begin
            self_energy_vec_rf[i] <= 'd0;
        end
    end
    else if(wrSelfEnergyValid_i)
    begin
        for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
        begin
            self_energy_vec_rf[selfEnergyPtr] <= self_energy_i;
        end
    end
    else
    begin
        for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
        begin
            self_energy_vec_rf[i] <= self_energy_vec_rf[i];
        end
    end
    // end
end

always @(posedge clk_i or negedge rst_n)
begin: INTERACT_MATRIX_RF
    // for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
    // for(j=0;j<NUM_PARTICLE_TYPE;j=j+1)
    // begin
    if(~rst_n)
    begin
        for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
        begin
            for(j=0;j<NUM_PARTICLE_TYPE;j=j+1)
            begin
                interact_matrix_rf[i][j] <= 'd0;
            end
        end
    end
    else if(wrInteractEnergyValid_i)
    begin
        interact_matrix_rf[interactMatrix_RowPtr][interactMatrix_ColPtr] <= interact_energy_i;
    end
    else
    begin
        for(i=0;i<NUM_PARTICLE_TYPE;i=i+1)
        begin
            for(j=0;j<NUM_PARTICLE_TYPE;j=j+1)
            begin
                interact_matrix_rf[i][j] <= interact_matrix_rf[i][j];
            end
        end
    end
    // end
end

//=====================//
//  DF/ADD1            //
//=====================//

always @(posedge clk_i or negedge rst_n)
begin: SELF_ENERGY_DF_ADD1_PIPE
    // for(i = 0; i < LATTICE_LENGTH ; i = i + 1)
    if(~rst_n)
    begin
        for(i = 0; i < LATTICE_LENGTH ; i = i + 1)
        begin
            self_energy_DF_ADD1_pipe[i] <= 'd0;
        end
    end
    else
    begin
        for(i = 0; i < LATTICE_LENGTH ; i = i + 1)
        begin
            self_energy_DF_ADD1_pipe[i] <= self_energy_vec_rf[individual_buffer[i]];
        end
    end
end

always @(posedge clk_i or negedge rst_n)
begin: INTERACT_ENERGY_DF_ADD1_PIPE
    // for(i=0;i<LATTICE_LENGTH-1;i=i+1)
    if(~rst_n)
    begin
        for(i=0;i<LATTICE_LENGTH-1;i=i+1)
        begin
            interact_energy_DF_ADD1_pipe[i] <= 'd0;
        end
    end
    else
    begin
        for(i=0;i<LATTICE_LENGTH-1;i=i+1)
        begin
            interact_energy_DF_ADD1_pipe[i] <= (interact_matrix_rf[individual_buffer[i]][individual_buffer[i+1]] << 1);
        end
    end

end

always @(posedge clk_i or negedge rst_n)
begin: INDIVIDUAL_VEC_DF_ADD1_PIPE
    // for(i=0;i<LATTICE_LENGTH;i=i+1)
    // begin
    if(~rst_n)
    begin
        individual_vec_DF_ADD1_pipe <= 'd0;
    end
    else
    begin
        for(i=0;i<LATTICE_LENGTH;i=i+1)
        begin
            individual_vec_DF_ADD1_pipe[INDIVIDUAL_LENGTH-1 - PARTICLE_LENGTH*i -: PARTICLE_LENGTH] <= individual_buffer[i];
        end
    end
    // end
end



always @(posedge clk_i or negedge rst_n )
begin: IN_VALID_DF_ADD1_PIPE
    if(~rst_n)
    begin
        in_valid_DF_ADD1_pipe<= 1'b0;
        ind_idx_DF_ADD1_pipe <= 1'b0;
    end
    else
    begin
        in_valid_DF_ADD1_pipe<= in_valid_buf;
        ind_idx_DF_ADD1_pipe <= ind_idx_buf;
    end

    // in_valid_DF_ADD1_pipe      <= ~rst_n ? 1'b0 : in_valid_buf;
    // ind_idx_DF_ADD1_pipe       <= ~rst_n ? 1'b0 : ind_idx_buf;
end

//=======================//
//  ADD1 stage           //
//=======================//
//lv1.
generate
    for(adder_idx =0; adder_idx < LV1_SE_ADDER_NUM-1; adder_idx = adder_idx +1)
    begin: LV1_SE_adder_Tree1
        assign self_energy_add_tree_lv1[adder_idx] = (self_energy_DF_ADD1_pipe[adder_idx*2] + self_energy_DF_ADD1_pipe[adder_idx*2+ 1]);
    end
    assign self_energy_add_tree_lv1[LV1_SE_ADDER_NUM-1] = {1'b0,self_energy_DF_ADD1_pipe[LATTICE_LENGTH-1]};

    for(adder_idx =0; adder_idx < LV1_IE_ADDER_NUM; adder_idx = adder_idx +1)
    begin: LV1_IE_adder_Tree1
        assign interact_energy_add_tree_lv1[adder_idx] = (interact_energy_DF_ADD1_pipe[adder_idx*2] + interact_energy_DF_ADD1_pipe[adder_idx*2 + 1]);
    end
endgenerate

//lv2
generate
    for(adder_idx =0; adder_idx < LV2_SE_ADDER_NUM; adder_idx = adder_idx +1)
    begin: LV2_SE_adder_Tree2
        if(adder_idx == LV2_SE_ADDER_NUM-1)
        begin
            assign self_energy_add_tree_lv2[adder_idx] = (self_energy_add_tree_lv1[adder_idx*2] + {1'b0,self_energy_DF_ADD1_pipe[LATTICE_LENGTH-1]} );
        end
        else
        begin
            assign self_energy_add_tree_lv2[adder_idx] = (self_energy_add_tree_lv1[adder_idx*2] + self_energy_add_tree_lv1[adder_idx*2+1]);
        end
    end

    for(adder_idx =0; adder_idx < LV2_IE_ADDER_NUM; adder_idx = adder_idx +1)
    begin: LV2_IE_adder_Tree2
        if(adder_idx == 0)
        begin
            assign interact_energy_add_tree_lv2[0] = {1'b0,interact_energy_add_tree_lv1[0]} ;
        end
        else
        begin
            assign interact_energy_add_tree_lv2[adder_idx] = interact_energy_add_tree_lv1[adder_idx*2-1] + interact_energy_add_tree_lv1[adder_idx*2];
        end
    end
endgenerate

//lv3
assign partial_energy_add_tree_lv3[0] = self_energy_add_tree_lv2[0]     + self_energy_add_tree_lv2[1];
assign partial_energy_add_tree_lv3[1] = self_energy_add_tree_lv2[2]     + interact_energy_add_tree_lv2[0];
assign partial_energy_add_tree_lv3[2] = interact_energy_add_tree_lv2[1] + interact_energy_add_tree_lv2[2];

//=====================//
//  ADD1/ADD2          //
//=====================//

always @(posedge clk_i or negedge rst_n)
begin: ADD1_ADD2_PIPE
    // for(pipe_idx = 0 ; pipe_idx < LV3_ADDER_NUM ; pipe_idx = pipe_idx + 1)
    if(~rst_n)
    begin
        for(pipe_idx = 0 ; pipe_idx < LV3_ADDER_NUM ; pipe_idx = pipe_idx + 1)
        begin
            partial_energy_ADD1_ADD2_pipe[pipe_idx] <= 'd0;
        end
    end
    else
    begin
        for(pipe_idx = 0 ; pipe_idx < LV3_ADDER_NUM ; pipe_idx = pipe_idx + 1)
        begin
            partial_energy_ADD1_ADD2_pipe[pipe_idx] <= partial_energy_add_tree_lv3[pipe_idx];
        end
    end
end

always @(posedge clk_i or negedge rst_n)
begin: IN_VALID_ADD1_ADD2_PIPE
    if(~rst_n)
    begin
        in_valid_ADD1_ADD2_pipe<= 1'd0;
        ind_idx_add1_add2_pipe <= 1'd0;
    end
    else
    begin
        in_valid_ADD1_ADD2_pipe <= in_valid_DF_ADD1_pipe;
        ind_idx_add1_add2_pipe  <= ind_idx_DF_ADD1_pipe;
    end
    // in_valid_ADD1_ADD2_pipe <= ~rst_n ? 1'd0 : in_valid_DF_ADD1_pipe;
    // ind_idx_add1_add2_pipe  <= ~rst_n ? 1'd0 : ind_idx_DF_ADD1_pipe;
end

always @(posedge clk_i or negedge rst_n)
begin: INDIVIDUAL_ADD1_ADD2_PIPE
    if(~rst_n)
    begin
        individual_vec_ADD1_ADD2_pipe <= 'd0;
    end
    else
    begin
        individual_vec_ADD1_ADD2_pipe <= individual_vec_DF_ADD1_pipe;
    end
end


//=====================//
//  ADD2 stage         //
//=====================//

//2 lv Adder tree
assign total_energy_wr = (partial_energy_ADD1_ADD2_pipe[0] + partial_energy_ADD1_ADD2_pipe[1]) + {1'b0,partial_energy_ADD1_ADD2_pipe[2]};


always @(posedge clk_i or negedge rst_n)
begin: INDIVIDUAL_CNT
    if(~rst_n)
    begin
        individual_cnt <= 'd0;
    end
    else if(wrInteractEnergyValid_i || wrSelfEnergyValid_i)
    begin
        if(wrInteractMatrix_done_flag)
        begin
            individual_cnt <= 'd0;
        end
        else if(wrInteractRight_bound_reach_flag)
        begin
            individual_cnt[3:2] <= individual_cnt[3:2] + 'd1;
            individual_cnt[1:0] <= 'd0;
        end
        else
        begin
            individual_cnt <= individual_cnt + 'd1;
        end
    end
    else if(done_ff_o)
    begin
        individual_cnt <= 'd0;
    end
    else if(in_valid_ADD1_ADD2_pipe == 1'b1)
    begin
        individual_cnt <= individual_cnt + 'd1;
    end
    else
    begin
        individual_cnt <= individual_cnt;
    end
end

assign interactMatrix_RowPtr = individual_cnt[3:2];
assign interactMatrix_ColPtr = individual_cnt[1:0];
assign selfEnergyPtr         = individual_cnt[1:0];

assign wrInteractMatrix_done_flag       = (wrInteractRight_bound_reach_flag && wrInteractLower_bound_reach_flag);
assign wrSelfEnergy_done_flag           = (individual_cnt == SELF_ENERGY_VEC_LENGTH-1);
assign done_flag                        = (individual_cnt == POP_SIZE-1);

//====================//
//  OUTPUT stage      //
//====================//
always @(posedge clk_i or negedge rst_n)
begin: TOTAL_ENERGY_O
    if(~rst_n)
    begin
        total_energy_ff_o <= 'd0;
    end
    else
    begin
        total_energy_ff_o <= total_energy_wr;
    end
end


always @(posedge clk_i or negedge rst_n)
begin: INDIVIDUAL_VEC_O
    if(~rst_n)
    begin
        individual_vec_ff_o <= 'd0;
    end
    else
    begin
        individual_vec_ff_o <= individual_vec_ADD1_ADD2_pipe ;
    end
end


always @(posedge clk_i or negedge rst_n)
begin: OUTPUT_INDICATOR_SIGNAL_O
    if(~rst_n)
    begin
        done_ff_o <= 1'b0;
        out_valid_ff_o <= 1'b0;
        ind_wb_idx_ff_o <= 1'b0;
    end
    else
    begin
        done_ff_o <= done_flag;
        out_valid_ff_o <=  in_valid_ADD1_ADD2_pipe;
        ind_wb_idx_ff_o <= ind_idx_add1_add2_pipe;
    end
    // done_ff_o           <= ~rst_n ? 1'b0 : done_flag;
    // out_valid_ff_o      <= ~rst_n ? 1'b0 : in_valid_ADD1_ADD2_pipe;
    // ind_wb_idx_ff_o     <= ~rst_n ? 1'b0 : ind_idx_add1_add2_pipe;
end


endmodule