class EmailAddressValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  def validate_each(record, _attribute, value)
    return if value.match(EMAIL_REGEX)

    record.errors.add(:error, "#{value} is not an email")
  end
end
