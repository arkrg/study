interface scr_if (
    input pclk,
    input presetn
);
  logic penable;
  logic psel;

endinterface
typedef enum {
  // idle   = 'b00,
  error  = 'b01,
  setup  = 'b10,
  access = 'b11
} states_e;
module tb_sequence ();
  logic pclk, presetn;
  logic penable, psel;
  states_e state;

  initial {pclk, penable, psel} = 0;
  always #5 pclk = ~pclk;
  initial begin
    presetn = 1;
    repeat (10) begin  // 랜덤과 검증가능 분리하기
      @(posedge pclk);
      if (!std::randomize(state)) $error("Randomization Failed");
      {psel, penable} = state;
      $display("%t: %0s state: {psel, penable} = %2b", $time, state.name(), {psel, penable});
    end
    @(posedge pclk);
    $finish;
  end
  scr_if _if (.*);
  scr_checker _if2 (._if(_if));
  assign _if.psel = psel;
  assign _if.penable = penable;

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0);
  end
endmodule
