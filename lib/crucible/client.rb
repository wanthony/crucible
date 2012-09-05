class Crucible::Client
  def self.get params, &block
    connection.get params, &block
  end
end
