# frozen_string_literal: true

# Application AR
class ApplicationRecord < ActiveRecord::Base
  extend ActiveModel::Naming
  extend ActiveModel::Translation

  self.abstract_class = true
end
