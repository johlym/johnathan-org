require 'csv'

# read the CSV file into a 2D array
data = CSV.read('3421718.csv', headers: true)

# create a hash to store the counts by year
counts_by_year = {}

# iterate over each row in the data array
data.each do |row|
  # extract the year from the DATE column
  date = Date.parse(row['DATE'])
  year = date.year.to_s

  # increment the count for the year if the TMAX value is greater than 90
  if row['TMAX'].to_i > 90
    counts_by_year[year] ||= 0
    counts_by_year[year] += 1
  end
end

# write the counts by year to a CSV file
CSV.open('wx_over90.csv', 'w') do |csv|
  csv << ['YEAR', 'COUNT']
  counts_by_year.each { |year, count| csv << [year, count] }
end

require 'csv'
require 'json'

# read the CSV file into a 2D array
data = CSV.read('wx_over90.csv', headers: true)

# convert the data to a JSON array
json_data = data.map { |row| row.to_h.values }

# write the JSON array to a file
File.open('wx_over90.json', 'w') do |file|
  file.write(JSON.pretty_generate(json_data))
end