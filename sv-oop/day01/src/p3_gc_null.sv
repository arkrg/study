class Packet;
  int addr;
endclass

module p3_gc_null;
  initial begin
    Packet a, b;

    a = new();
    a.addr = 10;
    b = a;

    a = null;
    $display("step1: b.addr = %0d", b.addr);

    b = null;
    $display("step2: b is null? %0b", (b == null));
  end
endmodule
