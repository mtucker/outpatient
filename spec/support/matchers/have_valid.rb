RSpec::Matchers.define :have_valid do |attribute_name|
  def assign_and_validate(record, attribute_name)
    @allowed_values = []
    @disallowed_values = []

    @attribute_values.each do |attribute_value|
      record.public_send("#{attribute_name}=", attribute_value)
      record.valid?

      if record.errors[attribute_name].any?
        @disallowed_values << attribute_value
      else
        @allowed_values << attribute_value
      end
    end
  end

  match do |record|
    assign_and_validate(record.clone, attribute_name)
    @disallowed_values.empty?
  end

  match_when_negated do |record|
    assign_and_validate(record.clone, attribute_name)
    @allowed_values.empty?
  end

  chain :when do |*attribute_values|
    @attribute_values = attribute_values
  end

  def print_values(values)
    values.map(&:inspect).join(', ')
  end

  failure_message do |record|
    "expected #{record.class.name}##{attribute_name} to accept values #{print_values(@disallowed_values)}"
  end

  failure_message_when_negated do |record|
    "expected #{record.class.name}##{attribute_name} not to accept values #{print_values(@allowed_values)}"
  end
end
