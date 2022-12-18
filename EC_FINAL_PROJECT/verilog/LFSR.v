module LSFR#(
           parameter S_WIDTH   = 8, //INT8 ,
           parameter RANDOM_SEED = {S_WIDTH{1'b0}}
       )
       (
           input clk,
           input rst_n,
           //1: 0~255 , 2:0 ~ 3, 3: 1~40
           input in_valid,
           output reg [S_WIDTH-1:0]   random_num_ff_o
       );
//integer
integer i;
//reg_w
reg [S_WIDTH-1:0] random_num_ff_temp;
//reg
reg [S_WIDTH-1:0] random_num_ff_reg;

//-------FSM--------
reg current_state,next_state;
//next_state
always @(*) begin
    case (current_state)
        0 : next_state = in_valid ? 1 : 0;
        1 : next_state = current_state;
        default : next_state = 0;
    endcase
end

//current_state
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        current_state <= 0;
    end
    else begin
        current_state <= next_state;
    end
end

//------main-------
// Uses x^8 + x^6 + x^5 + x^4 + 1
//random_num_ff_temp
always @(*) begin
    for (i = 0; i < S_WIDTH; i=i+1) begin
        if(in_valid && !current_state) begin
            if(i==3 || i==4 || i==5) begin
                random_num_ff_temp[i-1] = RANDOM_SEED[i] ^ RANDOM_SEED[0];
            end
            else if(i == 0) begin
                random_num_ff_temp[S_WIDTH-1] = RANDOM_SEED[0];
            end
            else begin
                random_num_ff_temp[i-1] = RANDOM_SEED[i];
            end
        end
        else if(current_state) begin
            if(i==3 || i==4 || i==5) begin
                random_num_ff_temp[i-1] = random_num_ff_reg[i] ^ random_num_ff_reg[0];
            end
            else if(i == 0) begin
                random_num_ff_temp[S_WIDTH-1] = random_num_ff_reg[0];
            end
            else begin
                random_num_ff_temp[i-1] = random_num_ff_reg[i];
            end
        end
        else begin
            random_num_ff_temp = 0;
        end
    end
end

//reg
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        random_num_ff_reg <= 0;
    end else begin
        random_num_ff_reg <= random_num_ff_temp;
    end
end

//Outputs
always @(*) begin
    random_num_ff_o = random_num_ff_reg[S_WIDTH-1:0];
end


endmodule
