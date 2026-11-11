# Polymorph 다형성

- 부모 타입 핸들은 자식 타입 객체를 가리킬 수 있음
- 가리키는 자식 객체에 따라 같은 메소드를 호출해도 다른 동작이 가능한 특성

!> [!NOTE] UVM 안에서

> factory override로 driver를 error_driver로 바꿔 env를 수정하지 않고도 테스트를 할 수 있음

!> [!NOTE] 지난시간 복습

[Child 핸들, c] ──► [Child 객체]
|....................Child::show() : 자식에서 정의
|....................Base::show() : 부모에서 정의
c.show()는 Child::show()를 실행

## Virtual Method

### 일단 없는 경우를 보자

- Q. up-cast 후 (b = c), b.show()는 어떤걸 실행시킬까?

```shell
[Base 핸들, b] ──► [Child 객체]
                     Child::show() : 자식에서 정의
                     Base::show() : 부모에서 정의

```

- A. Base::show()를 실행시킴

이유: b = c; 단계에서 컴파일러가 검사하는것을 보자
b의 선언타입 핸들로 접근할 수 있는 멤버(Base의 멤버)가 c 선언타입으로 접근 할 수 있는 모든 객체에 전부 있는가?

```shell
                 ----[Child 객체]----
                 | [Child 정의 맴버]|
[Base 핸들, b]──►| [Base 정의 멤버] |
                 --------------------
```

(말이 너무 어려운거같은데, 그림이 더 잘 이해될거같다) b가 찾는건 base 정의 멤버들이 전부 있냐임
(b: 제 식구들 다 있나요 컴: 아직 안오긴 했는데 무조건 다 있습니다 걱정마세요!)
이렇게 컴파일러가 검사한 상태로 실행되는데 b는 기본적으로 base 정의 멤버에만 접근함

### 어라, b 녀석 결국 지거만 쓰네, 다형성이라곤 하나도 없는데요?

그걸 들어주는게 virtual입니다
컴파일 단계로 끝나면 b로 접근할 수 있는게 자기자신 타입으로 끝나버리는데 다시 바꿀 기회가 있음

```shell
|                -------[Child 객체]------------
|                |  [Child 정의 맴버]          |
|                |   * show()(자동으로 virtual)|
| [Base 핸들, b]──► [Base 정의 멤버]           |
|                |   *virtual show()           |
|                -------------------------------
```

컴파일 단계에선 핸들이 실제로 가리키는 객체가 뭔지 몰랐지만 실행하면 실제로 어떤 객체를 가리키는 지 알 수 있게됨
Virtual로 선언된 부모 클래스의 메소드를 실행시키면 Run-time중에 자식에 있는 같은 이름 메소드로 실행시켜줄 수 있음

## 다형성 한계와 $cast()

부모 메소드에 virtual을 붙히면 자식 객체에 있는 같은 이름 메소드를 실행시키는구나,
근데 그럼 자식에만 있는건 접근 못하나?
--> 네
컴파일 단계에서 핸들로 접근할 수 있는 이름들이 정해져서 안돼 다형성으로 해결 불가능한 영역

- $cast(목적지_핸들, 원본_핸들)
  실행 중에 원본 핸들이 실제로 가리키는 객체의 타입을 확인하고, 목적지 핸들에 넣어도 되는 경우에 대입
  (일반 대입 =이 컴파일할 때 선언 타입만 보는 것과 차이남)
- 호출 형태
  function 형태: ok = $cast(d, u); 성공(1), 실패(0) 반환값(int)을 받음
  task 형태: $cast(d, u); 문장으로만 호출 실패하면 런타임 에러

### 언제쓸까 do_copy(uvm_object obj)

부모 타입으로 인자를 정의해서 자식들의 객체를 인자로 받는데까지는 문제 없음
자식들이 알아서 구현해서 쓴다고 해보자

```verilog
virtual Parent::do_copy(uvm_object obj);
//---
Child::do_copy(uvm_object obj); //인자 까지 같아야 virtual 로 실행가능,
                                //uvm_object를 상속받아 만든 my_item을 인자로 받을 수 있다
my_item item = new();           // 여기다가 복사해야지
item.addr = obj.addr;           // 어라 uvm_object 타입 핸들로 addr에 접근해야하네..?
```

$cast()를 사용해서 다시해볼까

```verilog
Child::do_copy(uvm_object obj);
my_item item = new();           // 여기다가 복사해야지
my_item arg_item;                   // 인자로 받은 객체에 접근할 핸들
$cast(arg_item, obj);               // my_item이라면 받아짐
item.addr = arg_item.addr;         // 접근가능
```
