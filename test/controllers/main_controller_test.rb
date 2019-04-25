# frozen_string_literal: true

require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect to repositories index and show options' do
    get root_url

    assert_equal 301, status

    follow_redirect!

    assert_equal 200, status

    assert_equal '/repositorios', path

    assert_match "TOP #{Repository::MAX_REPOSITORIES} Repositórios no GitHub",
                 @response.body

    assert_match 'Selecione uma Linguagem:', @response.body

    languages = LanguagesEnum.language.values.to_a

    languages.each { |language| assert_match language, @response.body }
  end
end
