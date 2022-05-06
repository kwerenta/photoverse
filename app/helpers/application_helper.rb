module ApplicationHelper
  def number_to_human_shortcut(number)
    number_to_human(number, format: "%n%u", units: {thousand: "K", million: "M"})
  end

  def nav_link_to(link_path, &block)
    class_name = current_page?(link_path) ? "font-semibold after:absolute after:-right-4 after:top-1/2 after:-translate-y-1/2 after:w-1 after:h-1/2 after:bg-primary after:rounded-box" : ""

    content = capture(&block)
    content_tag(:li, class: class_name) do
      link_to link_path do
        content
      end
    end
  end
end
