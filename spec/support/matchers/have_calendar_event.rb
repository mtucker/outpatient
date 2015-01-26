3
module Capybara
  module RSpecMatchers
    class HaveCalendarEvent < Matcher
      attr_reader :failure_message, :failure_message_when_negated

      def initialize(title, starts_at, ends_at, count = nil)
        @title = title
        @starts_at = starts_at
        @ends_at = ends_at
        @count = count
      end

      def matches?(actual)
        wrap(actual).assert_text("#{@starts_at.strftime('%l:%M')} - #{@ends_at.strftime('%l:%M')} #{@title}", count: @count)
      rescue Capybara::ExpectationNotMet => e
        @failure_message = e.message
        return false
      end

      def does_not_match?(actual)
        wrap(actual).assert_no_text("#{@starts_at.strftime('%l:%M')} - #{@ends_at.strftime('%l:%M')}")
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

    def have_calendar_event(expected_title, expected_starts_at, expected_ends_at, count = nil)
      HaveCalendarEvent.new(expected_title, expected_starts_at, expected_ends_at, count)
    end

  end
end