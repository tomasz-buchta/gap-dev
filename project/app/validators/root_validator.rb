class RootValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "must be root node" unless value.root?
  end
end
