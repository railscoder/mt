module YandexSearchService
  class << self
    def call(query, city_id)
      @query = query
      @city_id = city_id
      i = 0
      while i < 80 do
        open_page(get_url(i))
        i += 1
        sleep(5)
      end
    end


    def get_url(number_of_page)
      query = URI::encode(@query)
      pp number_of_page
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
