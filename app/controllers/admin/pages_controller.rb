class Admin::PagesController < ApplicationController
  def home
    render layout: "admin_layout"
  end
end
