class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]
  # TODO: move to application controller
  # TODO: this should be a constant in model
    # TODO: know difference between symbol and string and replace 
    # TODO: know difference between hash and hash with indifferent access
  def index
    # TODO: Move business logic to model
    # TODO: know about all the callbacks
    unless params[:sort].nil?
      @candidates = Candidate.sort(params[:sort], params[:type])
    else
      @candidates = Candidate.all
    end
    respond_to do |format|        
      format.html
      format.xlsx {response.headers['Content-Disposition'] = 'attachment; filename="candidates.xlsx"'}  
    end
    
  end

  def dashboard
    redirect to candidate_path
  end

  def filter_result
    unless params[:sort].nil?
      @filter_query = params[:query]
      @candidates = Candidate.filter_records( eval(params[:query]), params[:sort], params[:type])
    else
      @filter_query = filter_params.to_s
      @candidates = Candidate.filter_records( filter_params )
    end
    render "index"
  end
 
  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    respond_to do |format|
      if @candidate.save
        @candidate.update(registration_number: "NZ/" + @candidate.source_of_registration + "/" + @candidate.id.to_s)
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
        @candidate.update(registration_number: "NZ/" + @candidate.source_of_registration + "/" + @candidate.id.to_s)
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
      params.require(:candidate).permit(:date_of_registration, :date_of_closure, :address, :age, :branch, :contact_number, :email, :experience, :gender, :name, :qualification, :registration_number, :remarks, :specialization, :source_of_registration, :state, :status, :zone)
    end

    def filter_params
      params.permit(:date_of_registration,:date_of_closure,:source_of_registration,:zone,:name,:branch,:state,:status,:custom_day)
    end

end
