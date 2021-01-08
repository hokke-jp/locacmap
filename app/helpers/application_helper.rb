module ApplicationHelper
  # ページごとの完全なタイトル返す
  def full_title(page_title = '')
    base_title = 'Localmap'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
