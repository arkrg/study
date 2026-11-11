class uvm_driver;
endclass

class my_driver extends uvm_driver;
  int err_count = 7;
endclass

class error_driver extends uvm_driver;
endclass

module p5_cast;
  initial begin
    my_driver    m = new();
    error_driver e = new();
    my_driver    d;
    uvm_driver   u;
    int          ok;

    u  = m;
    ok = $cast(d, u);
    $display("(A) ok=%0d", ok);

    u  = e;
    ok = $cast(d, u);
    $display("(B) ok=%0d", ok);
    $display("(C) d.err_count=%0d", d.err_count);

    $cast(d, u);  // (D)
    $display("(E) 여기까지 옴");
  end
endmodule
