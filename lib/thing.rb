require 'securerandom'

class Thing
  attr_reader :id, :name, :created_at

  def initialize(id: SecureRandom.uuid, name:, created_at: nil)
    @id = id
    @name = name
    @created_at = created_at
  end
end
