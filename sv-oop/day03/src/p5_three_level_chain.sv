class A;
  int x;
  function new(int v);
    x = v;
    $display("A::new x=%0d", x);
  endfunction

  function void show();
    $display("A::show x=%0d", x);
  endfunction
endclass

class B extends A;
  int y;
  function new(int v);
    super.new(v + 1);
    y = v;
    $display("B::new y=%0d", y);
  endfunction

  function void show();
    super.show();
    $display("B::show y=%0d", y);
  endfunction
endclass

class C extends B;
  int z;
  function new();
    super.new(10);
    z = 100;
    $display("C::new z=%0d", z);
  endfunction

  function void show();
    super.show();
    $display("C::show z=%0d", z);
  endfunction
endclass

module p5_three_level_chain;
  initial begin
    C c = new();
    c.show();
  end
endmodule
