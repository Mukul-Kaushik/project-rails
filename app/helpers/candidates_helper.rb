# frozen_string_literal: true

# Candidate Helper
module CandidatesHelper

  def states_select
    select_tag :state,options_for_select( ["Andhra Pradesh",
    "Arunachal Pradesh","
    Assam",
    "Bihar",
    "Chhattisgarh",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Punjab",
    "Pondicherry",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
    ]),include_blank:"State",class: "form-control"
  end

  def status_select
    select_tag :status,options_for_select(["Pending",
    "Joined",
    "Joining",
    "Studying",
    "Not interested",
    "Not responding"
    ]),include_blank:"Status",class: "form-control"
  end

  def custom_days_select
    select_tag :custom_day,options_for_select([
    "Greater than 365 days",
    "Between 180 to 365 days",
    "Between 60 to 180 days",
    "Less than 60 days"
    ]),include_blank:"Select custom day range",class: "form-control"
  end

end
