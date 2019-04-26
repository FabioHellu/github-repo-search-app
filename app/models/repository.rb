# frozen_string_literal: true

# Repository Model
class Repository < ApplicationRecord
  MAX_REPOSITORIES = 10

  include LanguagesEnum

  validates :name, :full_name, :language, :owner_login,
            presence: true, allow_blank: false, allow_nil: false
  validates :name, :full_name, length: { minimum: 2, maximum: 255 }
  validates :url, presence: true, allow_blank: false, allow_nil: false
  validates :forks, :open_issues, :stargazers_count,
            numericality: { only_integer: true },
            presence: true,
            allow_blank: false,
            allow_nil: false

  def self.list_repos(language)
    repos = where(language: language).limit(MAX_REPOSITORIES).all

    return repos if repos.length.positive?

    client = Octokit::Client.new

    query   = "language:#{language}"
    options = { sort: 'stars', order: 'desc', per_page: (MAX_REPOSITORIES + 5) }

    repos = client.search_repositories(query, options)

    return [] unless repos[:total_count].positive?

    repos[:items].each do |repo|
      save_repo language, repo
    end

    repos = where(language: language).limit(MAX_REPOSITORIES).all

    return repos if repos.length.positive?

    []
  end

  def self.save_repo(language, repo)
    new_repo = new(
      language: language,
      name: repo[:name],
      full_name: repo[:full_name],
      description: repo[:description],
      url: repo[:html_url],
      owner_login: repo[:owner][:login],
      owner_avatar_url: repo[:owner][:avatar_url],
      forks: repo[:forks],
      open_issues: repo[:open_issues_count],
      stargazers_count: repo[:stargazers_count]
    )

    new_repo.save! if new_repo.valid?
  end

  def self.language_has_cache?(language)
    where(language: language).count.positive?
  end
end
