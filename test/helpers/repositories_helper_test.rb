# frozen_string_literal: true

require 'test_helper'

class RepositoriesHelperTest < ActionView::TestCase
  test 'should return the position badge class' do
    assert_equal 'success', get_badge_color(1)

    assert_equal 'primary', get_badge_color(2)
    assert_equal 'primary', get_badge_color(3)

    assert_equal 'info', get_badge_color(4)
    assert_equal 'info', get_badge_color(5)
    assert_equal 'info', get_badge_color(6)

    assert_equal 'secondary', get_badge_color(7)
    assert_equal 'secondary', get_badge_color(8)
    assert_equal 'secondary', get_badge_color(9)
    assert_equal 'secondary', get_badge_color(10)
  end
end