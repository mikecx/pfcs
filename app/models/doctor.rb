# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :resource_id, presence: true, uniqueness: true
  validates :name, presence: true

  has_many :appointments, foreign_key: :actor_reference, primary_key: :resource_id
end
