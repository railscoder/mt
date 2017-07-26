class CompaniesController < ApplicationController
  def index
    @companies = Company.where(source: "yandex").uniq
  end
end
