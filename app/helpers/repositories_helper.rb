# frozen_string_literal: true

# Repositories Helper
module RepositoriesHelper
  def get_badge_color(position)
    case position
    when 1..3
      'success'
    when 4..6
      'primary'
    when 7..10
      'info'
    when 11..30
      'secondary'
    else
      'light'
    end
  end
end
