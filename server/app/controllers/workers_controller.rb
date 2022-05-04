class WorkersController < ApplicationController
  before_action :authorize_request

  # GET /workers or /workers.json
  def index
    @workers = Worker.all
    render json: @workers.as_json
  end

  # GET /workers/1 or /workers/1.json
  def show
    @worker = Worker.find params[:id]
    render json: @worker.as_json
  end

  # GET /workers/new
  def new
    @worker = Worker.new
  end

  # GET /workers/1/edit
  def edit
  end

  # POST /workers or /workers.json
  def create
    @worker = Worker.new(worker_params)
    respond_to do |format|
      if @worker.save
        # format.html { redirect_to @worker, notice: "Worker was successfully created." }
        format.json { render :show, status: :created, location: @worker }
      else
        # format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @worker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workers/1 or /workers/1.json
  def update
    @worker = Worker.find params[:id]
    if @worker.update(worker_params)
      #format.html { redirect_to @worker, notice: "Worker was successfully updated." }
      render json: "Αποθηκεύτηκαν οι αλλαγές", status: 200
    else
      render json: "Αδύνατη η επεξεργασία", status: 400
    end
  end

  # DELETE /workers/1 or /workers/1.json
  def destroy
    @worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_url, notice: "Worker was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def worker_params
      params.permit(:username, :password, :name, :surname, :age, :email, :domain)
    end
end
