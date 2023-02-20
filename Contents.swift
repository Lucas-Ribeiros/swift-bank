struct SwiftBank {
  private let password: String
  private let initialDeposit: Double
  private var firstDeposit: Bool = true

  init(password: String, initialDeposit: Double) {
    self.password = password
    self.initialDeposit = initialDeposit
    makeDeposit(depositAmount: self.initialDeposit)
  }

  private func isValid(_ enteredPassword: String) -> Bool {
    enteredPassword == self.password ? true : false
  }

  private var balance: Double = 0.0 {
    didSet {
      if balance < 100 {
        displayLowBalanceMessage()
      }
    }
  }

  static let depositBonusRate: Double = 0.01

  mutating private func finalDepositWithBonus(deposit: Double) -> Double {
    if firstDeposit && deposit >= 1000 {
      firstDeposit = false
      return deposit + (deposit * SwiftBank.depositBonusRate)
    } else {
      return deposit
    }
  }

  mutating func makeDeposit(depositAmount: Double) {
    guard depositAmount > 0 else {
      print("Error: Não é possível depositar uma valor igual ou inferior a R$0.")
      return
    }
    let depositWithBonus = finalDepositWithBonus(deposit: depositAmount)
    print("Fazendo um depósito de R$\(depositAmount) com uma taxa de bonus. O valor final depsitado é R$\(depositWithBonus)")
    self.balance += depositWithBonus
  }

  func displayBalance(password: String) {
    isValid(password) ? print("Seu saldo é de R$\(balance)") : print("Senha inválida.")
  }

  mutating func makeWithdrawal(withdrawalAmount: Double, password: String) {
    guard withdrawalAmount > 0 else {
      print("Error: Não pode sacar um valor igual ou inferior a R$0.")
      return
    }
    guard withdrawalAmount <= balance else {
      print("Error: Saldo indisponível.")
      return
    }
    if !isValid(password) {
      print("Error: Senha inválida.")
    } else {
      balance -= withdrawalAmount
      print("Sacando R$\(withdrawalAmount).")
    }
  }

  private func displayLowBalanceMessage() {
    print("Alert: Seu saldo está abaixo de $100.")
  }

}

var myAccount = SwiftBank(password: "12345", initialDeposit: 1500)
myAccount.makeDeposit(depositAmount: 50)
myAccount.makeWithdrawal(withdrawalAmount: 100, password: "1234")
myAccount.makeWithdrawal(withdrawalAmount: 100, password: "12345")
myAccount.displayBalance(password: "12345")
myAccount.makeDeposit(depositAmount: 5000)
