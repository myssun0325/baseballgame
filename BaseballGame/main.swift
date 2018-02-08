// by Moon Young Sun 2018.2.8

import Foundation

// main
func startBaseballGame() {
    
    let randomNumber: [Int] = getRandomNumber()
    var userNumber = [Int]()
    
    print(randomNumber)
    
    repeat {
        userNumber = getUserNumber()
        
        // 사용자의 중복숫자 입력 방지
        while hasSameNumber(userNumber) {
            print("입력한 숫자가 중복됩니다.")
            userNumber = getUserNumber()
        }
        
        var ballCount = 0
        var strikeCount = 0
        
        ballCount = checkBall(userNumber, randomNumber)
        
        if ballCount != 0 {
            strikeCount = checkStrike(userNumber, randomNumber)
            ballCount -= strikeCount
        }
        
        printResult(ballCount: ballCount, strikeCount: strikeCount)

    } while userNumber != randomNumber
    
    print("3개의 숫자를 모두 맞히셨습니다! 게임종료")
    
    return
}

func getRandomNumber() -> [Int] {
    
    var randomNumbers = [Int]()
    
    while randomNumbers.count < 3 {
        let randomNumber = Int(arc4random_uniform(9)) + 1
        
        if !randomNumbers.contains(randomNumber) {
            randomNumbers.append(randomNumber)
        }
    }
    
    return randomNumbers
}

func getUserNumber() -> [Int] {
    
    print("숫자를 입력해주세요 ex)123 : ", terminator: "")
    
    var userNumber = [Int]()
    
    if let numbers = readLine() {
        for number in numbers {
            userNumber.append(Int(String(number))!) // 결과를 떠나서 이 행에 대한 피드백을 받을 수 있을까요?
        }
    }
    
    return userNumber
}

func checkBall(_ userNumber: [Int], _ randomNumber: [Int]) -> Int {
    
    var count = 0
    
    for number in userNumber {
        if randomNumber.contains(number) {
            count += 1
        }
    }

    return count
}

func checkStrike(_ userNumber: [Int], _ randomNumber: [Int]) -> Int {
    
    var count = 0
    
    for index in 0...2 {
        if randomNumber[index] == userNumber[index] {
            count += 1
        }
    }
    
    return count
}

func printResult(ballCount: Int, strikeCount: Int) {
    
    let totalCount = ballCount + strikeCount
    
    if totalCount == 0 {
        print("낫싱")
    } else {
        if strikeCount != 0 {
            print("\(strikeCount) 스트라이크")
        }
        
        if ballCount != 0 {
            print("\(ballCount) 볼")
        }
    }
}

func hasSameNumber(_ userNumber: [Int]) -> Bool {
    
    var checkSet = Set<Int>()
    
    for number in userNumber {
        checkSet.insert(number)
    }
    
    if checkSet.count != 3 {
        return true
    } else {
        return false
    }
}
    
// MARK: Start Game
startBaseballGame()
