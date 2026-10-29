class Header;
  int id;
  function Header copy();
    Header h = new();
    h.id = this.id;
    return h;
  endfunction
endclass

class Packet;
  int addr;
  Header hdr;
  function new();
    hdr = new();
  endfunction

  function Packet copy();
    Packet p = new();
    p.addr = this.addr;
    p.hdr  = this.hdr.copy();
    // what if p.hdr = this.hdr; ?
    return p;
  endfunction
endclass

module p2_deep_copy;
  initial begin
    Packet a, b;
    a = new();
    a.addr = 10;
    a.hdr.id = 1;

    b = a.copy();     // deep copy
    b.addr = 20;
    b.hdr.id = 2;

    $display("a.addr=%0d, a.hdr.id=%0d", a.addr, a.hdr.id);
    $display("b.addr=%0d, b.hdr.id=%0d", b.addr, b.hdr.id);
    $display("a.hdr == b.hdr ? %0b", (a.hdr == b.hdr));
  end
endmodule
