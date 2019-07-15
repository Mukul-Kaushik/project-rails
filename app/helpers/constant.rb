# frozen_string_literal: true

# Controller constants
module Constant
  CUSTOM_DAY_SELECT = { 'Greater than 365 days' => (Date.today - 20.year)..(Date.today - 365),
                        'Between 180 to 365 days' => (Date.today - 365)..(Date.today - 180),
                        'Between 60 to 180 days' => (Date.today - 180)..(Date.today - 60),
                        'Less than 60 days' => (Date.today - 60)..Date.today }.freeze
  def date_params(parameters)
    if parameters.key?('date_of_registration')
      start_date, end_date = parameters['date_of_registration'].split(' - ')
      parameters['date_of_registration'] = start_date..end_date
    end
    if parameters.key?('date_of_closure')
      start_date, end_date = parameters['date_of_closure'].split(' - ')
      parameters['date_of_closure'] = start_date..end_date
    end
    if parameters.key?('custom_day')
      parameters['custom_day'] = CUSTOM_DAY_SELECT[parameters['custom_day']]
    end
    parameters
  end
end
