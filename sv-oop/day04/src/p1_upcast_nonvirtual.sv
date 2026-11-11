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

module p1_upcast_nonvirtual;
  initial begin
    Child c = new();
    Base  b;
    b = c;
    b.show();  // (1)
    c.show();  // (2)
  end
endmodule
