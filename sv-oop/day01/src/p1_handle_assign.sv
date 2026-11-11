class Packet;
  int addr;
endclass

module p1_handle_assign;
  initial begin
    Packet a, b;

    a = new();
    a.addr = 10;

    b = a;
    b.addr = 20;

    $display("a.addr = %0d", a.addr);
    $display("b.addr = %0d", b.addr);
  end
endmodule
