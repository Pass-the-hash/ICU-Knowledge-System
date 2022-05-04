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
      @instance = "Δε βρέθηκε ρύθμιση δικτύου"
    end
  end

  def outcomes(data)
    result = @instance.run data
    puts result.inspect
=begin
    result[1] = Float(result[1]).round
    result[2] = Float(result[2]).round
=end
    result
  end

end
