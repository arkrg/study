# Object and handle

UVM에서 monitor가 만든 item을 scoreboard나 coverage 등 여러 곳이 같은 핸들로 받는다. monitor가 item 하나를 재사용하면 이미 보낸 값을 덮어쓰는 버그가 생기기 때문에 매 트랜잭션마다 create(=new)를 한다.
이 동작의 밑바탕인 핸들과 객체를 실험을 통해 이해하자
눈치껏 쓰고있는 객체와 핸들을 이해하고 UVM 기능과 유기적 관계를 알아보자

- 핸들 대입 b = a
- 함수 인자로 객체 전달하기
- 핸들의 null 상태
-

## Concepts

- 핸들: 객체 위치를 가리키는 값을 담은 변수
- 객체: new()를 실행하여 동적 메모리를 차지함

## 핸들 대입(b=a)

./src/p1_*.sv

```verilog
class Packet;
  int addr;
endclass

module tb;
  initial begin
    Packet a, b;

    a = new();
    a.addr = 10;

    b = a;
    b.addr = 20;

    $display("a.addr = %0d", a.addr);
    $display("b.addr = %0d", b.addr);
    $display("a == b ? %0b", (a == b));
  end
endmodule
```

1. Packet 타입 핸들 a, b가 선언된다(메모리 할당 X 컴파일러가 알수있음)

2. new()로 객체 생성 및 할당. 멤버 접근으로 값 설정
   a ──► [Packet 객체 addr=10]

3. 핸들 b에 3에서 생성된 객체 위치 전달 및 내부 멤버 접근
   a ──┐
   ....├──► [Packet 객체 addr=20]
   b ──┘

> [!NOTE] == 연산자
> 포인터와 다르게 SV OOP의 핸들의 값을 직접 출력하거나 연산을 통해 변경할 수 없다.
> 대신 핸들끼리 값을 비교할 수는 있다. 가리키는 객체가 동일한지 알 수 있음

## 핸들을 인자로 받는 함수

./src/p2_func_arg_ref.sv

```verilog
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

module tb;
// ...
    a.addr = 10;

    f1(a);
    $display("after f1: a.addr = %0d", a.addr);

    f2(a);
    $display("after f2: a.addr = %0d", a.addr);

    f3(a);
    $display("after f3: a.addr = %0d", a.addr);
  end
endmodule
```

1. f1 호출 직후

```
   a ───┐
        ├──► [객체 addr=10] -> 99로 변경
   p ───┘ (a의 복사본)
```

2. f2 호출 직후

```
   a ──────► [객체 addr=99] \(f1 끝나고 a 복사본은 사라짐)
   p(f2) ──► [객체 addr=77] \(a 복사. 새로 생성한 객체를 할당받으며 주소도 바뀐다)
   f2 종료 후에 a는 1.에서 가리킨 객체를 의미하므로 99가 출력된다
```

3. f3 호출 직후
   'ref'는 a를 복사하는게 아니라, a 자체를 p라는 별명으로 쓰라는 의미가 됨

```
   x ──────► [객체 addr=99] \(원래 객체 a가 가리켰던 객체. 접근할 수 있는 핸들이 없어지므로 정리됨)
   a ──────► [객체 addr=55] \(새 객체 생성하여 가리키기)
```

## Garbage collector / null 접근

## 루프 안팎에서 new() 실행하기

```
A:
q1[0] ─┐
q1[1]  ┼──► [객체 addr=2]
q1[2] ─┘

B:
q2[0] ──► [객체 addr=0]
q2[1] ──► [객체 addr=1]
q2[2] ──► [객체 addr=2]
```
