# ✊✌️🖐️묵찌빠게임


## 목차

1. [팀원](#1-팀원)
2. [클래스다이어그램](#2-클래스-다이어그램)
3. [타임라인](#3-타임라인)
4. [실행 화면(기능 설명)](#4-실행화면기능-설명)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [참고 링크](#6-참고-링크)
7. [팀 회고](#7-팀-회고)

<br>

## 1. 팀원

| [mireu](https://github.com/mireu79)  | [Kyle](https://github.com/Changhyun-Kyle) |
| :--------: | :--------: |
|<img src=https://github.com/mireu79/ios-rock-paper-scissors/assets/125941932/b4a69222-b338-4a7f-984c-be5bd78dc1d8 height="150"/> |<img src=https://github.com/tasty-code/ios-rock-scissor-paper/assets/148876644/e4308de2-584b-4bc7-ac9d-659d1962ab22 height="150"/> | 

<br>

## 2. 클래스 다이어그램

![무제](https://hackmd.io/_uploads/S1iGrXPHp.png)




<br>

## 3. 타임라인
|날짜|내용|
|------|---|
|23.11.20|STEP1 프로젝트 흐름에 대한 파악 및 공식문서 공부,<br> 가위바위보게임 최초 실행함수구현|
|23.11.21|가위바위보게임 구현 및 열거형 생성 <br> STEP1 PR|
|23.11.23|리뷰받은 부분 수정 <br> 함수 및 타입 네이밍 수정 <br> 유저 인터페이스 기능 분리|
|23.11.24|STEP2 흐름 파악 및 불필요한 함수 제거 <br> 묵찌빠 게임을 실행하는 로직 구현 |
|23.11.27|CaseIterable 프로토콜 채택 <br> while true문 네이밍 수정  |
|23.11.28|중복성을 줄이기 위한 프로토콜 구현 및 채택<br> 묵찌빠 initializer 추가 |
|23.11.30|Turn 열거형 수정 및 프로토콜 삭제|
|23.12.1|가위바위보게임 turn프로퍼티 삭제후 묵찌빠게임 turn프로퍼티 생성하여 turn을 묵찌빠에서 처리할 수 있게 수정|
 
<br>

## 4. 실행화면(기능 설명)


| 게임종료 | 가위바위보게임 ➡️ 묵찌빠게임 |
| :--------: | :--------: | 
|  ![게임종료](https://hackmd.io/_uploads/Bk3QhGPB6.gif)|![가위바위보게임에서묵찌빠게임으로넘어가는부분](https://hackmd.io/_uploads/H1GE3zDS6.gif) |
**잘못 입력되었을 때 ➡️ 컴퓨터턴으로 받는 부분** | **사용자 입력값 유효성 검증** |
| ![잘못입력받았을때와묵찌빠게임에서 잘못받았을떄컴퓨터턴으로넘어가](https://hackmd.io/_uploads/BycE2MPH6.gif) | ![화면 기록 2023-12-01 오후 6.41.42](https://hackmd.io/_uploads/HJ_zimwB6.gif)|


  

<br>

## 5. 트러블 슈팅
### 1️⃣ 
게임을 시작하는 **`start()`** 함수에서 사용자의 입력값이 유효한지 검사하는 로직을 구현했습니다. 하지만, **`start()`** 함수의 목적과 달리 유효성을 검증하는 부분이 방대해졌습니다. 따라서, **`Command`** 구조체를 생성하고 실패가능생성자를 활용하여 사용자의 입력값을 판단하고 통제하는 타입을 구현했습니다.
이를 통해, 본래 함수의 목적에 맞게 구현하고 이후 추가적인 요구사항에 대한 유연성을 늘릴 수 있게 확장했습니다.
- **수정전**
 ~~~ swift
private func start() -> Bool {
    /*{code}*/
    guard
        let input = readLine(),
        let user = Int(input)
        let userInput = readLine(),
        let userChoice = Int(userInput)
    else {
        print(ApplicationStatus.error.message)
        return true
    }
    /*{code}*/
}
~~~
 - **수정후**
 
~~~ swift
struct Command {
    static let validInputs = [0, 1, 2, 3]
    let userChoice: Int
    var isQuit: Bool {
        return userChoice == 0
    }
    
    init?(value: String?) {
        guard
            let input = value,
            let converted = Int(input)
        else {
            return nil
        }
        
        let isValid = Command.validInputs.contains(converted)
        
        guard isValid else { return nil }
        self.userChoice = converted
    }
}
~~~
 
### 2️⃣

**`RockScissorPaperGame`** 구조체에서 생성된 프로퍼티인 **`turn`** 을 **`MukJjiPpa`** 구조체에서 접근하여 게임의 턴을 결정했습니다. 하지만, 게임의 논리적인 흐름을 생각했을 때 가위바위보 게임의 결과를 통해 묵찌빠 게임의 턴을 결정하고 게임을 이어나가는 방향이 옳다고 생각했습니다. 따라서, **`RockScissorPaperGame`** 의 **`play()`** 함수에서 **`GameResult`** 를 반환하고, 해당 반환값을 삼항 연산자를 통해 승패여부를 판단하여 **`MukJjiPpa`** 구조체에서 사용하는 **`turn`** 을 정해줄 수 있게 수정했습니다.

 - **수정 전**
~~~ swift
struct MukJjiPpa {
    /*{code}*/
    mutating func play() {
        rockScissorPaperGame.play()
        turn = rockScissorPaperGame.turn
        while true {
            guard
                continueGame()
            else {
                return
            }
        }
    }
    /*{code}*/
}
    
~~~
 - **수정 후**
~~~ swift
struct MukJjiPpa {
    /*{code}*/
    mutating func play() {
        guard
            let result = rockScissorPaperGame.play()
        else {
            return
        }
        
        turn = result == .win ? .user : .computer
        while true {
            guard
                continueGame()
            else {
                return
            }
        }
    }
    /*{code}*/
}
    
~~~

<br>

## 6. 참고 링크
[📖 공식문서 Naming](https://www.swift.org/documentation/api-design-guidelines/)<br>
[📖 공식문서 Initialization](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/initialization/)<br>
[📖 공식문서 functions](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/functions/)<br>
[📖 공식문서 Enumerations](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/)<br>
[📖 공식문서 properties](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/)<br>
[📖 공식문서 methods](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/methods/)<br>
[📖 공식문서 writing symbol documentation](https://developer.apple.com/documentation/xcode/writing-symbol-documentation-in-your-source-files)<br>

<br>

## 7. 팀 회고
- 😄우리팀이 잘한 점
    - 의견조율을 잘해서 코드짜는데 차질이 없었습니다.

<br>

- 😅우리팀이 개선할 점
    - 배려가 있는 모습은 좋으나 자기 주장과 자신감이 다소 부족했습니다.


