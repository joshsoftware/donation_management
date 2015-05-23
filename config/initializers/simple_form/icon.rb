module SimpleForm
  module Components
    module Icon
      def icon(wrapper_options = nil)
        @icon ||= begin
                    options[:icon].to_s.html_safe
                  end
      end 
    end 
  end 
end
SimpleForm::Inputs::Base.send(:include, SimpleForm::Components::Icon)
