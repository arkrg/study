virtual class uvm_driver_base;
  int id;
  function new();
    id = 7;
  endfunction
  function void show();
    $display("id=%0d", id);
  endfunction
endclass

class my_driver extends uvm_driver_base;
  function new();
    super.new();
  endfunction
endclass

module p1_virtual_class;
  uvm_driver_base u;  // (A)
  my_driver       d;

  initial begin
    u = new();  // (B)
    d = new();  // (C)
    u = d;  // (D)
    u.show();  // (E)
  end
endmodule
