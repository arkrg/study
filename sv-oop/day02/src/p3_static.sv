class Packet;
  static int count = 0;
  int id;
  function new();
    count++;
    id = count;
  endfunction
endclass

module p3_static;
  initial begin
    Packet a, b, c, d;
    a = new();
    b = new();
    c = new();
    $display("a.id=%0d b.id=%0d c.id=%0d", a.id, b.id, c.id);
    $display("count=%0d", Packet::count);

    d = new a;
    $display("d.id=%0d count=%0d", d.id, Packet::count);
  end
endmodule
