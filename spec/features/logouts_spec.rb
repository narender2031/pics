require 'rails_helper'

RSpec.feature "Logout", type: :feature do
  it "logout tests" do 
      visit logout_path 
  end
end
