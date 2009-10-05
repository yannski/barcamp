require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "schedule" do
    @expected.subject = 'Notifications#schedule'
    @expected.body    = read_fixture('schedule')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_schedule(@expected.date).encoded
  end

end
