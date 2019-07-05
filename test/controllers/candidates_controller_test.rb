require 'test_helper'

class CandidatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @candidate = candidates(:one)
  end

  test "should get index" do
    get candidates_url
    assert_response :success
  end

  test "should get new" do
    get new_candidate_url
    assert_response :success
  end

  test "should create candidate" do
    assert_difference('Candidate.count') do
      post candidates_url, params: { candidate: { address: @candidate.address, age: @candidate.age, branch: @candidate.branch, contact_number: @candidate.contact_number, date_of_closure: @candidate.date_of_closure, date_of_registration: @candidate.date_of_registration, email: @candidate.email, experience: @candidate.experience, gender: @candidate.gender, name: @candidate.name, qualification: @candidate.qualification, registration_number: @candidate.registration_number, remarks: @candidate.remarks, source_of_registration: @candidate.source_of_registration, specialization: @candidate.specialization, state: @candidate.state, status: @candidate.status, zone: @candidate.zone } }
    end

    assert_redirected_to candidate_url(Candidate.last)
  end

  test "should show candidate" do
    get candidate_url(@candidate)
    assert_response :success
  end

  test "should get edit" do
    get edit_candidate_url(@candidate)
    assert_response :success
  end

  test "should update candidate" do
    patch candidate_url(@candidate), params: { candidate: { address: @candidate.address, age: @candidate.age, branch: @candidate.branch, contact_number: @candidate.contact_number, date_of_closure: @candidate.date_of_closure, date_of_registration: @candidate.date_of_registration, email: @candidate.email, experience: @candidate.experience, gender: @candidate.gender, name: @candidate.name, qualification: @candidate.qualification, registration_number: @candidate.registration_number, remarks: @candidate.remarks, source_of_registration: @candidate.source_of_registration, specialization: @candidate.specialization, state: @candidate.state, status: @candidate.status, zone: @candidate.zone } }
    assert_redirected_to candidate_url(@candidate)
  end

  test "should destroy candidate" do
    assert_difference('Candidate.count', -1) do
      delete candidate_url(@candidate)
    end

    assert_redirected_to candidates_url
  end
end
