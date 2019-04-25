# frozen_string_literal: true

require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:php)
  end

  test 'should get index' do
    get repositories_index_url

    assert_response :success

    assert_match "TOP #{Repository::MAX_REPOSITORIES} Repositórios no GitHub",
                 @response.body

    assert_match 'Selecione uma Linguagem:', @response.body

    languages = LanguagesEnum.language.values.to_a

    languages.each { |language| assert_match language, @response.body }
  end

  test 'should get search with language' do
    get repositories_search_url(language: @repository.language)

    assert_response :success

    assert_select 'strong', "@#{@repository.full_name}"

    assert_match 'Resultados em Cache', @response.body

    Repository.delete_all

    get repositories_search_url(language: :ruby)

    assert_response :success

    assert_match 'Resultados sem Cache', @response.body
  end

  test 'should get clear' do
    get repositories_clear_url

    assert_response :redirect

    follow_redirect!

    assert_equal '/repositorios', path

    assert_equal 'O cache de repositórios foi limpo com sucesso.',
                 flash[:success]

    get repositories_search_url(language: :ruby)

    assert_response :success

    assert_match 'Resultados sem Cache', @response.body
  end
end
