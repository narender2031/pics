require 'rails_helper'

RSpec.feature "Register", type: :feature do
  it "Register tests" do 
      visit register_path 
      fill_in "first_name", :with => "attul"
      fill_in "last_name", :with => "test"
      fill_in "user_name", :with => "atull_2031"
      fill_in "email", :with => "atul@te.co"
      fill_in "password", :with => "password"
      fill_in "phone", :with => "9876543567"
      click_button "SignUp"
      sleep 10
  end
end

