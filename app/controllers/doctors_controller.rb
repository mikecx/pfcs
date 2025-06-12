# frozen_string_literal: true

class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all.order(name: :asc)
  end

  def show
    @doctor = Doctor.find(params[:id])
  end
end
