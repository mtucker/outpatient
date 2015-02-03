class DatePickerInput < SimpleForm::Inputs::DateTimeInput
  def input(wrapper_options)
    @builder.text_field(attribute_name, input_html_options)
  end

  def input_html_options
    { 
      value: @builder.object.send(attribute_name).to_formatted_date, 
      class: 'dadatepicker'
    }
  end
end
