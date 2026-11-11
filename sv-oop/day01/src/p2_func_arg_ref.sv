class Packet;
  int addr;
endclass

function void f1(Packet p);
  p.addr = 99;
endfunction

function void f2(Packet p);
  p = new();
  p.addr = 77;
endfunction

function void f3(ref Packet p);
  p = new();
  p.addr = 55;
endfunction

module p2_func_arg_ref;
  initial begin
    Packet a;
    a = new();
    a.addr = 10;

    f1(a);
    $display("after f1: a.addr = %0d", a.addr);

    f2(a);
    $display("after f2: a.addr = %0d", a.addr);

    f3(a);
    $display("after f3: a.addr = %0d", a.addr);
  end
endmodule
