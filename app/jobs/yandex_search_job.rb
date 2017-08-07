class YandexSearchJob < ApplicationJob
  queue_as :default

  def perform(city_id, client)
    File.open("queries.txt", "r").each_line do |query|
      category_id = YandexSearchService.call(query.chomp, city_id, client)
      ScanPhoneEmailService.call("yandex", category_id)
    end
  end
end
