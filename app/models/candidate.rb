# frozen_string_literal: true

class Candidate < ApplicationRecord
  
  validates :source_of_registration, inclusion: { in: ['R', 'KH'], message: 'Must be selected' }
  validates :name, presence: { message: 'must specified.' }
  validates :gender, presence: { message: 'must specified.' }
  validates :age, presence: { message: 'must specified.' }
  validates :status, presence: { message: 'Status must specified'}
  validates :age, inclusion: { in: 18..60, message: 'must between 1 to 100' }
  validates :email, presence: { message: 'is required.' },
                    uniqueness: { message: 'is already exist.' },
                    format: { with: /@/, message: 'must contain @.' }
  validates :contact_number, presence: {message: 'Contact number must present'},
                    numericality: { message: 'must be numeric'},
                    length: { is: 10, message: 'length must be 10 digits'}
  validates :date_of_registration, presence: {mesage: 'must be specified'}
  validate :check_date_of_registration

  def check_date_of_registration
    unless date_of_closure.blank?
      if date_of_registration >= date_of_closure
        errors.add(:date_of_registration,'must be less than Date of Closure')
      end
    end
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
  # OPTIMISE: Know difference between find_by_id and find. Its usage and benchmarking
  # FIXME: add apaces before and after operator
  def self.filter_records(filter_params, sort_field = 'registration_number', sort_type = 'ASC')
    filter_result = Candidate.all
    filter_params.each do |field, value|
      case field
      when 'date_of_registration', 'date_of_closure'
        unless value.blank?
          start_date, end_date = value.split(' - ')
          filter_result = filter_result.where("#{field} BETWEEN ? AND ?", start_date, end_date)
        end
      when 'custom_day'
        unless value.blank?
          current_date = Date.today
          case value
          when 'Greater than 365 days'
            required_date = current_date - 365
            filter_result = filter_result.where('date_of_registration < ?', required_date)
          when 'Between 180 to 365 days'
            start_date = current_date - 365
            end_date = current_date - 180
            filter_result = filter_result.where('date_of_registration BETWEEN ? AND ?', start_date, end_date)
          when 'Between 60 to 180 days'
            start_date = current_date - 180
            end_date = current_date - 60
            filter_result = filter_result.where('date_of_registration BETWEEN ? AND ?', start_date, end_date)
          else
            required_date = current_date - 60
            filter_result = filter_result.where('date_of_registration >= ?', required_date)
          end
        end
      else
        unless value.blank?
          filter_result = filter_result.where("#{field}": value.to_s)
        end
      end
    end
    filter_result = if sort_type == 'ASC'
                      filter_result.order(sort_field.to_sym)
                    else
                      filter_result.order(sort_field.to_sym).reverse_order
                    end
    filter_result
  end
end
