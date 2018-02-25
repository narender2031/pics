require 'rails_helper'

RSpec.feature "Login", type: :feature do
    it "login tests" do 
        visit login_path 
        fill_in "email", :with => "manu@test.com"
        fill_in "password", :with => "password"
        click_button "LogIn"
    end
end
