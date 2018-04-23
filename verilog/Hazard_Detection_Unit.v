// We detect lw hazard b/w current instruction in ID stage and previous instruction in EX stage
// Hazard occurs if prev instr. is lw
module hazard_unit(ID_EX_MemRead, ID_EX_RegRt, IF_ID_RegRs, IF_ID_RegRt, Mux_Select_Stall, PCWrite, IF_ID_Write);

    // Inputs
    input ID_EX_MemRead;
    input [4:0] ID_EX_RegRt, IF_ID_RegRs, IF_ID_RegRt;

    // Outputs: two control signals, which determine if pipeline stalls or continues
    // Mux select which forces control signals for current EX and future MEM_WB stage to 0
    // in case of stall
    output reg PCWrite, IF_ID_Write, Mux_Select_Stall;

    always @( ID_EX_MemRead, ID_EX_RegRt, IF_ID_RegRs, IF_ID_RegRt ) begin
        if (ID_EX_MemRead == 1 && ((ID_EX_RegRt == IF_ID_RegRs) || (ID_EX_RegRt == IF_ID_RegRt))) begin
            Mux_Select_Stall <= 1; PCWrite <= 0; IF_ID_Write <= 0;
        end 
		else begin
			Mux_Select_Stall <= 0; PCWrite <= 1; IF_ID_Write <= 1;
		end
    end

endmodule
