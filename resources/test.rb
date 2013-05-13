require "selenium-webdriver"
require "rspec"
include RSpec::Expectations

describe "Test" do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://fullonsms.com/"
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_" do
    @driver.get(@base_url + "/login.php")
    @driver.find_element(:id, "MobileNoLogin").clear
    @driver.find_element(:id, "MobileNoLogin").send_keys "9437267659"
    @driver.find_element(:id, "LoginPassword").clear
    @driver.find_element(:id, "LoginPassword").send_keys "72310"
    @driver.find_element(:css, "input[type=\"image\"]").click
    @driver.find_element(:css, "a[title=\"close\"] > img").click
    @driver.find_element(:link, "Send SMS Now").click
    @driver.find_element(:id, "MobileNos").clear
    @driver.find_element(:id, "MobileNos").send_keys "9437267659"
    @driver.find_element(:id, "Message").clear
    @driver.find_element(:id, "Message").send_keys "Test Message For Selenium IDE Testing."
    @driver.find_element(:css, "img").click
    @driver.find_element(:link, "Logout").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
  
  def close_alert_and_get_its_text(how, what)
    alert = @driver.switch_to().alert()
    alert_text = alert.text
    if (@accept_next_alert) then
      alert.accept()
    else
      alert.dismiss()
    end
    alert_text
  ensure
    @accept_next_alert = true
  end
end
