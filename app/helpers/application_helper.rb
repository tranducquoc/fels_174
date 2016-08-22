module ApplicationHelper

  def full_title page_tile = ""
    base_title = "Framgia E-Learning System"
    if page_tile.empty?
      return base_title
    else
      return page_tile + " | " + base_title
    end
  end

  def increase_one index
    index + 1
  end
end
