class Base;
  int x;
  function new();
    x = 1;
    $display("Base::new");
  endfunction
endclass

class Child extends Base;
  int y;
  function new();
    y = 2;
    $display("Child::new");
  endfunction
endclass

module p1_extends_ctor_order;
  initial begin
    Child c = new();
    $display("x=%0d y=%0d", c.x, c.y);
  end
endmodule
