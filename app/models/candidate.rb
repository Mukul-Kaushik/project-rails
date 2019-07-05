class Candidate < ApplicationRecord
    validates :source_of_registration, presence:{message:"Source of registration must specified"}
    validates :name, presence:{message:"must specified."}
    validates :gender, presence:{message:"must specified."}
    validates :age, presence: {message:"must specified."}
    validates :age, inclusion: {in:1..100, message: "must between 1 to 100"}
    validates :email, presence:{message:"is required."}, 
              uniqueness: {message:"is already exist."},
              format: {with:/@/,message:"must contain @."}
    
    
    # TODO: change name to a short name
    # FIXME: Add a space before and after {}
    def self.sort(sort_field,sort_type)
        if sort_type == "ASC"
            return Candidate.all.order(sort_field.to_sym)
        else
            return Candidate.all.order(sort_field.to_sym).reverse_order
        end
    end
    # FIXME: length of any code in a line should be within 80
    # FIXME: add spaces after a period
    # TODO: name shouold be self explanatory
    # OPTIMISE: Know difference between find_by_id and find. Its usage and benchmarking
    # FIXME: add apaces before and after operator
    def self.filter_records(filter_params, sort_field = "registration_number", sort_type = "ASC")
        filter_result = Candidate.all
        filter_params.each do |field, value|
            if field == "date_of_registration" || field == "date_of_closure"
                unless value.blank?
                    start_date, end_date = value.split(' - ')
                    filter_result = filter_result.where("#{field} BETWEEN ? AND ?",start_date,end_date)
                end
            elsif field == "custom_day"
                unless value.blank?
                    current_date = Date.today
                    if value == "Greater than 365 days"
                        required_date=current_date-365
                        filter_result = filter_result.where("date_of_registration < ?",required_date)
                    elsif value == "Between 180 to 365 days"
                        start_date = current_date - 365
                        end_date = current_date - 180
                        filter_result = filter_result.where("date_of_registration BETWEEN ? AND ?",start_date,end_date)
                    elsif value == "Between 60 to 180 days"
                        start_date = current_date - 180
                        end_date = current_date - 60
                        filter_result = filter_result.where("date_of_registration BETWEEN ? AND ?",start_date,end_date)
                    else
                        required_date=current_date-60
                        filter_result = filter_result.where("date_of_registration >= ?",required_date)
                    end
                end
            else
                unless value.blank?
                    filter_result = filter_result.where({"#{field}": "#{value}"})
                end
            end
        end
        if sort_type == "ASC"
            filter_result = filter_result.order(sort_field.to_sym)
        else
            filter_result = filter_result.order(sort_field.to_sym).reverse_order
        end
        return filter_result
    end

end
