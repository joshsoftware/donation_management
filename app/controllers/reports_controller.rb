class ReportsController < ApplicationController

  def collections
    render :collections
  end
  
  def submissions
    render :submissions
  end
end
