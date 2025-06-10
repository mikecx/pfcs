# frozen_string_literal: true

class Contact < ApplicationRecord
  enum :system, { email: 0, phone: 1 }, prefix: true
  enum :use, { work: 0, mobile: 1 }, prefix: true

  validates :value, presence: true

  belongs_to :resource, polymorphic: true
end
