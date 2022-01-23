class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
    render json: @patients.as_json
  end

  # GET /patients/1 or /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    #respond_to do |format|
    if @patient.save
      # format.html { redirect_to @patient, notice: "Patient was successfully created." }
      render json: 'Entity saved', status: 200
    else
       render json: @patient.errors, status: :unprocessable_entity
    end
    #end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    #respond_to do |format|
    begin
      @patient = Patient.find params[:id]
    rescue NoMethodError
      render json: 'No patient found', status: :unprocessable_entity
    else
      @patient.update patient_params
      render json: 'Status updated', status: 200
    end
    # end
  end

  def delete
    begin
      @patient = Patient.find_by(id: params[:patient_id])
      @patient.update_attributes!(hospitalized: false)
    rescue NoMethodError
      render json: 'No patient found', status: :unprocessable_entity
    else
      render json: 'Patient recovered', status: 200
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    if @patient.destroy
      # respond_to do |format|
      render json: 'Document destroyed', status: 200
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_patient
    @patient = Patient.find params[:id]
  end
    # Only allow a list of trusted parameters through.
  def patient_params
    params.require(:patient).permit(:AMKA, :name, :surname, :age, { :conditions => [] }, :hospitalized, :sex)
  end

end
