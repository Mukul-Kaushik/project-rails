# frozen_string_literal: true

# This shiny device polishes bared foos
class Candidate < ApplicationRecord
  validates :source_of_registration, inclusion: {
    in: %w[R KH], message: 'Must be selected'
  }
  validates :name, :age, :status, :email, :contact, :gender,
            :date_of_registration, presence: { message: 'must specified.' }
  validates :age, inclusion: { in: 1..100, message: 'must between 1 to 100' }
  validates :email, uniqueness: { message: 'is already exist.' },
                    format: { with: /@/, message: 'must contain @.' }
  validates :contact_number, numericality: { message: 'must be numeric' }
  validate :check_date_of_registration

  def check_date_of_registration
    errors.add(:date_of_registration, 'must be less than Date of Closure') \
    unless !date_of_closure.blank? && date_of_registration <= date_of_closure
  end

  def self.update_source(src_reg, id)
    candidate = Candidate.find(id)
    candidate.update(registration_number: 'NZ/' + src_reg + '/' + id.to_s)
    candidate.save
  end
  # TODO: change name to a short name
  # FIXME: Add a space before and after {}

  def self.sort(sort_field, sort_type)
    if sort_type == 'ASC'
      Candidate.order(sort_field.to_sym)
    else
      Candidate.order(sort_field.to_sym).reverse_order
    end
  end

  # FIXME: length of any code in a line should be within 80
  # FIXME: add spaces after a period
  # TODO: name shouold be self explanatory
  # OPTIMISE: Know difference between
  # find_by_id and find. Its usage and benchmarking
  # FIXME: add apaces before and after operator

  def self.filter_records(filter_params,
                          sort_field = 'name',
                          sort_type = 'ASC')
    filter_result = Candidate.where(filter_params.except('custom_day'))
    if filter_params.key?('custom_day')
      filter_result = filter_result.where(date_of_registration: filter_params['custom_day'])
    end
    filter_result.order(sort_field + ' ' + sort_type)
  end
end
