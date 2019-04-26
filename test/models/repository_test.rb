# frozen_string_literal: true

require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  setup do
    @repository = Repository.new(
      language: :python,
      name: 'paper_trail',
      full_name: 'apache/airflow',
      description: 'Apache Airflow',
      url: 'https://github.com/apache/airflow',
      owner_login: 'apache',
      owner_avatar_url: 'https://avatars0.githubusercontent.com/u/47359?v=4',
      forks: 200,
      open_issues: 307,
      stargazers_count: 500
    )
  end

  test 'valid repository' do
    assert @repository.valid?
  end

  test 'invalid without language' do
    @repository.language = nil

    refute @repository.valid?, 'repository is valid without a language'

    assert_not_nil @repository.errors[:language],
                   'no validation error for language present'
  end

  test 'invalid without name' do
    @repository.name = nil

    refute @repository.valid?, 'repository is valid without a name'

    assert_not_nil @repository.errors[:name],
                   'no validation error for name present'
  end

  test 'invalid without full_name' do
    @repository.full_name = nil

    refute @repository.valid?, 'repository is valid without a full_name'

    assert_not_nil @repository.errors[:full_name],
                   'no validation error for name full_name'
  end

  test 'invalid without url' do
    @repository.url = nil

    refute @repository.valid?, 'repository is valid without a url'

    assert_not_nil @repository.errors[:url],
                   'no validation error for name url'
  end

  test 'invalid without owner_login' do
    @repository.owner_login = nil

    refute @repository.valid?, 'repository is valid without a owner_login'

    assert_not_nil @repository.errors[:owner_login],
                   'no validation error for name owner_login'
  end

  test 'invalid without forks' do
    @repository.forks = nil

    refute @repository.valid?, 'repository is valid without a forks'

    assert_not_nil @repository.errors[:forks],
                   'no validation error for name forks'
  end

  test 'invalid without open_issues' do
    @repository.open_issues = nil

    refute @repository.valid?, 'repository is valid without a open_issues'

    assert_not_nil @repository.errors[:open_issues],
                   'no validation error for name open_issues'
  end

  test 'invalid without stargazers_count' do
    @repository.stargazers_count = nil

    refute @repository.valid?, 'repository is valid without a stargazers_count'

    assert_not_nil @repository.errors[:stargazers_count],
                   'no validation error for name stargazers_count'
  end

  test 'language does not have cache' do
    Repository.delete_all

    refute Repository.language_has_cache?(:python),
           'languague should not have cache'
  end

  test 'language has cache' do
    Repository.new(
      language: :python,
      name: 'paper_trail',
      full_name: 'apache/airflow',
      description: 'Apache Airflow',
      url: 'https://github.com/apache/airflow',
      owner_login: 'apache',
      owner_avatar_url: 'https://avatars0.githubusercontent.com/u/47359?v=4',
      forks: 200,
      open_issues: 307,
      stargazers_count: 500
    ).save!

    assert Repository.language_has_cache?(:python),
           'languague should have cache'
  end

  test 'populate repositories from github' do
    Repository.delete_all

    Repository.list_repos(:php)

    assert Repository.where(language: :php).count.positive?
  end

  test 'use repositories from cache' do
    Repository.delete_all

    repository = Repository.new(
      language: :python,
      name: 'paper_trail',
      full_name: 'apache/airflow',
      description: 'Apache Airflow',
      url: 'https://github.com/apache/airflow',
      owner_login: 'apache',
      owner_avatar_url: 'https://avatars0.githubusercontent.com/u/47359?v=4',
      forks: 200,
      open_issues: 307,
      stargazers_count: 500
    )

    repository.save!

    Repository.list_repos(:python)

    assert Repository.where(language: :python, id: repository.id).count.positive?
  end
end
