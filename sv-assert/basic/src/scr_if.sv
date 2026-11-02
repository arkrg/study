interface scr_if (
    input pclk,
    input presetn
);
  logic penable;
  logic psel;

endinterface

interface scr_checker (
    scr_if _if
);
  // PRESETn=0인 사이클에서는
  // PSEL=0이고 PENABLE=0이어야 한다
  // assert property ( @(event) condition );
  assert property (@(posedge _if.pclk) (_if.presetn == 0) |-> ((_if.psel || _if.penable) == 0))
  // else $display("Assertion Failed %d, %d.", _if.psel, _if.penable);
  else
    $display(
        "Failed: sampled psel=%0d penable=%0d / current psel=%0d penable=%0d",
        $sampled(
            _if.psel
        ),
        $sampled(
            _if.penable
        ),
        _if.psel,
        _if.penable
    );
endinterface
