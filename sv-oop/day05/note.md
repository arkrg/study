# Virtual Class

- virtual class
- pure virtual method

## Virtual Class

자식이 상속만 받는 클래스 핸들을 new() 하는 거 자체가 컴파일 에러다.
자식 클래스의 틀을 제공하는 용도. 자식의 생성자 new()가 실행되면서 virtual class의 new() 내부 코드가 실행됨
(초기화 용도) 불완전한 클래스라는 걸 의미하고 주요한 기능 없는 base 상태 객체가 만들어지지 않도록 컴파일 자체를 막는다
uvm_component 이런 클래스들이 virtual이다

> [!NOTE]
> 일반 멤버, 일반 메서드도 가질 수 있다

## Pure Virtual Method

자식이 반드시 구현해야하는 메소드
부모 클래스에서는 구현되지도 않는다 선언만함 `pure virtual method_name;`

대학 진학에 실패한 청년 P,
P: 내 자식은 꼭 4년제 대학에 보낼거야
이런 선언이 pure virtual 메서드
대학 입시?몰라 대학에서 뭐하는지?몰라 하지만 내자식은 반드시!
P의 자식 C는 20살 즈음에 대학에 가겠지 --> 자식의 틀을 만들어둠
C: 아앗..

- 자식의 의무: 일반 클래스가 상속하면, 같은 이름·인자·반환 타입으로 몸체를 직접 구현해야 함(컴파일 에러)
- 몸체: 부모에는 쓰지 않음 (endtask도 없음)

> [!NOTE] 왜 쓰는걸까
> 자식 클래스 내부를 안뜯어봐도 부모 클래스의 pure 메서드는 반드시 구현되어있을거라고 확신할 수 있음
> TLM 포트 인스턴스에 write()을 구현해야 하는 거 처럼
>
> ```
> class my_env;
>  base_driver drv;          // 부모(virtual class) 타입 핸들만 앎
>
>  task run();
>    drv.drive();            // "어떤 driver든 drive()는 있겠지"
>  endtask
> endclass
>
> //test에서
> env.drv = apb_driver_obj;   // 또는 spi_driver 객체
> ```
