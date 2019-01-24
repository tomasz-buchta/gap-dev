class ParentValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "cannot be parent to itself" if record == value
  end
end
