module SimpleForm
  module Inputs
    class DateFieldInput < Base
      enable :placeholder, :maxlength, :pattern

      def input(wrapper_options = nil)
        unless date_field?
          input_html_classes.unshift("string")
          input_html_options[:type] ||= input_type if html5?
        end

        attribute = @builder.object.send(attribute_name)
        if attribute.present? and attribute.is_a? Date
          input_html_options[:value] = attribute.strftime('%m/%d/%Y')
        end
        merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

        @builder.text_field(attribute_name, merged_input_options)
      end 

      private

      def date_field?
        input_type == :date_field
      end 

    end 
  end 
end
