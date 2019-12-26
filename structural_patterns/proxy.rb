# frozen_string_literal: true

# The Proxy can be used to mask the service object's physical location (a Remote proxy),
# manage access to the service object (a Security proxy), or just lazily initialize the service object (a Virtual proxy)

class Account
  def initialize(balance)
    @balance = balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end

  def self.interest_rate_for(a_balance)
    a_balance > 10_000 ? '3.2%' : '5.5%'
  end
end

# the proxy object
class AccountProxy
  require 'etc'

  def initialize(real_account)
    @real_account = real_account
  end

  def method_missing(name, *args)
    raise 'Unauthorised access!' unless Etc.getlogin == 'fred'

    @real_account.send(name, *args)
  end
end

## client code
acc = Account.new(100)
proxy = AccountProxy.new(acc)
proxy.deposit(10)
proxy.withdraw(50)
