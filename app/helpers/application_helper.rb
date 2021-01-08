module ApplicationHelper
  # ページごとの完全なタイトル返す
  def full_title(page_title = '')
    base_title = '歴史地図'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
