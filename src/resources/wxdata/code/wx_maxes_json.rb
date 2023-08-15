require 'csv'
require 'json'

# read the CSV file into a 2D array
data = CSV.read('3421718_maxes.csv')

# convert the data array to an array of arrays
rows = data.map { |row| row.to_a }

# write the rows array to a JSON file
File.open('3421718_maxes.json', 'w') do |file|
  file.write(JSON.pretty_generate(rows))
end