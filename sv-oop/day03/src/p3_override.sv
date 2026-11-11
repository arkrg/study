class Base;
  function void show();
    $display("Base::show");
  endfunction
endclass

class Child extends Base;
  function void show();
    $display("Child::show");
  endfunction
endclass

module p3_override;
  initial begin
    Child c = new();
    c.show();
  end
endmodule
