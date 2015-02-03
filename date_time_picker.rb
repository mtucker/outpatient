class DateTimePickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    @builder.text_field("#{attribute_name}_date", date_input_html_options) +
    @builder.text_field("#{attribute_name}_time", time_input_html_options)
  end

  def date_input_html_options
    { 
      value: @builder.object.send("#{attribute_name}_date").to_formatted_date, 
      class: 'date_picker'
    }
  end

  def time_input_html_options
    { 
      value: @builder.object.send("#{attribute_name}_time").to_formatted_time, 
      class: 'time_picker'
    }
  end

end
