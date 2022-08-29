# frozen_string_literal: true

require 'test_helper'

class ElectionAuditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @election = elections(:one)
    @question = questions(:one)
    @answer = answers(:one)
    @voter = voters(:one)
    sign_in users(:one)
  end

  test 'should generate audit for election update' do
    patch election_url(@election), params: { election: { end_at: @election.end_at, name: "Banana", settings: @election.settings, start_at: @election.start_at } }
    get election_election_audits_url(@election)

    assert_select 'td', "Banana"
  end

  test 'should generate audit for question update' do
    patch question_url(@question), params: { question: { answer_ids: @question.answer_ids, name: "Barata" } }
    get election_election_audits_url(@election)

    assert_select 'td', "Barata"
  end

  test 'should generate audit for answer update' do
    patch answer_url(@answer), params: { answer: { name: "Beterraba" } }
    get election_election_audits_url(@election)
    
    assert_select 'td', "Beterraba"
  end

  test 'should generate audit for voter update' do
    patch voter_url(@voter), params: { voter: { election_id: @voter.election_id, email: @voter.email, name: "Ronaldo" } }
    get election_election_audits_url(@election)

    assert_select 'td', "Ronaldo"
  end

end
