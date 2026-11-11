class uvm_driver;
  virtual function void run();
    $display("uvm_driver::run");
  endfunction
endclass

class my_driver extends uvm_driver;
  int err_count = 7;

  function void run();
    $display("my_driver::run");
  endfunction

  function void report();
    $display("err_count=%0d", err_count);
  endfunction
endclass

module p3_child_member;
  initial begin
    my_driver  d = new();
    uvm_driver u;
    u = d;
    u.run();  // (A)
    d.report();  // (B)
    u.report();  // (C)
    $display("%0d", u.err_count);  // (D)
  end
endmodule
