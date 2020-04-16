require 'faker'

FIRST_NAME_FIELD = 'First Name'
LAST_NAME_FIELD = 'Last Name'
MOBILE_NUMBER_FIELD_XPATH = '//div[@data-action="mobile-number-input"]/input'
WORK_NUMBER_FIELD_XPATH = '//div[@data-action="phone-number-input"]/input'
COMPANY_NAME_FIELD_XPATH = '//span[@data-action="lead-company-name-dropdown"]//input'
EMAIL_FIELD_XPATH = '//div[@data-action="email-address-input"]/input'
TITLE_FIELD_XPATH = '//div[@data-action="title-input"]/input'
INDUSTRY_DROPDOWN_XPATH = '//*[@tabindex="4"]'
EXPANDED_DROPDOWN_XPATH = '//div[@tabindex="-1" and contains(@class, "VirtualList")]'
DROPDOWN_ITEMS_XPATH = '//div[@data-item-index]/div'
STREET_FIELD_XPATH = '//div[@data-action="address-street-input"]/input'
CITY_FIELD_XPATH = '//div[@data-action="address-city-input"]/input'
ZIP_FIELD_XPATH = '//div[@data-action="address-zip-input"]/input'
TAGS_FIELD_XPATH = '//input[@tabindex="5"]'
ADD_TAG_BTN_XPATH = '//button[contains(@class, "AddButton")]'
STATE_REGION_FIELD_XPATH = '//div[@data-action="address-state-region-input"]/input'
COUNTRY_DROPDOWN_XPATH = '//button[@tabindex="12"]'
WEBSITE_FIELD_XPATH = '//div[@data-action="website-input"]/input'
SKYPE_FIELD_XPATH = '//div[@data-action="skype-input"]/input'
FACEBOOK_FIELD_XPATH = '//div[@data-action="facebook-input"]/input'
TWITTER_FIELD_XPATH = '//div[@data-action="twitter-input"]/input'
LINKEDIN_FIELD_XPATH = '//div[@data-action="linkedin-input"]/input'
DESCRIPTION_FIELD_XPATH = '//div[@data-action="description-multiline-input"]/textarea'
FAX_FIELD_XPATH = '//div[@data-action="fax-number-input"]/input'

module AddLeadHelper

  def fill_add_lead_pop_up(name: "Kay_First_#{Faker::Name.first_name}", last_name: "Kay_Last_#{Faker::Name.last_name}", mobile_number: Faker::PhoneNumber.cell_phone,
                           work_number: Faker::PhoneNumber.cell_phone, company_name: Faker::Beer.brand,
                           email: Faker::Internet.email, title: Faker::Beer.style, industry: 'Electricity', random_industry: true,
                           street: Faker::Address.street_name, city: Faker::Address.city, zip: Faker::Address.zip_code,
                           tag: Faker::Coffee.intensifier, region: Faker::Address.city, country: 'Argentina', random_country: false,
                           web: Faker::Internet.url, skype: Faker::Internet.username, facebook: Faker::Internet.username,
                           twitter: nil, linkedin: Faker::Internet.username,
                           description: Faker::Movies::HarryPotter.quote, fax: Faker::PhoneNumber.cell_phone)
    puts "Fill all fields in Add Lead pop up and save it."
    perform_action_in_pop_up do
      enter_name name
      enter_last_name last_name
      enter_mobile_number mobile_number
      enter_work_number work_number
      enter_company_name company_name
      enter_email email
      enter_title title
      select_industry option: industry, random_industry: random_industry
      enter_street street
      enter_city city
      enter_zip zip
      enter_tag tag
      enter_region region
      enter_country country: country, random_country: random_country
      enter_web web
      enter_skype skype
      enter_facebook facebook
      enter_twitter twitter
      enter_linkedin linkedin
      enter_description description
      enter_fax fax
      click_button('Save')
    end
  end

  def enter_name(name)
    fill_in(FIRST_NAME_FIELD, with: name)
  end

  def enter_last_name(last_name)
    fill_in(LAST_NAME_FIELD, with: last_name)
  end

  def enter_mobile_number(mobile_number)
    find(:xpath, MOBILE_NUMBER_FIELD_XPATH).set(mobile_number)
  end

  def enter_work_number(work_number)
    find(:xpath, WORK_NUMBER_FIELD_XPATH).set(work_number)
  end

  def enter_company_name(company_name)
    find(:xpath, COMPANY_NAME_FIELD_XPATH).set(company_name)
  end

  def enter_email(email)
    find(:xpath, EMAIL_FIELD_XPATH).set(email)
  end

  def enter_title(title)
    find(:xpath, TITLE_FIELD_XPATH).set(title)
  end

  def select_industry(option: 'Electricity', random_industry: true)
    find(:xpath, INDUSTRY_DROPDOWN_XPATH).click
    within(:xpath, EXPANDED_DROPDOWN_XPATH) do
      if random_industry
        items = find_all(:xpath, DROPDOWN_ITEMS_XPATH)
        items[Faker::Number.between(from: 0, to: items.length)].click
      else
        find(:xpath, DROPDOWN_ITEMS_XPATH, text: option).click
      end
    end
  end

  def enter_street(street)
    find(:xpath, STREET_FIELD_XPATH).set(street)
  end

  def enter_city(city)
    find(:xpath, CITY_FIELD_XPATH).set(city)
  end

  def enter_zip(zip)
    find(:xpath, ZIP_FIELD_XPATH).set(zip)
  end

  def enter_tag(tag)
    find(:xpath, TAGS_FIELD_XPATH).set(tag)
    find(:xpath, ADD_TAG_BTN_XPATH).click
  end

  def enter_region(region)
    find(:xpath, STATE_REGION_FIELD_XPATH).set(region)
  end

  def enter_country(country: 'Australia', random_country: true)
    find(:xpath, COUNTRY_DROPDOWN_XPATH).click
    within(:xpath, EXPANDED_DROPDOWN_XPATH) do
      if random_country
        items = find_all(:xpath, DROPDOWN_ITEMS_XPATH)
        items[Faker::Number.between(from: 0, to: items.length)].click
      else
        find(:xpath, DROPDOWN_ITEMS_XPATH, text: country).click
      end
    end
  end

  def enter_web(web)
    find(:xpath, WEBSITE_FIELD_XPATH).set(web)
  end

  def enter_skype(skype)
    find(:xpath, SKYPE_FIELD_XPATH).set(skype)
  end

  def enter_facebook(facebook)
    find(:xpath, FACEBOOK_FIELD_XPATH).set(facebook)
  end

  def enter_twitter(twitter)
    find(:xpath, TWITTER_FIELD_XPATH).set(twitter)
  end

  def enter_linkedin(linkedin)
    find(:xpath, LINKEDIN_FIELD_XPATH).set(linkedin)
  end

  def enter_description(description)
    find(:xpath, DESCRIPTION_FIELD_XPATH).set(description)
  end

  def enter_fax(fax)
    find(:xpath, FAX_FIELD_XPATH).set(fax)
  end

end
