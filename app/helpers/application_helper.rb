module ApplicationHelper
  def number_to_human_shortcut(number)
    number_to_human(number, format: "%n%u", units: {thousand: "K", million: "M"})
  end

  def nav_link_to(link_path, &block)
    class_name = class_names("font-semibold after:absolute after:-right-4 after:top-1/2 after:-translate-y-1/2 after:w-1 after:h-1/2 after:bg-primary after:rounded-box": current_page?(link_path))

    content = capture(&block)
    content_tag(:li, class: class_name) do
      link_to link_path do
        content
      end
    end
  end

  def styled_form_for(name, *args, &block)
    options = args.extract_options!
    args << options.merge(builder: StyledFormBuilder)
    form_for(name, *args, &block)
  end

  def styled_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
    options = options.reverse_merge(builder: StyledFormBuilder)
    form_with(model: model, scope: scope, url: url, format: format, **options, &block)
  end
end
