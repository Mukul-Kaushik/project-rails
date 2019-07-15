# frozen_string_literal: true

# Candidate Helper
module CandidatesHelper
  def custom_days_select
    select_tag :custom_day,
               options_for_select(['Greater than 365 days',
                                   'Between 180 to 365 days',
                                   'Between 60 to 180 days',
                                   'Less than 60 days']),
               include_blank: 'Select custom day range',
               class: 'form-control'
  end
end
