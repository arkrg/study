class Base;
  int x;
  function new(int v);
    x = v;
    $display("Base::new v=%0d", v);
  endfunction
endclass

class Child extends Base;
  int y;
  function new();
    y = 2;
    $display("Child::new");
  endfunction
endclass

module p2_super_new_arg;
  initial begin
    Child c = new();
    $display("x=%0d y=%0d", c.x, c.y);
  end
endmodule
