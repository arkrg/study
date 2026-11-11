class Packet;
  int addr;
endclass

module p4_null_access;
  initial begin
    Packet a;

    $display("start");
    a.addr = 5;
    $display("after write");
  end
endmodule
