# frozen_string_literal: true

# TODO: move to application controller
# TODO: this should be a constant in model
# TODO: know difference between symbol and string and replace
# TODO: know difference between hash and hash with indifferent access
# TODO: Move business logic to model
# TODO: know about all the callbacks

# Candidate Controller
class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[show edit update destroy]
  include FilterHelper
  def index
    @candidates = Candidate.sort(params[:sort],
                                 params[:type]).page(params[:page]).per(15)
    respond_to do |format|
      format.html
      format.xlsx do
        @download_data = Candidate.sort(params[:sort], params[:type])
        response.headers['Content-Disposition'] = 'attachment;filename="candidates.xlsx"'
      end
    end
  end

  def dashboard
    # redirect to candidate_path
  end

  def filter_result
    @filter_query = if params[:sort].nil?
                      filter_params.to_s
                    else
                      params[:query]
                    end
    @candidates = Candidate.filter_records(
      parse(@filter_query), params[:sort], params[:type]
    ).page(params[:page]).per(15)
    respond_to do |format|
      format.html { render :index }
      format.xlsx do
        @download_data = Candidate.filter_records(
          parse(@filter_query), params[:sort], params[:type]
        )
        render :index
      end
    end
  end

  def counselling_page
    @counselling = Candidate.find(params[:candidate_id]).counsellings
  end

  def save_counselling
    p params[:candidate_id]
    Counselling.create(params[:candidate_id],
                       params[:counselling_date], params[:note])
    redirect_to counsellings_path(candidate_id: params[:candidate_id])
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    respond_to do |format|
      if @candidate.save
        @candidate.update(status_changed: Date.today)
        @candidate.update_source
        format.html { redirect_to @candidate }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        if @candidate.saved_change_to_status?
          @candidate.update(status_changed: Date.today)
        end
        @candidate.update_source
        format.html { redirect_to @candidate }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url }
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(:date_of_registration,
                                      :date_of_closure,
                                      :address,
                                      :age,
                                      :branch,
                                      :contact_number,
                                      :email,
                                      :experience,
                                      :gender,
                                      :name,
                                      :qualification,
                                      :registration_number,
                                      :remarks,
                                      :specialization,
                                      :source_of_registration,
                                      :state,
                                      :status,
                                      :zone)
  end

  def filter_params
    params.slice(:date_of_registration,
                 :date_of_closure,
                 :source_of_registration,
                 :zone,
                 :name,
                 :branch,
                 :state,
                 :status,
                 :custom_day,
                 :query,
                 :format,
                 :type,
                 :sort)
  end

  def parse(parameters)
    parameters = JSON.parse parameters.to_s.gsub('=>', ':')
    parameters = parameters.delete_if { |_key, value| value.blank? }
    parameters = date_params(parameters)
    parameters
  end
end
