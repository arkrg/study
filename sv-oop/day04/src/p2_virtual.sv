class uvm_driver;
  virtual function void run();
    $display("uvm_driver::run");
  endfunction
endclass

class my_driver extends uvm_driver;
  function void run();
    $display("my_driver::run");
  endfunction
endclass

class env;
  uvm_driver drv;  // env는 부모 타입 핸들만 안다
  function void start();
    drv.run();  // (1)
  endfunction
endclass

module p2_virtual;
  initial begin
    my_driver d = new();
    env       e = new();
    e.drv = d;
    e.start();  // (2)
    d.run();  // (3)
  end
endmodule
