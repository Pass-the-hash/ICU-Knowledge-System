class NeuralNetwork
  include Singleton

  attr_accessor :instance

  def initialize
    super
    @path = 'app/assets/training'
    if File.exist? @path
      @instance = RubyFann::Standard.new(filename: @path)
      # @network.get_total_connections
    else
      @error = AnalysisJob.perform_now
      puts @error.inspect
      # return error if error
      @instance = RubyFann::Standard.new(filename: @path)
    end
  end

  def outcomes(data)
    # puts @error.inspect
    # puts @error.is_a? Exception
    return @error if @error.is_a? Exception
    result = @instance.run data
    puts result.inspect
=begin
    result[1] = Float(result[1]).round
    result[2] = Float(result[2]).round
=end
    result
  end

end
