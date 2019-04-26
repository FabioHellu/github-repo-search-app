# frozen_string_literal: true

# Main Controller
class MainController < ApplicationController
  def index
    redirect_to repositories_index_url, status: 301
  end
end
