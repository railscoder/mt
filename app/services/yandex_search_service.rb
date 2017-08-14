module YandexSearchService
  COUNT_PAGE = 40
  SLEEP_TIME = 5

  class << self
    def call(query, city_id, client)
      @query = query
      @city_id = city_id
      @client = client
      for i in 0..COUNT_PAGE
        open_page(get_url(i))
        sleep(SLEEP_TIME)
      end
      return
    end


    def get_url(number_of_page)
      query = URI::encode(@query)
      Settings.yandex.url+"&lr=213&text=#{query}&p=#{number_of_page}"
    end

    def open_page(url)
      html = open(url)
      doc = Nokogiri::XML(html)
      category = Category.find_or_create_by!(name: @query)
      client = Client.find_or_create_by!(name: @client)
      doc.xpath('//domain').each do |site|
        company = Company.create(site: site.text, source: "yandex", category_id: category.id, city_id: @city_id, client_id: client.id)
      end
    end
  end
end
