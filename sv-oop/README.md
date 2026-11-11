# SystemVerilog OOP Study

- SystemVerilog OOP를 "왜 그렇게 동작하는가" 중심으로 정리
- 각 개념이 UVM TB 어디에 쓰이는지

## 진행 현황

| Day                    | 주제                                     | 상태 |
| ---------------------- | ---------------------------------------- | ---- |
| [Day 1](day01/note.md) | 핸들과 객체                              | ✅   |
| [Day 2](day02/note.md) | 복사, static, this, 접근 제어            | ✅   |
| [Day 3](day03/note.md) | 상속과 생성자 체인                       | ✅   |
| [Day 4](day04/note.md) | virtual, 다형성, $cast                   | ✅   |
| [Day 5](day05/note.md) | virtual class, 상속 vs 합성              | ✅   |
| [Day 6](day06/note.md) | mailbox, event, 콜백, virtual interface  | ✅   |
| [Day 7](day07/note.md) | parameterized class, typedef, covergroup | ✅   |

## tree

.
├── day0[1-7]
│   ├── Makefile
│   ├── note.md
│   └── src
│   ├── p1_\*.sv
│   ├── p2_\*.sv
│   ├── p3_\*.sv
│   ├── p4_\*.sv
│   └── p5_\*.sv

## Makefile 실행방법

```shell
cd day04          # 예시로 day01,
make PN = p1 run  # src/p1_*.sv 파일이 실행됨
```
