class CompaniesController < ApplicationController
  def index
    @companies = Company.where(client_id: 2).uniq
  end
end
