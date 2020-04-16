require_relative '../rails_helper'
require 'faker'

describe "Zendesk regression testing." do

  first_name = "Kay_First_#{Faker::Name.first_name}"
  last_name = "Kay_Last_#{Faker::Name.last_name}"
  user_email = 'kay444416@ukr.net'
  user_password = '123456789'

  before(:each) do
    visit "https://kay444416.zendesk.com/access/unauthenticated"
  end
  context "Lead creation." do
    let(:default_status) { 'New' }

    before(:each) do
      login(user_email, user_password)
    end

    it "Add Lead." do
      navigate_to_add_lead_pop_up
      fill_add_lead_pop_up(name: first_name, last_name: last_name)
      navigate_to_lead_tab
      click_lead("#{first_name} #{last_name}")
      expect(page).to have_link(default_status)
    end

    context "Lead status change." do
      lead_status = 'Kay_status'

      before(:each) do
        navigate_to_settings
      end

      it "Change lead status to #{lead_status}" do
        edit_lead_status(lead_status)
        expect(is_lead_status_available(lead_status)).to be_truthy
      end

      it "Status change has been applied to lead." do
        navigate_to_lead_tab
        click_lead("#{first_name} #{last_name}")
        expect(page).to have_link(lead_status)
      end
    end

    # reverting all made changes back to initial state.
    after(:all) do
      visit "https://kay444416.zendesk.com/access/unauthenticated"
      login(user_email, user_password)
      navigate_to_settings
      edit_lead_status('New')
      navigate_to_lead_tab
      delete_all_leads
    end

  end
end
