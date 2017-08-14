class YandexSearchJob < ApplicationJob
  queue_as :default

  def perform(query, city_id, client)
    #File.open("queries.txt", "r").each_line do |query|
      YandexSearchService.call(query, city_id, client)
      #sleep(60)
    #end
  end
end
