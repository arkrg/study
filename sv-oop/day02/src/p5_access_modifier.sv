class Base;
  int pub = 1;
  protected int prot = 2;
  local int loc = 3;

  function void show();
    $display("Base.show: %0d %0d %0d", pub, prot, loc);
  endfunction
endclass

class Child extends Base;
  function void child_show();
    $display("Child: %0d", pub);  // (A)
    $display("Child: %0d", prot);  // (B)
    $display("Child: %0d", loc);  // (C)
  endfunction
endclass

module p5_access_modifier;
  initial begin
    Base b = new();
    b.show();
    $display("%0d", b.pub);  // (D)
    $display("%0d", b.prot);  // (E)
    $display("%0d", b.loc);  // (F)
  end
endmodule
