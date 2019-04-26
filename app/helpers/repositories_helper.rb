# frozen_string_literal: true

# Repositories Helper
module RepositoriesHelper
  def get_badge_color(position)
    case position
    when 1
      'success'
    when 2..3
      'primary'
    when 4..6
      'info'
    else
      'secondary'
    end
  end
end
