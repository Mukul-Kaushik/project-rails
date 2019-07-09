# frozen_string_literal: true
class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[show edit update destroy]
  # TODO: move to application controller
  # TODO: this should be a constant in model
  # TODO: know difference between symbol and string and replace
  # TODO: know difference between hash and hash with indifferent access
  def index
    #     TODO: Why to use all?
    @candidates = params[:sort].nil? ? Candidate.all : Candidate.sort(params[:sort], params[:type])
    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="candidates.xlsx"' }
    end
  end

#   TODO: If you don't need dashboard then why you keep it?
  def dashboard
    redirect to candidate_path
  end

  def filter_result
#     TODO: rubocop must show this as warning. if with nil? why don't you use unless params[:sort] ??
    if params[:sort].nil?
#       TODO: instead of manupulating params with delete use strong parameters. 
      @filter_query = filter_params.delete_if{|key, value| value.blank?}.to_s
      @candidates = Candidate.filter_records(filter_params)
    else
      @filter_query = params[:query]
#       TODO: evel no way. its dangerous and opens door to hack the system.
      @candidates = Candidate.filter_records(eval(params[:query]), params[:sort], params[:type])
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
#     TODO: we are not using json. its html only. Please clean code and avoid using scaffolding which I have already told you.
    @candidate = Candidate.new(candidate_params)
    respond_to do |format|
      if @candidate.save
#         TODO: move this logic to model callback
        @candidate.update(registration_number: 'NZ/' + @candidate.source_of_registration + '/' + @candidate.id.to_s)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully created.' }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
#         TODO: this one is also not fixed.
        @candidate.update(registration_number: 'NZ/' + @candidate.source_of_registration + '/' + @candidate.id.to_s)
        format.html { redirect_to @candidate, notice: 'Candidate was successfully updated.' }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url, notice: 'Candidate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_candidate
    @candidate = Candidate.find(params[:id])
  end

  def candidate_params
#     TODO: no rubocop warning has been fixed. 
    params.require(:candidate).permit(:date_of_registration, :date_of_closure, :address, :age, :branch, :contact_number, :email, :experience, :gender, :name, :qualification, :registration_number, :remarks, :specialization, :source_of_registration, :state, :status, :zone)
  end

  def filter_params
#     TODO: No rubocop warning has been fixed.
    params.permit(:date_of_registration, :date_of_closure, :source_of_registration, :zone, :name, :branch, :state, :status, :custom_day, :query, :format, :type)
  end
end
