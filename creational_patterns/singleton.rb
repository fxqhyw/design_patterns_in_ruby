# frozen_string_literal: true

# This pattern ensures that the class will have only one instance.

class Database
  @@instance = Database.new

  def self.instance
    @@instance
  end

  private_class_method :new
end

d1 = Database.instance
d2 = Database.instance
d2.object_id == d1.object_id # true
