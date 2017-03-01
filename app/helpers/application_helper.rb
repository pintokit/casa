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

  def price_per_sqft_link(flat)
    link_to flat_listings_path(flat) do
      number_to_currency((flat.listings.last.price - 2000.0) / (flat.sqft-1.0), precision: 2)
    end
  end

  def score_column(attribute, multiple, weight)
    "<h5 class='hidden-xs'>
       #{(attribute * multiple).round}  <small>of #{weight}</small>
    </h5>
    <h6 class='visible-xs'>
      <u> #{(attribute * multiple).round} </u>
      <div class='visible-xs'><small>#{weight}</small></div>
    </h6>".html_safe
  end

end
