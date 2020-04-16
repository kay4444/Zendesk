CHECKBOX_XPATH = '//div[@tabindex="0"]'
DELET_LEAD_POP_UP_XPATH = "//div[div[contains(@class, 'EwJ--ModalLayout--header')]]"

module LeadsHelper

  def click_lead(lead)
    puts "Navigate to details page for '#{lead}' Lead."
    rescue_exceptions { click_button('Clear All')[:disabled] }
    click_link(lead)
  end

  def delete_all_leads
    puts 'Deleting all available Leads.'
    rescue_exceptions { click_button('Clear All')[:disabled] }
    find_all(:xpath, CHECKBOX_XPATH).first.click
    click_button('Delete')
    sleep 2
    find(:xpath, "//div[@class='_23N--AbstractToggle--label']", wait: 5).click
    sleep 2
    all('._30z--Button--content').last.click
  end

end