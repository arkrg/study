class uvm_driver;
  virtual function void run();
    $display("uvm_driver::run");
  endfunction
endclass

class my_driver extends uvm_driver;
  int err_count = 7;
endclass

module p4_downcast;
  initial begin
    my_driver  d = new();
    my_driver  d2;
    uvm_driver u;

    u  = d;
    d2 = u;  // (A)
  end
endmodule
