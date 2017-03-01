module ApplicationHelper

  # set these values per view within each controller
  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def title(page_title)
    content_for :title, page_title
  end

  def heading(page_heading)
    content_for :heading, page_heading
  end

  def filter_by(title, bed_type, status)
    link_to title, root_path(bed: bed_type, is_active: status)
  end

end
