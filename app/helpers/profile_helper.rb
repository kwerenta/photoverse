module ProfileHelper
  def follow_button_dom_id(user)
    dom_id_for_user(user, "follow-button")
  end

  def follow_counters_dom_id(user)
    dom_id_for_user(user, "follow-count")
  end

  private

  def dom_id_for_user(user, element)
    "#{user.username}-#{element}"
  end
end
