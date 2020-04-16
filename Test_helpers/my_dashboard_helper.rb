LEAD_ITEM_XPATH = '//div[@data-item-index="0"]'
LEAD_TAB_ID = 'nav-item-leads'
SETTINGS_TAB_ID = 'nav-settings'

module MyDashboardHelper

  def navigate_to_add_lead_pop_up()
    puts 'Open Add Lead pop up.'
    click_button('Add', wait: 10)
    find(:xpath, LEAD_ITEM_XPATH, wait: 10).click
  end

  def navigate_to_lead_tab
    find(:id, LEAD_TAB_ID, wait: 3).click
  end

  def navigate_to_settings
    click_link(SETTINGS_TAB_ID, wait: 10)
  end

end