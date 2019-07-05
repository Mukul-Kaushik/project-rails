# frozen_string_literal: true

require 'application_system_test_case'

class CandidatesTest < ApplicationSystemTestCase
  setup do
    @candidate = candidates(:one)
  end

  test 'visiting the index' do
    visit candidates_url
    assert_selector 'h1', text: 'Candidates'
  end

  test 'creating a Candidate' do
    visit candidates_url
    click_on 'New Candidate'

    fill_in 'Address', with: @candidate.address
    fill_in 'Age', with: @candidate.age
    fill_in 'Branch', with: @candidate.branch
    fill_in 'Contact number', with: @candidate.contact_number
    fill_in 'Date of closure', with: @candidate.date_of_closure
    fill_in 'Date of registration', with: @candidate.date_of_registration
    fill_in 'Email', with: @candidate.email
    fill_in 'Experience', with: @candidate.experience
    fill_in 'Gender', with: @candidate.gender
    fill_in 'Name', with: @candidate.name
    fill_in 'Qualification', with: @candidate.qualification
    fill_in 'Registration number', with: @candidate.registration_number
    fill_in 'Remarks', with: @candidate.remarks
    fill_in 'Source of registration', with: @candidate.source_of_registration
    fill_in 'Specialization', with: @candidate.specialization
    fill_in 'State', with: @candidate.state
    fill_in 'Status', with: @candidate.status
    fill_in 'Zone', with: @candidate.zone
    click_on 'Create Candidate'

    assert_text 'Candidate was successfully created'
    click_on 'Back'
  end

  test 'updating a Candidate' do
    visit candidates_url
    click_on 'Edit', match: :first

    fill_in 'Address', with: @candidate.address
    fill_in 'Age', with: @candidate.age
    fill_in 'Branch', with: @candidate.branch
    fill_in 'Contact number', with: @candidate.contact_number
    fill_in 'Date of closure', with: @candidate.date_of_closure
    fill_in 'Date of registration', with: @candidate.date_of_registration
    fill_in 'Email', with: @candidate.email
    fill_in 'Experience', with: @candidate.experience
    fill_in 'Gender', with: @candidate.gender
    fill_in 'Name', with: @candidate.name
    fill_in 'Qualification', with: @candidate.qualification
    fill_in 'Registration number', with: @candidate.registration_number
    fill_in 'Remarks', with: @candidate.remarks
    fill_in 'Source of registration', with: @candidate.source_of_registration
    fill_in 'Specialization', with: @candidate.specialization
    fill_in 'State', with: @candidate.state
    fill_in 'Status', with: @candidate.status
    fill_in 'Zone', with: @candidate.zone
    click_on 'Update Candidate'

    assert_text 'Candidate was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Candidate' do
    visit candidates_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Candidate was successfully destroyed'
  end
end
