module ScanGisService
  PAGE_PER_COMPANIES = 12

  class << self
    def call(query, city_id, category_id, source)
      url = get_url(query, city_id)
      count_pages = get_count_pages(url)
      i = 1
      while i < get_count_pages(url)
        scan_one_page(url, i, source)
        i += 1
      end
    end

    private

      def scan_one_page(url, number_page, source)
        current_url = url + "/page/#{number_page}"
        page = open_page(current_url)
        page.css(Settings.gis.style.header_title).each do |showing|
          showing = showing.inner_html.scan(/\/.+" /)[0].chop.chop
          url_of_item = Settings.gis.url + showing
          scan_item(url_of_item, source)
        end
      end

      def get_url(query, city_id)
        query = URI::encode(query)
        city_name = City.find(city_id).eng_name
        Settings.gis.url+"/#{city_name}/search/#{query}"
      end

      def get_count_pages(url)
        page = open_page(url)
        count_of_companies = page.at_css(Settings.gis.style.result).inner_html
        count = (count_of_companies.scan(/\d+/).join.to_i / PAGE_PER_COMPANIES).ceil
      end

      def open_page(url)
        html = open(url)
        doc = Nokogiri::HTML(html)
      end

      def scan_item(url, source)
        page_item = open_page(url)
        phone = get_phone(page_item)
        name = get_name(page_item)
        site = get_site(page_item)
        begin
          ActiveRecord::Base.transaction do
            company = Company.create(site: site, name: name, source: source, category_id: 1, city_id: 1)
            phone = company.phones.create(value: phone)
          end
        rescue
        end
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
end
