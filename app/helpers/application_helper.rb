module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Alphabetic Design"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def flash_class(level)
    case level
      when :notice then "alert-info alert-dismissable"
      when :success then "alert-success alert-dismissable"
      when :error then "alert-danger"
      when :alert then "alert-warning alert-dismissable"
    end
  end

  def parse_links(comment)
    auto_link(comment, html: {target: '_blank'}) do |text|
      URI.parse(text).host
    end
  end

end
