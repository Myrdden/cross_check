require './lib/decor/rec'

class ParseCSV
  extend Recursive
  def parse(filepath) #:: Filepath -> [Hash]
    input = IO.readlines(filepath)
    lines = input.map do |line|
      line.chomp.split(/,/).map {|x| x[0] == "\"" ? x[1..-2] : x}
    end
    @keys = lines.shift.map {|key| key.to_sym}
    output = []
    lines.each {|line| output << hashify(@keys.dup, line, {})}
    return output
  end

  rec def hashify(keysIn, valuesIn, out)
    return out if keysIn.empty? || valuesIn.empty?
    key, *keys = keysIn
    value, *values = valuesIn
    out[key] = value
    hashify(keys, values, out)
  end
end

dummy = ParseCSV.new
puts dummy.parse("data/game.csv")