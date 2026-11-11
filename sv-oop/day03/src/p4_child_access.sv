class Base;
  int pub = 1;
  protected int prot = 2;
  local int loc = 3;

  function void show_base();
    $display("%0d %0d %0d", pub, prot, loc);
  endfunction
endclass

class Child extends Base;
  function void show_child();
    $display("%0d", pub);  // (A)
    $display("%0d", prot);  // (B)
    $display("%0d", loc);  // (C)
  endfunction

  function void set_all();
    pub  = 10;  // (D)
    prot = 20;  // (E)
    loc  = 30;  // (F)
  endfunction
endclass

module child_access;
  initial begin
    Child c = new();
    c.show_base();  // (G)
    c.show_child();  // (H)
  end
endmodule
