module YandexSearchService
  COUNT_PAGE = 60
  SLEEP_TIME = 5

  class << self
    def call(query, city_id, client)
      @city_id = city_id
      @category = Category.find_or_create_by!(name: query)
      @client = Client.find_or_create_by!(name: client)
      for i in 0..COUNT_PAGE
        open_page(get_url(i))
        sleep(SLEEP_TIME)
        pp i
      end
      return @category.id
    end


    def get_url(number_of_page)
      query = URI::encode(@query)
      Settings.yandex.url+"&lr=213&text=#{query}&p=#{number_of_page}"
    end

    def open_page(url)
      html = open(url)
      doc = Nokogiri::XML(html)
      doc.xpath('//domain').each do |site|
        company = Company.create(site: site.text, source: "yandex", category_id: @category.id, city_id: @city_id, client_id: @client.id)
      end
    end
  end
end
