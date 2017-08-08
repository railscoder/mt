class CompaniesController < ApplicationController
  def index
    @companies = Company.where(category_id: 6).uniq
  end
end
