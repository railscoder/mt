class CompaniesController < ApplicationController
  def index
    @companies = Company.where('email != ? OR phones != ?', 'nil', []).where(client_id: 1)
  end
end
