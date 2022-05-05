class AnalysisController < ApplicationController
  before_action :authorize_request

  Network = NeuralNetwork.instance

  def index
    # @network = self.load_network
    puts Network.inspect
    if Network.is_a? String
      render json: Network, status: 422
    else
      @patients = Patient.where hospitalized: true
      render json: { msg: "Εκκίνηση συστήματος μηχανικής μάθησης", patients: @patients  }, status: 200
    end
  end

  def show
    @data = Information.find_by AMKA: params[:id]
    render json: @data, status: 200
  end

  def create
    @data = Information.create! first_params
    @data.add_to_set dates: Time.now.strftime("%Y-%m-%dT%H:%M:%S")
    puts @data.inspect
    render json: 'Ξεκίνησε καταγραφή δεδομένων', status: 200
  end

  def update
      @data = Information.find_by AMKA: params[:id]

      @data.add_to_set PaO2: data_params[:PaO2] unless data_params[:PaO2].nil?
      @data.add_to_set FiO2: data_params[:FiO2] unless data_params[:FiO2].nil?
      @data.add_to_set PLT: data_params[:PLT] unless data_params[:PLT].nil?
      @data.add_to_set BIL: data_params[:BIL] unless data_params[:BIL].nil?
      #@data.add_to_set GCS: data_params[:GCS] unless data_params[:GCS].nil?
      @data.add_to_set MAP: data_params[:MAP] unless data_params[:MAP].nil?
      @data.add_to_set CR: data_params[:CR] unless data_params[:CR].nil?
      @data.add_to_set UoP: data_params[:UoP] unless data_params[:UoP].nil?
      @data.add_to_set dates: Time.now.strftime("%Y-%m-%dT%H:%M:%S")
      @data.update PCT: data_params[:PCT] unless data_params[:PCT].nil?

      render json: 'Τα δεδομένα ανανεώθηκαν', status: 200
  end

  def calculate
    # @network = NeuralNetwork.instance
    @data = Information.find_by AMKA: params[:analysis_id]
    @patient = Patient.find_by AMKA: params[:analysis_id]
    input = data_filter @data, @patient
    puts input.inspect
    prediction = filter_results Network.outcomes input
    render json: prediction, status: 200
  end

  private
=begin
  def self.load_network
    @path = 'app/assets/training'
    if File.exist? @path
      @network = RubyFann::Standard.new(filename: @path)
      @network.get_total_connections
    else
      @network = "Δε βρέθηκε ρύθμιση δικτύου"
    end
  end
=end

  def data_params
    params.permit( :PaO2, :FiO2, :PLT, :BIL, :MAP , :CR , :UoP)
  end

  def first_params
   params.permit( :AMKA, :ventilation, :location, :inflammation, :organism, :PCT, { :conditions => [] }, :GCS)
  end

  def data_filter(data, patient)
    array = []
    if patient.gender == 'Άντρας'
      gender = 1
    else
      gender = 2
    end
    if data.ventilation
      ventilation = 1
    else
      ventilation = 2
    end
    conditions = conditions_filter(data.conditions)
    array.push patient.age.to_i, gender, data.PCT.to_f, conditions[0], conditions[1], conditions[2], conditions[3], conditions[4], conditions[5], conditions[6],
               conditions[7], conditions[8], conditions[9], data.PaO2[-1].to_f, data.FiO2[-1].to_f, data.PLT[-1].to_f, data.BIL[-1].to_f, data.GCS[-1].to_f, data.MAP[-1].to_f,
               data.CR[-1].to_f, data.UoP[-1].to_i,   ventilation,  data.location.to_i, data.inflammation.to_i, data.organism.to_i

  end
  #.each_with_index {|value, i| array[i+3] = value }
  def conditions_filter(conditions)
    list = ['Διαβήτης', 'Υπέρταση', 'Χρόνια αποφρακτική πνευμονοπάθεια', 'Στεφανιαία νόσος', 'Συμφορητική καρδιακή ανεπάρκεια', 'Xρόνια νεφρική νόσος με διάλυση',
        'Xρόνια νεφρική νόσος χωρίς διάλυση', 'Kολπική μαρμαρυγή', 'Πνευμονικό εμβολή', 'Καρκίνος']
    conditions = list.filter_map do |condition|
      if conditions.include? condition
        condition = 1
      else
        condition = 2
      end
    end
    puts conditions.inspect
    conditions
  end

  def filter_results(results)
    results[0] = 1.0 - results[0]
    results.map! do |x|
      x = x * 100
      x = x.round(2)
    end
  end
end