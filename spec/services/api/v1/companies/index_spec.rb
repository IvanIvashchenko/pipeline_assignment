# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Companies::Index do
  describe '#perform' do
    subject(:perform) { described_class.new(params).perform }

    let(:first_company) do
      create(:company, name: 'Trantow-Herman', industry: 'Education', employee_count: 999, created_at: 10.days.ago)
    end
    let(:second_company) do
      create(:company, name: 'Bailey and Sons', industry: 'Paper & Forest', employee_count: 700, created_at: 5.days.ago)
    end
    let!(:third_company) do
      create(:company, name: 'Zemlak LLC', industry: 'Music', employee_count: 95, created_at: 3.days.ago)
    end

    before do
      create(:deal, company: first_company, amount: 300)
      create(:deal, company: first_company, amount: 1200)
      create(:deal, company: first_company, amount: 150)
      create(:deal, company: second_company, amount: 500)
    end

    context 'when no params provided' do
      let(:params) { {} }

      it 'returns all companies' do
        expect(perform[:data].pluck(:name)).to eq(['Zemlak LLC', 'Bailey and Sons', 'Trantow-Herman'])
      end
    end

    context 'when company name parameter provided' do
      let(:params) do
        {
          company: 'Zemlak L'
        }
      end

      it 'returns matched companies' do
        expect(perform[:data].pluck(:name)).to eq(['Zemlak LLC'])
      end
    end

    context 'when industry parameter provided' do
      let(:params) do
        {
          industry: 'Paper &'
        }
      end

      it 'returns matched companies' do
        expect(perform[:data].pluck(:name)).to eq(['Bailey and Sons'])
      end
    end

    context 'when employee count parameter provided' do
      let(:params) do
        {
          employee: 111
        }
      end

      it 'returns matched companies' do
        expect(perform[:data].pluck(:name)).to eq(['Bailey and Sons', 'Trantow-Herman'])
      end
    end

    context 'when deals amount parameter provided' do
      let(:params) do
        {
          amount: 1500
        }
      end

      it 'returns matched companies' do
        expect(perform[:data].pluck(:name)).to eq(['Trantow-Herman'])
      end
    end
  end
end
