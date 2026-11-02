interface scr_checker (
    scr_if _if
);
  // // sequence는 패턴 정의, 평가적 의미는 없다
  // |-> |+> 사용못해
  // sequence s_rst_assert; _if.presetn == 0; endsequence
  // sequence s_reset; _if.penable == 0 && _if.psel == 0; endsequence
  // property p_exam;
  //   @(posedge _if.pclk) (s_rst_assert |-> s_reset);
  // endproperty
  // // sequence 단독으로 property에 넣을 때
  // assert property (@(posedge _if.pclk) s_rst_assert);
  // //sequence를 사용해 조건식 만들기
  // assert property (@(posedge _if.pclk) s_rst_assert |-> s_reset);
  // //property 따로 적어서 assert 시키기
  // assert property (p_exam)
  // else $display("Failed: sampled psel=%0d penable=%0d", $sampled(_if.psel), $sampled(_if.penable),);
  // penable만 뜨는 경우도 잡기


  logic [1:0] psel_penable;
  assign psel_penable = {_if.psel, _if.penable};

  sequence s_idle; psel_penable == 2'b00; endsequence
  sequence s_setup; psel_penable == 2'b10; endsequence
  sequence s_access; psel_penable == 2'b11; endsequence

  property p_penable_requires_psel;
    @(posedge _if.pclk) psel_penable == 2'b01;
  endproperty
  property p_setup_then_access;
    @(posedge _if.pclk) s_setup |=> s_access;
  endproperty
  property p_access_after_setup;
    @(posedge _if.pclk) $rose(
        _if.penable
    ) |-> $past(
        _if.psel
    ) == 1;
  endproperty
  assert property (p_access_after_setup)
  else $display("Failed: Access afters Setup");

  assert property (p_setup_then_access)
  else $display("Failed: Setup thens Access");
  assert property (p_penable_requires_psel)
  else $display("Failed: Penable Asserted while Psel=0");
  // else $display("Failed: Setup thens Access");

  // property p_setup_after_idle;
  //   //@(posedge _if.pclk) s_setup_access |-> ; 선행조건이 틀려서 놓치는 게 없게
  //   @(posedge _if.pclk) $rose(
  //       _if.psel
  //   ) -> $past(
  //       _if.psel
  //   ) == 1;
  // endproperty
  //


endinterface
