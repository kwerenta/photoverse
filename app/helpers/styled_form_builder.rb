class StyledFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :safe_join, to: :@template

  def text_control(attribute, options={})
    control_wrapper(attribute, options) do
      safe_join [
        (control_label(attribute, merge_options({class: "label"}, options[:label])) unless options[:label] == false),
        string_field(attribute, merge_options({class: "input input-bordered input-accent"}, options[:input_html]))
      ]
    end
  end

  def boolean_control(attribute, options={})
    control_wrapper(attribute, options) do
      label(attribute, merge_options({class: "label cursor-pointer"}, options[:label])) do
        safe_join [label_text(attribute),
                   check_box(attribute, merge_options({class: "checkbox checkbox-accent"}, options[:input_html]))]
      end
    end
  end

  def file_control(attribute, options={})
    control_wrapper(attribute, options) do
      safe_join [control_label(attribute, merge_options({class: "label"}, options[:label])),
                 file_field(attribute,
                            merge_options({class: "input input-bordered input-accent"}, options[:input_html]))]
    end
  end

  def submit_control(attribute, options={})
    control_wrapper(attribute, options) do
      submit(attribute, merge_options({class: "btn btn-primary mt-6"}, options[:input_html]))
    end
  end

  private

  def control_wrapper(_attribute, _options, &block)
    content_tag(:div, class: "form-control") do
      block.call
    end
  end

  def control_label(attribute, options)
    label(attribute, merge_options({class: "label"}, options[:label])) do
      label_text(attribute)
    end
  end

  def label_text(attribute)
    content_tag(:span, class: "label-text") do
      attribute.to_s.humanize
    end
  end

  def string_field(attribute, options={})
    case attribute.to_s
    when /password/ then password_field(attribute, options)
    when /email/ then email_field(attribute, options)
    when /phone/ then telephone_field(attribute, options)
    else
      text_field(attribute, options)
    end
  end

  def merge_options(options, user_options)
    return options if user_options.nil?

    options.merge(user_options)
  end
end
