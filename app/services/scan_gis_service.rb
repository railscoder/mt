module ScanGisService
  class << self
    include ScanGis

    def call(query, city_id, start_page = 1)
      @query, @city_id = query, city_id
      count_pages = get_count_pages(get_url)
      for i in start_page..2
        scan_one_page(get_url, i)
        LoggerService.call("2gis page - #{i}, query - #{@query}")
        sleep(5)
      end
    end

    private

      def scan_one_page(url, number_page)
        current_url = url + "/page/#{number_page}"
        page = open_page(current_url)
        page.css(Settings.gis.style.header_title).each do |showing|
          showing = showing.inner_html.scan(/\/.+" /)[0].chop.chop
          url_of_item = Settings.gis.url + showing
          scan_item(url_of_item)
        end
      end

      def scan_item(url)
        page_item = open_page(url)
        phone = get_phone(page_item)
        name = get_name(page_item)
        site = get_site(page_item)
        ActiveRecord::Base.transaction do
          category = Category.find_or_create_by!(name: @query)
          company = Company.create(site: site, name: name, source: "2gis", category_id: category.id, city_id: @city_id)
          #phone = company.phones.create(value: phone)
        end
      end
  end
end
