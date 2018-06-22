class Admin::DashboardController < ApplicationController
  def show
  end

private

http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD'], only: [:show]


end
