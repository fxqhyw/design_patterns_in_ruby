# frozen_string_literal: true

# This pattern is applied if the input data / presentation / output of the data is the same but
# the logic of data processing before returning to a presentation is different.

require 'base64'
require 'aes'

class TextMessage
  attr_accessor :encryptor
  attr_reader :original_message

  def initialize(original_message, encryptor)
    @original_message = original_message
    @encryptor = encryptor
  end

  def encrypt_me
    encryptor.encrypt(self)
  end
end

class SimpleEncryptor
  ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  ENCODING = 'MOhqm0PnycUZeLdK8YvDCgNfb7FJtiHT52BrxoAkas9RWlXpEujSGI64VzQ31w'

  def encrypt(context)
    context.original_message.tr(ALPHABET, ENCODING)
  end
end

class Base64Encryptor
  def encrypt(context)
    Base64.encode64(context.original_message)
  end
end

class AESEncryptor
  KEY = 'dsfi434n534df0v0bn23324dfgdfgdf4353454'
  def encrypt(context)
    AES.encrypt(context.original_message, KEY)
  end
end

message = TextMessage.new('my secret secret message', SimpleEncryptor.new)
puts message.encrypt_me
# eb vmhYmD vmhYmD emvvMPm

message.encryptor = Base64Encryptor.new
puts message.encrypt_me
# bXkgc2VjcmV0IHNlY3JldCBtZXNzYWdl

message.encryptor = AESEncryptor.new
puts message.encrypt_me
# 0kr326hFWodI9Xzd42xKBg==$eb6N+Xz4yJngCndUPYVJ7CIEHngqNTG2lFDL1vIocEw=
