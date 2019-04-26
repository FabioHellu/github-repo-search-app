# frozen_string_literal: true

# Repositories Controller
class RepositoriesController < ApplicationController
  before_action :setup
  before_action :setup_search, only: :search

  def index; end

  def search
    if valid_languages.include? @language
      @repositories = Repository.list_repos(@language)

      render 'index'
    else
      redirect_to repositories_index_url, status: 302
    end
  end

  def clear
    Repository.delete_all

    flash[:success] = 'O cache de repositórios foi limpo com sucesso.'

    redirect_to repositories_index_url
  end

  private

  def valid_languages
    LanguagesEnum.language.values.to_a
  end

  def setup
    @cached = false
    @repositories = []
    @max_repositories = Repository::MAX_REPOSITORIES
    @languages = LanguagesEnum.language.options
    @language = nil
  end

  def setup_search
    @language = repositories_search_params[:language]
    @cached = Repository.language_has_cache?(@language)
  end

  def repositories_search_params
    params.permit(:language)
  end
end
