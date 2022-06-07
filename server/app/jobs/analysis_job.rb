require 'csv'

class AnalysisJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # require 'ruby-fann'
    # puts 'Hello world!'

    inputs = []
    output = []

    begin
      CSV.foreach('app/assets/real_clinical_data_septic_prediction.csv', headers: true) do |row|
        inputs.push [row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12],
                     row[13], row[14], row[15], row[16], row[17], row[18],
                     row[19], row[20], row[21], row[22], row[23], row[24], row[25]]
        #x_data.push( [row[0].to_f, row[1].to_f] )
        output.push [ row[29], row[30]]
      end
    rescue Exception => error
      return error
    end


    set = (13...20).to_a
    # set.push 2

    inputs.map! do |x|
      i=0
      x.map! do |j|
        i+=1
        if set.include? i
          j.to_f
        else
          j.to_i
        end
      end
    end

=begin
    output.each do |i|
      i.map!(&:to_i)
    end
=end
    output.each do |x|
      x.map!(&:to_f)
      x.map! do |i|
        i = i - 1.0
      end
    end
    # inputs.each do |i|
    #   puts i.inspect
    #   puts i[2].class
    # end
    # output.each { |i| puts i.inspect }

    hidden_neurons_number = ((inputs.first.size + output.first.size) ** 0.5).round + 1
    train = RubyFann::TrainData.new(inputs: inputs, desired_outputs: output)
    fann = RubyFann::Standard.new(num_inputs: 25, hidden_neurons: [8], num_outputs: 2)
    fann.train_on_data(train, 50000, 100, 0.01) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
    fann.save('app/assets/training')
  end
end
