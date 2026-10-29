class Packet;
  int addr;
  function new(int addr);
    addr = addr;
  endfunction
endclass

class Packet2;
  int addr;
  function new(int addr);
    this.addr = addr;
  endfunction
endclass

module p4_this;
  initial begin
    Packet  p1 = new(5);
    Packet2 p2 = new(5);
    $display("p1.addr=%0d", p1.addr);
    $display("p2.addr=%0d", p2.addr);
  end
endmodule
