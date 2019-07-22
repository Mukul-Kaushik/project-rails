# frozen_string_literal: true

# This shiny device polishes bared foos
class Candidate < ApplicationRecord
  has_many :counsellings
  scope :count_status, -> { group(:status).count }
  scope :count_source_of_registration, -> {group(:source_of_registration).count}
  validates :source_of_registration, inclusion: {
    in: %w[R KH], message: 'Must be selected'
  }
  validates :name, :age, :status, :email, :contact_number, :gender,
            :date_of_registration, presence: { message: 'must specified.' }
  validates :age, inclusion: { in: 1..100, message: 'must between 1 to 100' }
  validates :email, uniqueness: { message: 'is already exist.' },
                    format: { with: /@/, message: 'must contain @.' }
  validates :contact_number, numericality: { message: 'must be numeric' }
  validate :check_date_of_registration

  def check_date_of_registration
    errors.add(:date_of_registration, 'must be less than Date of Closure') \
    if !date_of_closure.blank? && date_of_registration <= date_of_closure
  end

  def update_source
    update(registration_number: 'NZ/' + source_of_registration + '/' + id.to_s)
  end

  def self.get_status(date)
    status = Candidate.where(status_changed: date..date.end_of_month).
    group(:status).count
    src_reg = Candidate.where(status_changed: date..date.end_of_month,
      status: 'Joined').group(:source_of_registration).count
    status.merge(src_reg)
  end
  # TODO: change name to a short name
  # FIXME: Add a space before and after {}

  def self.sort(sort_field, sort_type)
    if sort_field.nil?
      Candidate.order(:registration_number)
    else
      Candidate.order(sort_field + ' ' + sort_type)
    end
  end

  # FIXME: length of any code in a line should be within 80
  # FIXME: add spaces after a period
  # TODO: name shouold be self explanatory
  # OPTIMISE: Know difference between
  # find_by_id and find. Its usage and benchmarking
  # FIXME: add apaces before and after operator

  def self.filter_records(filter_params, sort_field, sort_type)
    filter_result = Candidate.where(filter_params.except('custom_day'))
    filter_result = if filter_params.key?('custom_day')
                      filter_result.where(
                        date_of_registration: filter_params['custom_day']
                      )
                    else
                      filter_result
                    end
    if sort_field.nil?
      filter_result
    else
      filter_result.order(sort_field + ' ' + sort_type)
    end
  end
end
