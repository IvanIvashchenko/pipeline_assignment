# frozen_string_literal: true

module Api
  module V1
    module Companies
      class Index
        DEFAULT_PER_PAGE = 25

        attr_reader :params

        def initialize(params)
          @params = params
        end

        def perform
          {
            data: companies_data.to_a,
            total_pages: companies_data.total_pages
          }
        end

        private

        def companies_data
          @companies_data ||= Company
                                .select('companies.*, SUM(deals.amount) AS total_amount')
                                .joins('LEFT JOIN deals ON companies.id = deals.company_id')
                                .then { apply_name_filter(_1) }
                                .then { apply_industry_filter(_1) }
                                .then { apply_employee_filter(_1) }
                                .then { apply_deals_amount_filter(_1) }
                                .then { apply_pagination(_1) }
                                .then { _1.order(created_at: :desc) }
                                .group('companies.id')
        end

        def apply_name_filter(scope)
          return scope if params[:company].blank?

          scope.where('companies.name LIKE ?', "#{sanitized_param(params[:company])}%")
        end

        def apply_industry_filter(scope)
          return scope if params[:industry].blank?

          scope.where('companies.industry LIKE ?', "#{sanitized_param(params[:industry])}%")
        end

        def apply_employee_filter(scope)
          return scope if params[:employee].blank?

          scope.where('companies.employee_count >= ?', params[:employee])
        end

        def apply_deals_amount_filter(scope)
          return scope if params[:amount].blank?

          scope.having('total_amount >= ?', params[:amount])
        end

        def apply_pagination(scope)
          scope.page(params[:page]).per(params[:per_page].presence || DEFAULT_PER_PAGE)
        end

        def sanitized_param(param)
          param.strip.gsub('%', '\%')
        end
      end
    end
  end
end
