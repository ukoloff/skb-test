class AdminsController < ApplicationController
  def show
    @our = Fetcher.new.our
  end

  def create
    z = Poster.new params
    @our = z.our
    return if @errors = z.errors
    z.save
    redirect_to '/'
  end
end
