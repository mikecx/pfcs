# frozen_string_literal: true

require 'rails_helper'

describe Address, type: :model do
  subject(:address) { build(:address) }

  it 'has a valid factory' do
    expect(address).to be_valid
  end

  describe 'Validations' do
    specify(:aggregate_failures) do
      expect(address).to validate_presence_of(:lines)
    end
  end

  describe 'Associations' do
    specify(:aggregate_failures) do
      expect(address).to belong_to(:resource)
    end
  end
end
