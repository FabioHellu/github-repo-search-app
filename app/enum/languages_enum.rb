# frozen_string_literal: true

# Languagues ENUM
module LanguagesEnum
  extend Enumerize
  extend ActiveModel::Naming

  enumerize :language,
            in: { ruby: 1, php: 2, java: 3, go: 4, python: 5 },
            predicates: { prefix: true },
            scope: true,
            i18n_scope: 'enumerize.languages'
end