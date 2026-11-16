virtual class base_driver;
  pure virtual task drive();
  function void report();
    $display("report");
  endfunction
endclass

class apb_driver extends base_driver;
  task drive();
    $display("apb drive");
  endtask
endclass

class spi_driver extends base_driver;
endclass

module p2_pure_virtual;
  base_driver b;
  apb_driver  a;

  initial begin
    a = new();
    b = a;
    b.drive();  // (A)
  end
endmodule
