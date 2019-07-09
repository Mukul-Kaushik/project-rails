# frozen_string_literal: true

# This shiny device polishes bared foos
class Candidate < ApplicationRecord
  validates :source_of_registration, inclusion: {
    in: %w[R KH], message: 'Must be selected'
  }
  validates :name, presence: { message: 'must specified.' }
  validates :gender, presence: { message: 'must specified.' }
  validates :age, presence: { message: 'must specified.' }
  validates :status, presence: { message: 'Status must specified' }
  validates :age, inclusion: { in: 1..100, message: 'must between 1 to 100' }
  validates :email, presence: { message: 'is required.' },
                    uniqueness: { message: 'is already exist.' },
                    format: { with: /@/, message: 'must contain @.' }
  validates :contact_number, presence: { message: 'must present' },
                             numericality: { message: 'must be numeric' }
  validates :date_of_registration, presence: { mesage: 'must be specified' }
  validate :check_date_of_registration

  def check_date_of_registration
    errors.add(:date_of_registration, 'must be less than Date of Closure') \
    unless !date_of_closure.blank? && date_of_registration >= date_of_closure
  end

  # TODO: change name to a short name
  # FIXME: Add a space before and after {}
  def self.sort(sort_field, sort_type)
    if sort_type == 'ASC'
      Candidate.all.order(sort_field.to_sym)
    else
      Candidate.all.order(sort_field.to_sym).reverse_order
    end
  end

  # FIXME: length of any code in a line should be within 80
  # FIXME: add spaces after a period
  # TODO: name shouold be self explanatory
  # OPTIMISE: Know difference between
  # find_by_id and find. Its usage and benchmarking
  # FIXME: add apaces before and after operator

  def self.filter_records(filter_params,
                          sort_field = 'name', sort_type = 'ASC')
    filter_result = Candidate.all
    filter_params.each do |field, value|
      next if value.blank?

      case field
      when 'date_of_registration', 'date_of_closure'
        st_date, en_date = value.split(' - ')
        filter_result = filter_result.where("#{field} BETWEEN ? AND ?",st_date,en_date)
      when 'custom_day'
        filter_result = filter_custom_days(filter_result, value, Date.today)
      else
        filter_result = filter_result.where("#{field}": value.to_s)
      end
    end
    filter_result = if sort_type == 'ASC'
                      filter_result.order(sort_field.to_sym)
                    else
                      filter_result.order(sort_field.to_sym).reverse_order
                    end
    filter_result
  end

  def filter_custom_days(data, value, date)
    f = 'date_of_registration'
    case value
    when 'Greater than 365 days'
      return data.where("#{f} < ?", date - 365)
    when 'Between 180 to 365 days'
      return data.where("#{f} BETWEEN ? AND ?", date - 365, date - 180)
    when 'Between 60 to 180 days'
      return data.where("#{f} BETWEEN ? AND ?", date - 180, date - 60)
    else
      return data.where(" #{f} >= ?", date - 60)
    end
  end
end
