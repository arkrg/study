class Header;
  int id;
endclass

class Packet;
  int addr;
  Header hdr;
  function new();
    hdr = new();
  endfunction
endclass

module p1_shallow_copy;
  initial begin
    Packet a, b;
    a        = new();
    a.addr   = 10;
    a.hdr.id = 1;

    b        = new a;  // shallow copy
    b.addr   = 20;
    b.hdr.id = 2;

    $display("a.addr=%0d, a.hdr.id=%0d", a.addr, a.hdr.id);
    $display("b.addr=%0d, b.hdr.id=%0d", b.addr, b.hdr.id);
    $display("a.hdr == b.hdr ? %0b", (a.hdr == b.hdr));
  end
endmodule
