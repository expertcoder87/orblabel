class StaticPagesController < ApplicationController

  def about
  end

  def index
     @bikes = Bike.all.collect{|b| b.certification} - [nil]
  end

  def contact
  end

  def recover_password
    render 'static_pages/recover-password'    
  end

  def signin
  end

  def signup
  end
  


  def terms_of_use
    # render 'static_pages/terms-of-use' 
  end

end
