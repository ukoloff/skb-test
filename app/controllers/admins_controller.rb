class AdminsController < ApplicationController
  def show
    @our = Fetcher.new.our
  end

  def create
  end
end
