class CouncilsController < ApplicationController
  def index
    @council = Council.new
  end
end
