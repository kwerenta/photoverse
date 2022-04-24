module ApplicationHelper
  def number_to_human_shortcut(number)
    number_to_human(number, :format => '%n%u', :units => { :thousand => 'K', :million => "M" })
  end
end
