module tb ();
  logic pclk, presetn;
  logic penable, psel;
  initial {pclk, penable, psel} = 0;
  always #5 pclk = ~pclk;

  initial begin
    int i;
    presetn = 1;
    $display("%0t =========== de-assert presetn ==========", $time);
    for (i = 0; i < 4; i++) begin
      {psel, penable} = i;
      $display("%0t psel: %d, peanble: %d", $time, psel, penable);
      @(posedge pclk);
    end
    // @(posedge pclk);
    $display("%0t =========== assert presetn ==========", $time);
    presetn = 0;
    {psel, penable} = 0;
    for (i = 0; i < 4; i++) begin
      {psel, penable} = i;
      $display("%0t psel: %d, peanble: %d", $time, psel, penable);
      @(posedge pclk);
    end
    @(posedge pclk);
    $finish;
  end
  scr_if _if (.*);
  scr_checker _if2 (._if(_if));
  assign _if.psel = psel;
  assign _if.penable = penable;
  // bind scr_if scr_checker u_chk (._if(_if));

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0);
  end
endmodule
