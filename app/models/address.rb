# frozen_string_literal: true

class Address < ApplicationRecord
  enum :use, { home: 0 }, prefix: true

  validates :lines, presence: true

  belongs_to :resource, polymorphic: true
end
