class ApplicationService
  def initialize(record)
    @record = record
  end

  def self.call(*)
    new(*).call
  end
end
