# Swift Vending Machine App



## Step 1. 음료 클래스 설계

2020.02.29 Sat

- 상위 클래스 Beverage와 이를 상속받은 Milk, Soda, Coffee 클래스 구현
- VendingMachine 클래스에서 현재 보유한 음료 목록 출력 



### 실행 화면

<img src="https://user-images.githubusercontent.com/40784518/75602870-81954500-5b0c-11ea-84c1-819746c989a5.png " width="50%"></img>



<br>

<br>



## Step 2. 자판기 기본 동작

2020.03.05 Thur

### 구현 내용 

- Milk, Soda, Coffee 각각의 세분화된 클래스 구현 (Coke, StarbucksCoffe, BananaMilk...)
- `Beverages` 클래스를 만들어 `Beverage` 추가, 삭제 기능 및 순회하고 각 종류당 수량 조회 기능 구현
- `VendingMachine` 에 기능 추가
  - 자판기 금액을 원하는 금액만큼 올리는 메소드
  - 특정 상품 인스턴스를 넘겨서 재고를 추가하는 메소드
  - 현재 금액으로 구매가능한 음료수 목록을 리턴하는 메소드
  - 음료수를 구매하는 메소드
  - 잔액을 확인하는 메소드
  - 전체 상품 재고를 (사전으로 표현하는) 종류별로 리턴하는 메소드
  - 유통기한이 지난 재고만 리턴하는 메소드
  - 따뜻한 음료만 리턴하는 메소드
  - 시작이후 구매 상품 이력을 배열로 리턴하는 메소드
- `Beverage`, `Beverages`, `VendingMachine`에 대한 테스트 케이스 추가 

### 고민한 점

- 자판기에서 돈을 어떻게 가지고 있을지 고민했다. `Money`라는 객체를 따로 만들까 고민했으나 Money는 상태만 가지고 있지 행위는 가지고 있지 않아 자판기의 프로퍼티로 있는게 낫겠다 판단했다. 그래서 실제 자판기에 지폐와 동전 넣는 것을 생각하여 돈의 단위(오천원,천원,오백원,백원)로 자판기 금액을 증가시킬 수 있게 하였다.
- 음료 각각의 갯수가 자판기에서 만들어져야할 지 `Beverage`에서 만들어져야 할 지 고민했다. 허나 둘 다 아닌 것 같아 복수개의 음료를 가지고 있는 `Beverages`를 따로 만들었다.



### 수정사항

2020.03.07 Sat

- 기존에 `Beverage` 가 가지고 있던 날짜를 변환하는 기능을 Date 타입이 가지도록 확장했음
- 기존 `manufacturedDate` 와 `expirationDate` 를 `vendingMachine` 에서 접근해서 유통기한이 만료된 음료를 찾았는데, 만료된건지 확인만 하도록 `Beverage` 내부에 오늘 날짜와 유통기한 비교하는 메소드 추가함
- 기존에 expirationDate이 생성하는 시점에 Calendar.current.... 해서 음료 제조 날짜보다 7일 이전 날짜로 생성되도록 했었는데, 그러면 생성할때마다 저렇게 길게 입력해줘야 하므로 이것또한 Date 타입을 확장해 과거 날짜로 만들어지는 메소드를 생성함.
- 기존에 isHot을 Bool값으로 정했을 때는, 자판기에 ‘따뜻한 음료’ 로 따로 따뜻하게 보관해놓은 음료를 생각해두고 거기에 포함되면 true 로 주면 되겠다고 생각해서 Bool타입의 isHot 변수를 만들었음
  -  `Bool타입은 확장성이 부족한 타입이고, 데이터를 다루는 모델을 설계할 때 상태를 결정하는 것도 기준값으로 비교하는 로직으로 구현하는 것이 좋다`는 피드백을 받아 `온도` 라는 변수를 추가해 따뜻한지 기준값으로 비교하게끔 변경
- `Money` 타입을 새로 만들어서 잔액 계산 등의 역할을 가지게 함
- `flavor`나 `fatRatio`등의 선택지를 제한하고 싶어서 enum 타입의 속성을 가지도록 한건데, 음료라는 객체의 확장성을 '맛'이라는 관점에서 생각해봤을 땐 새로운 클래스를 추가하는게 나을 것 같아 `enum Flavor`  은 삭제함. 다만, `fatRatio`같은 지방 비율을 나타내는 건 아무리 선택지를 확장해도 제한된 범위 이내라고 생각해 enum 속성 그대로 두었음
- `VendingMachin` 에서 현재 잔액으로 구매 가능한 음료를 찾는 기능을 했는데, 하위 객체인 `Beverages` 가 잔액과 음료 가격을 비교해서 구매 가능한지 비교하는 역할을 리턴하도록 변경



<br>

<br>



## step3. 음료수 자판기 앱_MVC 패턴

2020.03.08 Sun

### 구현 내용

- 스토리보드에 아이패드 앱 화면을 구현
  - 각 상품에 대한 재고 추가 버튼을 추가
  - 각 상품에 대한 이미지를 추가
  - 각 상품에 대한 재고 레이블을 추가
  - 1000원, 5000원 금액을 입력하는 버튼을 추가
  - 현재 잔액을 표시할 레이블을 추가한다.
- 각 상품의 재고 추가 버튼을 누르면 각 상품 재고를 추가하도록 코드를 구현
- 재고 추가 버튼을 누르고 나면 전체 레이블 다시 표시
- 금액 입력 버튼을 누르면 해당 금액을 추가하도록 코드를 구현
- 금액을 추가하고 나면 잔액 레이블을 다시 표시



### 실행 화면

[재고 추가] 버튼과 [금액] 버튼 누른 경우 알맞게 화면이 변경되는 것을 볼 수 있다

<img src = "https://user-images.githubusercontent.com/40784518/76164087-53a8a400-618f-11ea-94cf-49ec2616aabb.png" width = "80%"/>



### 수정 사항

- `moneyType` 이름을 좀 더 명확한 `moneyUnit` 으로 변경
- `Money` 클래스에서 `balance`의 접근 제한자를 private 으로 변경해, `Money` 객체 자체를 타입으로 활용
  - `Money` 타입이 CumstomStringConvertible을 채택해 `balance` 를 문자열로 리턴해주게 함 
- `VendingMachine` 클래스에서 `raiseMoney(index:) `의 Int 타입인 인자 index를 `MoneyUnit`으로 변경해 조금 더 안전하게 동작하도록 변경
- `ViewController`에서 각 음료에 재고 추가시 재고 갯수를 리턴받는 코드를 `VendingMachine`에 클로저로 넘겨서 처리하도록 변경
- `ViewController`에서 `addMoney(button:)` 메서드에서 **Controller -> View** 로만 있던 흐름을 **Model -> View -> Controller** 의 흐름이 되도록 Observer Pattern 사용 