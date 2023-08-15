require 'csv'
require 'json'

# read the CSV file into an array of hashes
data = CSV.read('3421718.csv', headers: true).map(&:to_h)

# create a hash to store the largest TMIN and TMAX for each year
highest_temps_by_year = {}

# iterate over each row in the CSV data
data.each do |row|
  year = row['DATE'][0..3]
  tmax = row['TMAX'].to_i
  tmin = row['TMIN'].to_i

  # initialize the largest temps for the year if necessary
  highest_temps_by_year[year] ||= { highest_tmax: -Float::INFINITY, highest_tmin: -Float::INFINITY }

  # update the largest temps for the year if necessary
  if tmax > highest_temps_by_year[year][:highest_tmax]
    highest_temps_by_year[year][:highest_tmax] = tmax
  end
  if tmin > highest_temps_by_year[year][:highest_tmin]
    highest_temps_by_year[year][:highest_tmin] = tmin
  end
end

# convert the largest temps by year hash to a JSON array
json_data = highest_temps_by_year.sort.map { |year, temps| [year, temps] }

# write the JSON array to a file
File.open('highest_temps_by_year.json', 'w') do |file|
  file.write(JSON.pretty_generate(json_data))
end