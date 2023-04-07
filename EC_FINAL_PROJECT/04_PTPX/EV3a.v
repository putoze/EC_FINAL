`include "fitness_eval.v"
`include "LFSR.v"
module EV3a#(
           parameter INT8_LENGTH       = 8,
           parameter ENERGY_LENGTH     = 4,
           parameter PARTICLE_LENGTH   = 2,
           parameter LATTICE_LENGTH    = 11,
           parameter INDIVIDUAL_LENGTH = PARTICLE_LENGTH*LATTICE_LENGTH,
           parameter IND_FIT_LENGTH    = 10,
           parameter NUM_PARTICLE_TYPE = 3,
           parameter POP_SIZE          = 40,
           parameter NUM_GENERATIONS   = 50,
           parameter CROSSFRACTION     = {INT8_LENGTH{1'b0}}
       )
       (
           //global
           clk,    // Clock
           rst_n,  // Asynchronous reset active low
           //energy
           self_energy_in,
           interact_energy_in,
           //data
           Mutate_rate_in,
           ind_state_in,
           ind_fit_in,
           //valid
           in_valid_ind,
           in_valid_self,
           in_valid_interact,
           //output
           Min_fit_o,
           out_valid,
           Best_ind_state_o,
           Best_ind_mut_o
       );
//input
input  clk,rst_n,in_valid_ind,in_valid_self,in_valid_interact;
input  [ENERGY_LENGTH-1:0] self_energy_in;
input  [ENERGY_LENGTH-1:0] interact_energy_in;
input  [INT8_LENGTH-1:0] Mutate_rate_in;
input  [INDIVIDUAL_LENGTH-1:0] ind_state_in;
input  [IND_FIT_LENGTH-1:0] ind_fit_in;
//output
output reg [IND_FIT_LENGTH-1:0] Min_fit_o;
output reg [INDIVIDUAL_LENGTH-1:0] Best_ind_state_o;
output reg [INT8_LENGTH-1:0] Best_ind_mut_o;
output reg out_valid;

// ====== integer ======
integer i ;
genvar idx_i,idx_j; 
localparam INTERACT_LENGTH = NUM_PARTICLE_TYPE*NUM_PARTICLE_TYPE;
localparam IDX_WIDTH = 8;
localparam IND_REG_LENGTH  = INT8_LENGTH+IND_FIT_LENGTH+INDIVIDUAL_LENGTH;

//local param
localparam IDLE                 = 3'b000;
localparam CONDUCT_TOUR         = 3'b001;
localparam CRX_MU_EF            = 3'b010;
localparam TRUNCATE_POP         = 3'b011;
localparam DONE                 = 3'b100;
localparam COPY_POP             = 3'b101;

// ====== reg ======
reg [IDX_WIDTH-1:0] global_counter;
reg [5:0] generation_counter;
reg [2:0] current_state,next_state;
reg [2:0] currentState_CRX,currentState_MU,currentState_EF;
// ====== mem ======
//{Mutate_rate_in,ind_fit_in,ind_state_in}
reg [IND_REG_LENGTH-1:0] pop_rf [0:POP_SIZE-1];
reg [IND_REG_LENGTH-1:0] pop_offspring_rf [0:POP_SIZE-1];

//====== module inout ======
//------ random_number ------
//input
wire random_start = global_counter[3];
//output
wire [INT8_LENGTH-1:0] random_num_vec_o [0:LATTICE_LENGTH-1];
//------ evaluate_fitness ------
//input
reg  [ENERGY_LENGTH-1:0] self_energy_r,interact_energy_r;
wire [INDIVIDUAL_LENGTH-1:0] OffState_EF;
reg  in_valid_self_r,in_valid_interact_r;
wire in_valid_EF = currentState_MU == CRX_MU_EF;
wire [IDX_WIDTH-1:0] wbidx_EF;
//output
wire out_valid_ff_o;
wire done_ff_o;
wire [INDIVIDUAL_LENGTH-1:0] individual_vec_ff_o;
wire [IDX_WIDTH-1:0] ind_wb_idx_ff_o;
wire [IND_FIT_LENGTH-1:0] total_energy_ff_o;

//====== RF =======
wire pipeline_start = current_state[1:0] != 'd0;
//DF
reg  [IDX_WIDTH-1:0] random_idx_1_r;
reg  [IDX_WIDTH-1:0] random_idx_2_r;
reg  [IDX_WIDTH-1:0] idx_ptr_1,idx_ptr_2;
wire [IND_REG_LENGTH-1:0] PopInd_DF  = pop_rf[idx_ptr_1];
wire [IND_REG_LENGTH-1:0] OffInd1_DF = pop_offspring_rf[idx_ptr_1];
wire [IND_REG_LENGTH-1:0] OffInd2_DF = pop_offspring_rf[idx_ptr_2];
//DF_CRX_PIPE
reg  [IND_REG_LENGTH-1:0] PopInd_DF_d,OffInd1_DF_d,OffInd2_DF_d;
reg  [IDX_WIDTH-1:0] idx_ptr_2_d,idx_ptr_1_d;
//DF_flag
wire start_flag = global_counter == 'd0 ;
wire idx1_eq_idx2 = random_idx_1_r == random_idx_2_r;
wire idx1_eq_39 = idx_ptr_1_d == POP_SIZE-1;
wire idx2_eq_39 = idx_ptr_2_d == POP_SIZE-1;
//CRX input
wire [IND_FIT_LENGTH-1:0] popFit_CRX  = PopInd_DF_d [31:22];
wire [IND_FIT_LENGTH-1:0] offFit2_CRX = OffInd2_DF_d[31:22];
//CRX_flag
wire popFit_lr_offFit = popFit_CRX < offFit2_CRX;
wire CrossOrTourSel = currentState_CRX == CRX_MU_EF;
wire [LATTICE_LENGTH-1:0] CrossStateSel;
wire rn_gt_CROSSFRACTION = random_num_vec_o[0] > CROSSFRACTION;
//CRX
wire [INDIVIDUAL_LENGTH-1:0] Pop_state_CRX  = PopInd_DF_d [21:0];
wire [INDIVIDUAL_LENGTH-1:0] Off_state1_CRX = OffInd1_DF_d [21:0];
wire [INDIVIDUAL_LENGTH-1:0] Off_state2_CRX = OffInd2_DF_d [21:0];
wire [INDIVIDUAL_LENGTH-1:0] TourStateCRX = popFit_lr_offFit ? Pop_state_CRX : Off_state2_CRX;
wire [INDIVIDUAL_LENGTH-1:0] CrossStateCRX;
wire [INDIVIDUAL_LENGTH-1:0] newStateCRX = CrossOrTourSel ? CrossStateCRX : TourStateCRX;
wire [INDIVIDUAL_LENGTH-1:0] NewCrossStateCRX = rn_gt_CROSSFRACTION ? CrossStateCRX : Off_state2_CRX;
wire [INT8_LENGTH-1:0] offMutateRate_CRX = popFit_lr_offFit ? PopInd_DF_d[39:32] : OffInd2_DF[39:32];
wire [IND_FIT_LENGTH-1:0] offFit_CRX = popFit_lr_offFit ? popFit_CRX : offFit2_CRX;
//CRX_MU_PIPE
reg  [INDIVIDUAL_LENGTH-1:0] newStateCRX_d;
reg  [INT8_LENGTH-1:0] offMutateRate_CRX_d;
reg  [IND_FIT_LENGTH-1:0] offFit_CRX_d;
reg  [IDX_WIDTH-1:0] idx_ptr_2_d2;

//MU
wire [INDIVIDUAL_LENGTH-1:0] OffState_MU = newStateCRX_d;
wire [INT8_LENGTH-1:0] OffMutateRate_MU = offMutateRate_CRX_d;
reg  [PARTICLE_LENGTH-1:0]random_state_r[0:LATTICE_LENGTH-1];
wire [INDIVIDUAL_LENGTH-1:0] newState_MU;
wire [INT8_LENGTH-1:0] Tour_wb_idx_MU = idx_ptr_2_d2;
wire [IND_FIT_LENGTH-1:0] OffFit_MU = offFit_CRX_d;
//MU_flag
wire [LATTICE_LENGTH-1:0] rn_gt_MU;

//TRUN
reg  stall;
wire [IND_REG_LENGTH-1:0] pop_combine_w[0:2*POP_SIZE-1];
wire [IND_REG_LENGTH-1:0] compare_result_1 [0:2*POP_SIZE-1];
wire [IND_REG_LENGTH-1:0] compare_result_2 [0:2*POP_SIZE-1];
//TRUN_flag
wire truncate_valid = current_state == TRUNCATE_POP && !stall;

//Testing wire
wire [INT8_LENGTH-1:0] Mutate_rate[0:POP_SIZE-1];
wire [PARTICLE_LENGTH-1:0] ind_state[0:POP_SIZE-1][0:LATTICE_LENGTH-1];
wire [IND_FIT_LENGTH-1:0] ind_fit[0:POP_SIZE-1];

assign OffState_EF = newState_MU;
assign wbidx_EF = idx_ptr_2_d2;

generate
    for(idx_i=0;idx_i<POP_SIZE;idx_i=idx_i+1) begin
        assign Mutate_rate[idx_i] = pop_offspring_rf[idx_i][39:32];
        assign ind_fit[idx_i] = pop_offspring_rf[idx_i][31:22];
    end
endgenerate

generate
    for(idx_i=0;idx_i<POP_SIZE;idx_i=idx_i+1) begin
        for (idx_j=0;idx_j<LATTICE_LENGTH;idx_j=idx_j+1) begin
            assign ind_state[idx_i][idx_j] = pop_offspring_rf[idx_i][PARTICLE_LENGTH*idx_j +: PARTICLE_LENGTH];
        end
    end
endgenerate

//FSM_flag
wire pipeline_done = global_counter == POP_SIZE - 1;
wire generation_done = generation_counter == 'd0; 
// ==========================
// ------- FSM --------------
// ==========================
//current_state
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

//next_state
always @(*) begin 
    case (current_state)
        IDLE                : next_state = pipeline_done ? CONDUCT_TOUR : IDLE;
        CONDUCT_TOUR        : next_state = pipeline_done ? CRX_MU_EF    : CONDUCT_TOUR;
        CRX_MU_EF           : next_state = pipeline_done ? TRUNCATE_POP : CRX_MU_EF;
        TRUNCATE_POP        : next_state = pipeline_done ? generation_done ? DONE : COPY_POP : TRUNCATE_POP;
        DONE                : next_state = IDLE;
        COPY_POP            : next_state = CONDUCT_TOUR;
        default : next_state = IDLE;
    endcase
end

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        {currentState_CRX,currentState_MU,currentState_EF} <= 'd0;
    end else begin
        {currentState_CRX,currentState_MU,currentState_EF} <= {current_state,currentState_CRX,currentState_MU};
    end
end

// ==========================
// ------- Global -----------
// ==========================

//generation_counter
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        generation_counter <= NUM_GENERATIONS - 1;
    end 
    else if(pipeline_done && current_state == TRUNCATE_POP)begin
        generation_counter <= generation_counter - 'd1;
    end
    else if(out_valid) begin
        generation_counter <= NUM_GENERATIONS - 1;
    end
end

//global_counter
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        global_counter <= 'd0;
    end 
    else if(pipeline_done || done_ff_o || stall ) begin
        global_counter <= 'd0;
    end
    else if(in_valid_ind || current_state[1:0] != 'd0) begin
        global_counter <= global_counter + 'd1;
    end
end

// ==========================
// ------- RD_DATA ----------
// ==========================

//pop_rf
always @(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin
        for(i=0;i<POP_SIZE;i=i+1) begin
            pop_rf[i] <= 'd0;
        end
    end 
    else if(in_valid_ind) begin
        pop_rf[global_counter[5:0]] <= {Mutate_rate_in,ind_fit_in,ind_state_in};
    end
    else if(truncate_valid)begin
        for (i=0;i<POP_SIZE;i=i+1) begin
            pop_rf [i] <= compare_result_2[i];
        end
    end
end

//pop_offspring_rf
always @(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin
        for(i=0;i<POP_SIZE;i=i+1) begin
            pop_offspring_rf[i] <= 'd0;
        end
    end 
    else if(in_valid_ind) begin
        pop_offspring_rf[global_counter[5:0]] <= {Mutate_rate_in,ind_fit_in,ind_state_in};
    end
    else if(currentState_MU == CONDUCT_TOUR) begin
        pop_offspring_rf[Tour_wb_idx_MU][39:32] <= OffMutateRate_MU;
        pop_offspring_rf[Tour_wb_idx_MU][31:22] <= OffFit_MU;
        pop_offspring_rf[Tour_wb_idx_MU][21:0 ] <= OffState_MU;
    end
    else if(out_valid_ff_o) begin
        pop_offspring_rf[ind_wb_idx_ff_o][31:22] <= total_energy_ff_o;
        pop_offspring_rf[ind_wb_idx_ff_o][21:0 ] <= individual_vec_ff_o;
    end
    else if(truncate_valid)begin
        for (i=0;i<POP_SIZE;i=i+1) begin
            pop_offspring_rf [i] <= compare_result_2[POP_SIZE+i];
        end
    end
    else if(current_state == COPY_POP) begin
        for (i=0;i<POP_SIZE;i=i+1) begin
            pop_offspring_rf [i] <= pop_rf[i];
        end
    end
end

//self_energy_r
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        self_energy_r <= 'd0;
    end 
    else if(in_valid_self) begin
        self_energy_r <= self_energy_in;
    end
    else begin
        self_energy_r <= 'd0;
    end
end

//interact_energy_r
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        interact_energy_r <= 'd0;
    end 
    else if(in_valid_interact) begin
        interact_energy_r <= interact_energy_in;
    end
    else begin
        interact_energy_r <= 'd0;
    end
end

//in_valid_self_r
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        in_valid_self_r <= 0;
    end 
    else if (in_valid_self) begin
        in_valid_self_r <= 1;
    end 
    else begin
        in_valid_self_r <= 0;
    end
end

//in_valid_interact_r
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        in_valid_interact_r <= 0;
    end 
    else if (in_valid_interact) begin
        in_valid_interact_r <= 1;
    end 
    else begin
        in_valid_interact_r <= 0;
    end
end

// ==========================
// ------- RF ---------------
// ==========================
// idx_ptr
always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        {idx_ptr_1_d,idx_ptr_2_d,idx_ptr_2_d2} <= 'd0;
    end else begin
        idx_ptr_2_d  <= idx_ptr_2;
        idx_ptr_2_d2 <= idx_ptr_2_d;
        idx_ptr_1_d  <= idx_ptr_1;
    end
end
//offMutateRate
always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        {offMutateRate_CRX_d} <= 'd0;
    end else begin
        {offMutateRate_CRX_d} <= {offMutateRate_CRX};
    end
end

//====== DF ======

always @(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin
        random_idx_1_r <= 'd0;
        random_idx_2_r <= 'd0;
    end else begin
        random_idx_1_r <= random_num_vec_o[0][5:0] >= (POP_SIZE-1) ? {2'd0,random_num_vec_o[0][5:0]} - 'd24 : {2'd0,random_num_vec_o[0][5:0]};
        random_idx_2_r <= random_num_vec_o[1][5:0] >= (POP_SIZE-1) ? {2'd0,random_num_vec_o[1][5:0]} - 'd24 : {2'd0,random_num_vec_o[1][5:0]};
    end
end

//idx_ptr_1
always @(*) begin 
    if (pipeline_start) begin
        if(start_flag) begin
            idx_ptr_1 = random_idx_1_r;
        end
        else if(idx1_eq_39) begin
            idx_ptr_1 = 'd0;
        end
        else begin
            idx_ptr_1 = idx_ptr_1_d + 'd1;
        end
    end
    else begin
        idx_ptr_1 = 'd0;
    end
end

always @(*) begin 
    if(pipeline_start) begin
        if(start_flag) begin
            idx_ptr_2 = idx1_eq_idx2 ? random_idx_2_r - 'd1 : random_idx_2_r ;
        end
        else if(idx2_eq_39) begin
            idx_ptr_2 = 'd0;
        end
        else begin
            idx_ptr_2 = idx_ptr_2_d + 'd1;
        end
    end
    else begin
        idx_ptr_2 = 'd0;
    end
end

//====== DF_CRX_PIPE ======
always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        {PopInd_DF_d,OffInd1_DF_d,OffInd2_DF_d} <= 0;
    end else begin
        {PopInd_DF_d,OffInd1_DF_d,OffInd2_DF_d} <= {PopInd_DF,OffInd1_DF,OffInd2_DF};
    end
end

// ====== CRX ======
generate 
    for(idx_i=0;idx_i<LATTICE_LENGTH;idx_i=idx_i+1) begin
        assign CrossStateSel[idx_i] = random_num_vec_o[idx_i][INT8_LENGTH-1];
    end
endgenerate

generate
    for(idx_i=0;idx_i<LATTICE_LENGTH;idx_i=idx_i+1) begin
        assign CrossStateCRX[PARTICLE_LENGTH*idx_i +: PARTICLE_LENGTH] = CrossStateSel[idx_i] ? 
        Off_state1_CRX[PARTICLE_LENGTH*idx_i +: PARTICLE_LENGTH] : Off_state2_CRX[PARTICLE_LENGTH*idx_i +: PARTICLE_LENGTH];
    end
endgenerate

// ====== CRX_MU_PIPE ======
always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        newStateCRX_d <= 'd0;
    end else begin
        newStateCRX_d <= newStateCRX;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        offFit_CRX_d <= 'd0;
    end else begin
        offFit_CRX_d <= offFit_CRX;
    end
end

// ====== MU ======
generate
    for (idx_i = 0; idx_i < LATTICE_LENGTH; idx_i=idx_i+1) begin
        assign rn_gt_MU[idx_i] = random_num_vec_o[idx_i] > OffMutateRate_MU ? 1 : 0;
    end
endgenerate

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        for (i = 0; i < LATTICE_LENGTH; i=i+1) begin
            random_state_r[i] <= 'd0;
        end
    end else begin
        for (i = 0; i < LATTICE_LENGTH; i=i+1) begin
            random_state_r[i] <= random_num_vec_o[i][1:0] == 'd3 ? 
            'd3 - random_num_vec_o[i][2:1] : random_num_vec_o[i][1:0];
        end
    end
end

generate
    for(idx_i=0;idx_i<LATTICE_LENGTH;idx_i=idx_i+1) begin
        assign newState_MU[PARTICLE_LENGTH*idx_i +: PARTICLE_LENGTH] = rn_gt_MU[idx_i] ? 
        random_state_r[idx_i] : OffState_MU[PARTICLE_LENGTH*idx_i +: PARTICLE_LENGTH];
    end
endgenerate

// ====== TRUN ======
// stall
always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) begin
        stall <= 0;
    end 
    else if(done_ff_o)begin
        stall <= 0;
    end
    else if(pipeline_done && current_state == CRX_MU_EF) begin
        stall <= 1;
    end
end

// pop_combine_w
generate
    for (idx_i=0;idx_i<POP_SIZE;idx_i=idx_i+1) begin
        assign pop_combine_w[idx_i]          = pop_rf          [idx_i];
        assign pop_combine_w[POP_SIZE+idx_i] = pop_offspring_rf[idx_i];
    end
endgenerate

// ====== Unfolded bubble sort ======

//compare_result_1
generate
    for (idx_i=0;idx_i<(2*POP_SIZE);idx_i=idx_i+2) begin
        assign compare_result_1[idx_i]   = pop_combine_w[idx_i][31:22] < pop_combine_w[idx_i+1][31:22] ? pop_combine_w[idx_i]   : pop_combine_w[idx_i+1];
        assign compare_result_1[idx_i+1] = pop_combine_w[idx_i][31:22] < pop_combine_w[idx_i+1][31:22] ? pop_combine_w[idx_i+1] : pop_combine_w[idx_i  ];
    end
endgenerate

//compare_result_2
generate
    for (idx_i=1;idx_i<(2*POP_SIZE-1);idx_i=idx_i+2) begin
        assign compare_result_2[idx_i]   = compare_result_1[idx_i][31:22] < compare_result_1[idx_i+1][31:22] ? compare_result_1[idx_i]   : compare_result_1[idx_i+1];
        assign compare_result_2[idx_i+1] = compare_result_1[idx_i][31:22] < compare_result_1[idx_i+1][31:22] ? compare_result_1[idx_i+1] : compare_result_1[idx_i  ];
    end
endgenerate

assign compare_result_2[0]  = compare_result_1[0];
assign compare_result_2[79] = compare_result_1[79];

// ==========================
// ------- OUT --------------
// ==========================

//output
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        out_valid <= 0;
    end
    else if(current_state == DONE) begin
        out_valid <= 1;
    end
    else begin
        out_valid <= 0;
    end
end

always @(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        Best_ind_mut_o <= 'd0;
    end
    else if(current_state == DONE) begin
        Best_ind_mut_o <= pop_rf[0][39:32];
    end
    else
    begin
        Best_ind_mut_o <= 'd0;
    end
end

always @(posedge clk or negedge rst_n)
begin
    if(~rst_n)
    begin
        Best_ind_state_o <= 'd0;
    end
    else if(current_state == DONE) begin
        Best_ind_state_o <= pop_rf[0][21:0];
    end
    else
    begin
        Best_ind_state_o <= 'd0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        Min_fit_o <= 'd0;
    end
    else if(current_state == DONE) begin
        Min_fit_o <= pop_rf[0][31:22];
    end 
    else begin
        Min_fit_o <= 'd0;
    end
end

// ==========================
// ------- Module -----------
// ==========================

generate
    for(idx_i=0;idx_i<LATTICE_LENGTH;idx_i=idx_i+1) begin
            LSFR #(
            .S_WIDTH(INT8_LENGTH),
            .RANDOM_SEED(78+idx_i) //87
        ) inst_LSFR (
            .clk             (clk),
            .rst_n           (rst_n),
            .in_valid        (random_start),
            .random_num_ff_o (random_num_vec_o[idx_i])
        );
    end
endgenerate

    fitness_eval #(
            .NUM_PARTICLE_TYPE(NUM_PARTICLE_TYPE),
            .DATA_WIDTH(ENERGY_LENGTH),
            .PARTICLE_LENGTH(PARTICLE_LENGTH),
            .LATTICE_LENGTH(LATTICE_LENGTH),
            .SELF_FIT_LENGTH(IND_FIT_LENGTH),
            .INDIVIDUAL_LENGTH(INDIVIDUAL_LENGTH),
            .POP_SIZE(POP_SIZE),
            .IDX_WIDTH(IDX_WIDTH)
        ) inst_fitness_eval (
            .clk_i                   (clk),
            .rst_n                   (rst_n),
            .self_energy_i           (self_energy_r),
            .interact_energy_i       (interact_energy_r),
            .individual_vec_i        (OffState_EF),
            .wrSelfEnergyValid_i     (in_valid_self_r),
            .wrInteractEnergyValid_i (in_valid_interact_r),
            .in_valid_i              (in_valid_EF),
            .ind_idx_i               (wbidx_EF),
            .out_valid_ff_o          (out_valid_ff_o),
            .done_ff_o               (done_ff_o),
            .individual_vec_ff_o     (individual_vec_ff_o),
            .ind_wb_idx_ff_o         (ind_wb_idx_ff_o),
            .total_energy_ff_o       (total_energy_ff_o)
        );



endmodule
