# frozen_string_literal: true

json.extract! candidate, :id, :date_of_registration, :date_of_closure, :address, :age, :branch, :contact_number, :email, :experience, :gender, :name, :qualification, :registration_number, :remarks, :specialization, :source_of_registration, :state, :status, :zone, :created_at, :updated_at
json.url candidate_url(candidate, format: :json)
