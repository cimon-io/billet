# As explained in http://robots.thoughtbot.com/automatically-wait-for-ajax-with-capybara
#
# A better solution may be to introduce omnipotent "ajax in progress" spinner
# and wait till it disappears.
#
# When you have ajax spinner in your application
# just replace finished_all_ajax_requests? with check
# if that element is visible.
RSpec.configure do |config|

  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

end
