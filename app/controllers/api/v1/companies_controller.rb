class Api::V1::CompaniesController < ApplicationController
  def index
    companies = Api::V1::Companies::Index.new(params).perform

    render json: companies.as_json
  end
end
