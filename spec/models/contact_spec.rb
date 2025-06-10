# frozen_string_literal: true

require 'rails_helper'

describe Contact, type: :model do
  subject(:contact) { build(:contact) }

  it 'has a valid factory' do
    expect(contact).to be_valid
  end

  describe 'Validations' do
    specify(:aggregate_failures) do
      expect(contact).to validate_presence_of(:value)
    end
  end

  describe 'Associations' do
    specify(:aggregate_failures) do
      expect(contact).to belong_to(:resource)
    end
  end
end
