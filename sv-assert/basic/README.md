2026-11-02

- Concurrent Assertion
- SystemVerilog Region
- $sampled()
- Vacuous Pass
- [ ] Assertion Coverage

## concurrent assert 기본

매 클럭 에지마다 조건이 참인지 검사한다는 형태

```verilog
// event가 발생할때마다 condition이 항상 참이어야한다
assert property ((@ event) condition);

// 거짓인 경우 else문을 추가할 수 있다
// 세미콜론 위치는 else의 끝에 붙는다
assert property ((@ event) condition)
else ...; // 
```

### |->과 |=> 쓰임, Vacuous Pass

선행조건(antecedent) a가 참일 때 후행조건(consequent) b를 평가할 수 있다

- a |-> b : a가 참(인 cycle에서 평가함)이면  b도 참이다.
- a |=> b : a이가 참이면 다음 클럭에 b가 참이다 (a |-> b ##1과 동일한 구문)
이때 선행조건이 참일때만 평가한다
선행조건이 항상 거짓이면 assert는 걸리지 않으며 이런 경우를 vacuous pass라고 한다

```verilog
assert property ((@ posedge clk) !(a && b); // --1 
assert property ((@ posedge clk) a |-> !b); // --2
```

둘 다 a와 b는 동시에 참이지 않는다는 평가인 것 같지만
1은 a, b 값에 상관없이 매 클럭 평가되지만 2는 a가 참일때만 평가한다는 차이가 있다

|ab| !(a&&b) | a \-> !b|
|--|--|--|
| x0 | !0 평가 -> pass | a가 거짓 -> vacuous pass |
| x1 | !x 평가 -> fail | 위와 동일vacuous pass  |
| 1x | 위와 동일 fail  | consequent가 거짓 -> fail |
| 10 | !0 평가 -> pass  | pass |

### 예시문제

presetn이assert 되었을 때 psel과 penable은 0이다 *실제 apb 프로토콜 제한사항은아니다

```verilog
assert property ((@posedge pclk) (presetn == 0) |-> ((psel || penable) == 0));

```

## 추가

### 평가시점

클럭 직전의 값을 평가한다고까지는 기억해두기

### SystemVerilog Region [출처](<https://wikidocs.net/287555>)

|영역|실행주체|실행시점|핵심역할|
|--|--|--|--|
|Preponed| 시뮬레이터 | 타임 슬롯 시작| 테이터 샘플링: 값이 변하기 전 고정 |
|Active| DUT(RTL) | 설계 로직 연산 | 로직 평가: 조합논리 연산, NBA 우항 계산 |
|Inactive| TB | #0지연 발생시 | 순서제어: zero-delay로써 실행순서를 지연시킴 |
|NBA | DUT(RTL) | 설계로직 반영 | NBA 우항 값을 좌항으로 반영 |
|Observed| Assertion | 설계 동작 완료 | 검증 평가: 샘플링 된 값 평가 |
|Re-Active| TB | 검증 로직 처리| 결과처리: Assertion 실패로그 출력 및 TB 코드 실행 |
|Postponed| 시뮬레이터 | 타임슬롯 종료 | 로그출력 |

### $sampled()

평가시점의 값을 찍어준다

Assertion은 preponed 영역 값을 샘플하고, 그 값이 규칙을 어겼는지 평가는 Observed 영역에서 진행한다
흔히쓰는 $display는 Re-active 영역에서 값을 보여주므로 #0 딜레이 이후 값을 보여준다(클럭 에지 다음)
따라서 아직 평가되지 않은 값이므로,  assertion이 어떤 값으로 어겼는지 확인하고 싶다면 $sampled() 사용하기
