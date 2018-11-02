# 단계별 구현 내용 및 실행 화면

**2단계 MVC 패턴**

- 현 단계에서 불필요한 코드 삭제
- `UICollectionView`와 커스텀 `UICollectionViewCell`을 사용하여 `BeverageCell`을 구현 및 표시
- `BeverageCell`의 `추가` 버튼을 누르면 노티피케이션이 포스트되고 `ViewController`에서 이를 옵저빙 하여 음료를 추가하고 컬렉션 뷰를 리로드 

*실행화면*

![vendingmachineapp-step2](/Users/dongkun/Desktop/CodeSquad/swift-vendingmachineapp/images/vendingmachineapp-step2.png)

**3단계 앱 생명주기와 객체 저장**

- 서브클래스의 타입을 유지하기 위해 `NSSecureCoding` 프로토콜과 `NSKeyedArchiver`, `NSKeyedUnArchiver`를  사용하여 데이터 아카이빙

- `UserDefaults`를 이용해 데이터 저장
- `applicationDidEnterBackground(_:)` 에서 데이터 저장, `application(_:,didFinishLaunchingWithOptions:)`에서 데이터 불러오기
  - `applicationDidBecomeActive(_:)`는 앱 생명주기상 뷰가 모드 불러와진 후에 동작.

*실행화면*

![vendingmachineapp-step3](/Users/dongkun/Desktop/CodeSquad/swift-vendingmachineapp/images/vendingmachineapp-step3.png)

**4단계 싱글톤 모델**

*AppDelegate에 변수를 선언하면 하여 사용했을 때의 장단점에 대해 고민해보았습니다. 가장 먼저 든 생각은 뷰가 모두 불러오기 전 데이터가 세팅이 되기 때문에 뷰 컨트롤러에서 뷰를 모두 로드하고 데이터를 로드하는 것보다 보다 빠르게 데이터에 접근할 수 있을 것이라는 생각을 하였습니다. 하지만 AppDelegate에 선언한 변수에 대한 접근이 제가 했던 실수와 같이 Retain Cycle을 만들게 될 가능성과 변수 하나에 접근하기 위한 어떤 객체에서도 AppDelegate에 접근한다는 것이 부담스럽다는 생각을 하였습니다. AppDelegate에 선언해줄 변수는 앱 런칭 후 뷰들이 불러오기 전 해주어야할 행위들을 위한 변수만을 선언하는것이 낫다는 생각을 하였습니다.*

- 처음에는 `VendingMachine` 객체 안에서 데이터를 저장하고 불러오는 로직을 위치시켰으나 후에는 이 로직을 `DataManager` 객체에게 위임하여 진행하였습니다.
- `static let`에 블록을 할당하여 해당 블록안에서 데이터를 불러오고 실패한다면 새 객체를 할당해주었습니다. 
- 싱글톤 객체에 직접적인 접근이 아닌 `VendingMachineDataSource`를 객체 생성 시점에 주입해줌으로써 자판기 인터페이스를 제공해주었습니다.

*실행화면*

![vendingmachineapp-step4](/Users/dongkun/Desktop/CodeSquad/swift-vendingmachineapp/images/vendingmachineapp-step4.png)



# 진행 방법

- 음료수 자판기 iOS 앱에 요구사항을 파악한다.
- 요구사항에 대한 구현을 완료한 후 자신의 github 아이디에 해당하는 브랜치에 Pull Request(이하 PR)를 통해 코드 리뷰 요청을 한다.
- 코드 리뷰 피드백에 대한 개선 작업을 하고 다시 PUSH한다.
- 모든 피드백을 완료하면 다음 단계를 도전하고 앞의 과정을 반복한다.

# 코드 리뷰 과정
> 저장소 브랜치에 자신의 github 아이디에 해당하는 브랜치가 존재해야 한다.
>
> 자신의 github 아이디에 해당하는 브랜치가 있는지 확인한다.

1. 자신의 github 아이디에 해당하는 브랜치가 없는 경우 브랜치 생성 요청 채널을 통해 브랜치 생성을 요청한다.
프로젝트를 자신의 계정으로 fork한다. 저장소 우측 상단의 fork 버튼을 활용한다.

2. fork한 프로젝트를 자신의 컴퓨터로 clone한다.
```
git clone https://github.com/{본인_아이디}/{저장소 아이디}
ex) https://github.com/godrm/swift-vendingmachineapp
```

3. clone한 프로젝트 이동
```
cd {저장소 아이디}
ex) cd swift-vendingmachineapp
```

4. 본인 아이디로 브랜치를 만들기 위한 checkout
```
git checkout -t origin/본인_아이디
ex) git checkout -t origin/godrm
```

5. commit
```
git status //확인
git rm 파일명 //삭제된 파일
git add 파일명(or * 모두) // 추가/변경 파일
git commit -m "메세지" // 커밋
```

6. 본인 원격 저장소에 올리기
```
git push origin 본인_아이디
ex) git push origin godrm
```

7. pull request
8. pull request는 github 서비스에서 진행할 수 있다.
9. pull request는 반드시 original 저장소의 브랜치와 fork한 자신의 저장소 브랜치 이름이 같아야 하며, 브랜치 이름은 자신의 github 아이디여야 한다.
10. code review 및 push
11. pull request를 통해 피드백을 받는다.
12. 코드 리뷰 피드백에 대한 개선 작업을 하고 다시 PUSH한다.

## 앞의 코드 리뷰 과정은 [영상 보기](https://www.youtube.com/watch?v=ZSZoaG0PqLg) 를 통해 참고 가능

## 실습 중 모든 질문은 슬랙 채널에서...