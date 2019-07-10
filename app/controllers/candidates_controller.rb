# frozen_string_literal: true

# Candidate Controller
class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[show edit update destroy]
  RECORDS_PER_PAGE = 2
  # TODO: move to application controller
  # TODO: this should be a constant in model
  # TODO: know difference between symbol and string and replace
  # TODO: know difference between hash and hash with indifferent access
  # TODO: Move business logic to model
  # TODO: know about all the callbacks
  def index
    @page = (params[:page] || 0).to_i
    #@can = Candidate.order(:registration_number).limit(RECORDS_PER_PAGE).offset(RECORDS_PER_PAGE * @page)
    @candidates = if params[:sort].nil?
                    Candidate.order(:registration_number).limit(RECORDS_PER_PAGE).offset(RECORDS_PER_PAGE * @page)
                  else
                    Candidate.sort(@page, params[:sort], params[:type])
                  end
    @count = @candidates.count
    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = 'attachment;filename="candidates.xlsx"' }
    end
  end

  def dashboard
    redirect to candidate_path
  end

  def filter_result
    if params[:sort].nil?
      @filter_query = filter_params.delete_if { |_key, value| value.blank? }.to_s
      @candidates = Candidate.filter_records(filter_params)
    else
      @filter_query = params[:query]
      @candidates = Candidate.filter_records(
        eval(params[:query]), params[:sort], params[:type]
      )
    end
    respond_to do |format|
      format.html { render :index }
      format.xlsx { render :index }
    end
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    respond_to do |format|
      if @candidate.save
        Candidate.update_source(@candidate.source_of_registration,@candidate.id)
        format.html { redirect_to @candidate }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        Candidate.update_source(@candidate.source_of_registration,@candidate.id)
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
      format.json { head :no_content }
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
    params.require(:candidate).permit(
      :date_of_registration, :date_of_closure,
                                      :address, :age, :branch, :contact_number,
                                      :email, :experience, :gender, :name,
                                      :qualification, :registration_number,
                                      :remarks, :specialization,
                                      :source_of_registration, :state,
                                      :status, :zone)
  end

  def filter_params
    params.permit(:date_of_registration, :date_of_closure,
                  :source_of_registration, :zone, :name, :branch,
                  :state, :status, :custom_day, :query, :format, :type)
  end

end
