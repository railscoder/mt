module ScanGis
  PAGE_PER_COMPANIES = 12

  def open_page(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
  end

  def get_url
    query = URI::encode(@query)
    city_name = City.find(@city_id).eng_name
    Settings.gis.url+"/#{city_name}/search/#{query}"
  end

  def get_count_pages(url)
    page = open_page(url)
    count_of_companies = page.at_css(Settings.gis.style.result).inner_html
    count = (count_of_companies.scan(/\d+/).join.to_i / PAGE_PER_COMPANIES).ceil
  end

  def get_phone(page_item)
    phones = page_item.css(Settings.gis.style.phone)
    phones[1].inner_html if phones[1]
  end

  def get_name(page_item)
    name = page_item.at_css(Settings.gis.style.name)
     name.inner_html if name
  end

  def get_site(page_item)
    site = page_item.at_css(Settings.gis.style.site)
    site.inner_html if site
  end
end
