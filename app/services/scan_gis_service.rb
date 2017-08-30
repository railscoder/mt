module ScanGisService
  class << self
    include ScanGis

    def call(query, client, city_ids = [], start_page=1, start_city_id=1)
     city_ids = City.pluck(:id) if city_ids == "all"
      @query = query
      @client = Client.find_or_create_by!(name: client)
      city_ids.each do |city_id|
        count_pages = get_count_pages(get_url(city_id))
        for i in start_page..count_pages
          scan_one_page(get_url, i, city_id)
          LoggerService.call("2gis page - #{i}, query - #{@query}")
          sleep(5)
        end
        sleep(1800)
      end
    end

    private

      def scan_one_page(url, number_page, city_id)
        current_url = url + "/page/#{number_page}"
        page = open_page(current_url)
        page.css(Settings.gis.style.header_title).each do |showing|
          showing = showing.inner_html.scan(/\/.+" /)[0].chop.chop
          url_of_item = Settings.gis.url + showing
          scan_item(url_of_item, city_id)
        end
      end

      def scan_item(url, city_id)
        page_item = open_page(url)
        phone = get_phone(page_item)
        name = get_name(page_item)
        site = get_site(page_item)
        ActiveRecord::Base.transaction do
          category = Category.find_or_create_by!(name: @query)
          company = Company.create(site: site, name: name, phones: [phone],source: "2gis", category_id: category.id, city_id: city_id, client_id: @client.id)
        end
      end
  end
end
