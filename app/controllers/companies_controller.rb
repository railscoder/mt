class CompaniesController < ApplicationController
  def index
    @companies = Company.where('email != ? OR phones != ?', 'nil', []).where(client_id: 7)
  end
end
