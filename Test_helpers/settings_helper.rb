LEAD_STATUS_FIELD_ID = "name"
LEADS_SIDE_MENU_OPTION_XPATH = '//li[@class="leads"]/a'

module SettingsHelper

  def edit_lead_status status_name
    puts "Changing Lead status to #{status_name}"
    click_lead_option
    click_lead_statuses
    correct_lead_status status_name
  end

  def click_lead_option
    find(:xpath, LEADS_SIDE_MENU_OPTION_XPATH, visible: false).click
  end

  def click_lead_statuses
    click_link 'Lead statuses'
  end

  def correct_lead_status status_name
    within('div#lead-status') do
      click_button('Edit', match: :first)
      fill_in(LEAD_STATUS_FIELD_ID, with: status_name, match: :first)
      click_button 'Save'
    end
  end

  def is_lead_status_available status
    within('div#lead-status') do
      return rescue_exceptions {find('label.control-label', text: status, match: :first, wait: 5)} ? true : false
    end
  end

end