require 'test/unit'
require 'selenium-webdriver'
require 'capybara'
require 'rspec'
require "rails/all"
require 'capybara/rspec'
require "page-object"
require 'rspec/expectations'
require 'securerandom'
require 'capybara-screenshot/rspec'
require 'launchy'
require 'chunky_png'
require 'nokogiri'
require 'require_all'
require 'os'
require_all './Test_helpers'

RSpec.configure do |config|
  config.include RSpec::Matchers
  config.include Capybara::DSL
  Dir[File.join(File.dirname(__FILE__), './Test_helpers/', '') + "*.rb"].each { |file|
    require_relative file
    name = ''
    File.basename(file).gsub('.rb', '').split("_").map { |ea| ea.capitalize }.each { |e| name << e }
    config.include self.class.const_get(name)
  }
  # Possible browsers: chrome, firefox, safari, opera and poltergeist
  environment = 'chrome'
  enable_sreenshots_comparioson_after_failure = false

  if ["chrome", "firefox", "safari", "opera"].include? environment
    environment == 'chrome' ? (Selenium::WebDriver::Chrome.driver_path = (OS.windows? ? './Resources/chromedriver.exe' : './Resources/chromedriver')) : "Cromedriver need to be set just for Chrome browser."
    environment == 'firefox' ? (Selenium::WebDriver::Firefox.driver_path = (OS.windows? ? './Resources/geckodriver.exe' : './Resources/geckodriver')) : "Geckodriver need to be set just for Firefox browser."

    Capybara.default_driver = :selenium
    Capybara.register_driver :selenium do |app|
      options = {
          :js_errors => false,
          :timeout => 360,
          :debug => false,
          :inspector => false,
      }
      Capybara::Selenium::Driver.new(app, :browser => environment.to_sym)
    end
  elsif environment == "poltergeist"
    Capybara.register_driver :poltergeist do |app|
      options = {
          :js_errors => false,
          :timeout => 360,
          :debug => false,
          :phantomjs_options => ['--load-images=no', '--disk-cache=false'],
          :inspector => false,
          :loggingPrefs => {
              :browser => "ALL",
              :client => "ALL",
              :driver => "ALL",
              :server => "ALL"
          },
      }
      Capybara::Poltergeist::Driver.new(app, options)
    end
  else
    puts "Please set correct 'environment' variable. Should be one of the following: chrome, firefox, safari, opera or poltergeist."
  end

  config.before(:each) do |example_group|
    Capybara.page.driver.browser.manage.window.maximize
  end

  config.after(:each) do |example_group|
    Capybara.save_path = "./Reports/" # path where screenshots are saved
    result_error = example_group.metadata[:example_group][:full_description].to_s + example_group.metadata[:description].to_s
    time = Time.now.strftime('%a_%e_%m_%Y_%l_%M_%p')
    res = "#{result_error} (#{time.to_s})"
    sceenshotname = "../Reports/#{res}"
    if example_group.exception
      save_screenshot(sceenshotname + ".png")
      save_page(sceenshotname + ".html")

      f = File.new("./Reports/#{res}_BROWSER_LOGS.txt", 'w')
      page.driver.browser.manage.logs.get(:browser).each { |e| f << "\n #{e}" }
      f.close

      f = File.new("./Reports/#{res}_DRIVER_LOGS.txt", 'w')
      page.driver.browser.manage.logs.get(:driver).each { |e| f << "\n #{e}" }
      f.close

      exception = example_group.exception
      filename = File.basename(example_group.metadata[:file_path])
      line_number = example_group.metadata[:line_number]
      report = "#{filename}:#{line_number} -> #{result_error}"
      puts "Occured error: #{exception} \n Failed test: #{report} \n Screenshot: '#{sceenshotname}'"
    end
    Capybara.default_max_wait_time = 15
    Capybara.ignore_hidden_elements = false
  end
  ROOT_DIRECTIRY = File.dirname(__FILE__)
end