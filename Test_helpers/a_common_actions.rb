module ACommonActions

  def wait_for(seconds)
    wait = Selenium::WebDriver::Wait.new(:timeout => seconds)
    wait.until {
      return rescue_exceptions { yield }
    }
  end

  def rescue_exceptions
    begin
      yield
    rescue Selenium::WebDriver::Error::NoSuchElementError => e
      puts "The following error has occured: '#{e}'"
      false
    rescue Selenium::WebDriver::Error::StaleElementReferenceError => e
      puts "The following error has occured: '#{e}'"
      false
    rescue Selenium::WebDriver::Error::TimeOutError => e
      puts "The following error has occured: '#{e}'"
      false
    rescue Selenium::WebDriver::Error::UnknownError => e
      puts "The following error has occured: '#{e}'"
      false
    rescue Capybara::ElementNotFound => e
      puts "The following error has occured: '#{e}'"
      false
    rescue NoMethodError => e
      puts "The following error has occured: '#{e}'"
      false
    rescue Selenium::WebDriver::Error::ElementNotInteractableError => e
      puts "The following error has occured: '#{e}'"
      false
    end
  end

  def try_to_find(type_of_locatoe, xpath_locator, visible: true)
    rescue_exceptions { visible ? find(type_of_locatoe.to_sym, xpath_locator) : find(type_of_locatoe.to_sym, xpath_locator, visible: false) }
  end

  def try_to_find_all(type_of_locatoe, xpath_locator, visible=true)
    rescue_exceptions { visible ? find_all(type_of_locatoe.to_sym, xpath_locator) : find_all(type_of_locatoe.to_sym, xpath_locator, visible: false) }
  end

  def perform_action_in_pop_up
    page.switch_to_window page.windows.last
    yield
    page.switch_to_window page.windows.first
  end

  def get_current_date
    #DateTime.now.strftime("%m/%d/%Y")
    DateTime.now
  end

  def hahdle_alert(accept = true)
    accept ? page.driver.browser.switch_to.alert.accept : page.driver.browser.switch_to.alert.deny
  end

  def get_alert_text
    page.driver.browser.switch_to.alert.text
  end

end