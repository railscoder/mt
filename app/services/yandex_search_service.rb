module YandexSearchService
  COUNT_PAGE = 60
  SLEEP_TIME = 5

  class << self
    def call(query, city_id)
      @query = query
      @city_id = city_id
      for i in 0..COUNT_PAGE
        open_page(get_url(i))
        sleep(SLEEP_TIME)
        pp i
      end
    end


    def get_url(number_of_page)
      query = URI::encode(@query)
      Settings.yandex.url+"&lr=213&text=#{query}&p=#{number_of_page}"
    end

    def open_page(url)
      html = open(url)
      doc = Nokogiri::XML(html)
      doc.xpath('//domain').each do |site|
        ActiveRecord::Base.transaction do
          category = Category.find_or_create_by!(name: @query)
          company = Company.create(site: site.text, source: "yandex", category_id: category.id, city_id: @city_id)
        end
      end
    end
  end
end
