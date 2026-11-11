class Packet;
  int addr;
endclass

module p5_loop_new;
  Packet q1[$], q2[$];

  initial begin
    Packet p;

    // A
    p = new();
    for (int i = 0; i < 3; i++) begin
      p.addr = i;
      q1.push_back(p);
    end

    // B
    for (int i = 0; i < 3; i++) begin
      p = new();
      p.addr = i;
      q2.push_back(p);
    end

    foreach (q1[i]) $display("A: q1[%0d].addr = %0d", i, q1[i].addr);
    foreach (q2[i]) $display("B: q2[%0d].addr = %0d", i, q2[i].addr);
  end
endmodule
