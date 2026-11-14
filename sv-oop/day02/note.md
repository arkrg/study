# Copy / Access

- Shallow Copy
- Deep Copy
- Static Variable
- This
- local / protected / public

```shall
b = a;                  b = new a; (shallow)              deep copy
a ──┐                   a ──► [Packet1]──┐               a ──► [Packet1]──► [Header1]
    ├─► [Packet]        b ──► [Packet2]──┴─► [Header]    b ──► [Packet2]──► [Header2]
b ──┘                   (Header 공유)                    (전부 분리)

```

## Shallow Copy

```verilog
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

module tb;
  initial begin
    Packet a, b;
    a = new();
    a.addr = 10;
    a.hdr.id = 1;

    b = new a;        // shallow copy
    b.addr = 20;
    b.hdr.id = 2;

    $display("a.addr=%0d, a.hdr.id=%0d", a.addr, a.hdr.id);
    $display("b.addr=%0d, b.hdr.id=%0d", b.addr, b.hdr.id);
    $display("a.hdr == b.hdr ? %0b", (a.hdr == b.hdr));
  end
endmodule
```

a는 Packet 타입 객체를 생성하여 할당 받고, Packet의 생성자 new()가 실행되며 hdr 객체도 내부에 있음
b는 new로 Packet 타입 객체를 생성하여 할당 받지만 new() 실행은 없기 때문에 hdr 객체가 새로 생성되지 않음. (a.hdr의 핸들을 복사받는다)

```

b = new a; 직후

a ──► [Packet1 addr=10, hdr]
                         ├──────► [Header id=1]
b ──► [Packet2 addr=10, hdr]

b.addr = 20;     → Packet2만 바뀜
b.hdr.id = 2;    → 공유된 Header가 바뀜 → a.hdr.id도 2
```

> [!NOTE] new(), new; 차이
> new()는 new() 코드 실행하고 객체 할당 new는 객체 할당만 하고 코드실행 없음

## Deep Copy

새 객체를 생성해서 넘겨주기
./src/p2_deep_copy.sv
p.hdr = this.hdr.copy(); 대신 p.hdr = this.hdr;라고 쓰면 결과가 어떻게 달라지나?

```shall
a = new();                  a.copy()                          hdr.copy()
──────────────────────────────────────────────────────────────────────────────────────
a ──► [Packet1]            p ──► [Packet2]──┐
       hdr ────► [Header1]      hdr ────► [Header2]
       add                      addr = this.addr
                                hdr = this.hdr.copy() ──────► h ──► [Header3,id = this.id]

```

## Static 변수

생성되는 객체가 모두 공유할 수 있는 변수 위 예제에서도 addr은 객체마다 새로 생기고 한 객체에서 값을 바꾼다고 다른 객체의 같은 이름 변수가 영향받진 않음 `static`은 시뮬레이션 실행될 때 한번만 메모리에 잡힌다
객체가 없어도 `클래스::이름`으로 접근할 수 있다

```shall
        Packet 클래스
        ┌─────────────────────┐
        │ static count = 3    │ ← 클래스에 1개 (객체 수와 무관)
        └─────────────────────┘
              ▲     ▲     ▲
              │     │     │   (모든 객체가 같은 count를 봄)
a ──► [id=1]──┘     │     │
b ──► [id=2]────────┘     │
c ──► [id=3]──────────────┘
      ↑
      id는 객체마다 각자 1개씩
```

## This

this = 지금 이 메서드를 실행 중인 객체 자신을 가리키는 핸들

## 접근 제한 키워드: local / protected / public

- local: 현재 구역에서만(나만)
- protected: 나와 상속객체
- public: 공개

A.loc
A.prot
이렇게 접근하는게 안되니까 loc, prot에 접근 할 수 있는 메소드를 따로 클래스 안에 만들어둔다
