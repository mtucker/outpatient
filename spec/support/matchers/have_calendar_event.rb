
module Capybara
  module RSpecMatchers
    class HaveCalendarEvent < Matcher
      attr_reader :failure_message, :failure_message_when_negated

      def initialize(start_dttm, end_dttm, count = nil)
        @start_dttm = start_dttm
        @end_dttm = end_dttm
        @count = count
      end

      def matches?(actual)
        wrap(actual).assert_text("#{@start_dttm.strftime('%l:%M')} - #{@end_dttm.strftime('%l:%M')}", count: @count)
      rescue Capybara::ExpectationNotMet => e
        @failure_message = e.message
        return false
      end

      def does_not_match?(actual)
        wrap(actual).assert_no_text("#{@start_dttm.strftime('%l:%M')} - #{@end_dttm.strftime('%l:%M')}")
      rescue Capybara::ExpectationNotMet => e
        @failure_message_when_negated = e.message
        return false
      end

      def description
        "have #{query.description}"
      end

      def query
        @query ||= Capybara::Query.new(*@args)
      end

    end

    def have_calendar_event(expected_start_dttm, expected_end_dttm, count = nil)
      HaveCalendarEvent.new(expected_start_dttm, expected_end_dttm, count)
    end

  end
end