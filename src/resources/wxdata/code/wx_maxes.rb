require 'csv'

# read the CSV file into a 2D array
data = CSV.read('3421718.csv', headers: true)

# create a hash to store the highest TMAX values for each month and year
highest_tmax_values = {}

# iterate over each row in the data array
data.each do |row|
  # extract the year and month from the DATE column
  date = Date.parse(row['DATE'])
  year = date.year.to_s
  month = date.month.to_s.rjust(2, '0')

  # create a new hash for the year if it doesn't exist yet
  highest_tmax_values[year] ||= {}

  # update the highest TMAX value for the month if the current row's TMAX value is higher
  if !highest_tmax_values[year][month] || row['TMAX'].to_i > highest_tmax_values[year][month]
    highest_tmax_values[year][month] = row['TMAX'].to_i
  end
end

# create a new header row for the output CSV
header_row = ['STATION', 'NAME', 'YEAR', 'MONTH', 'TMAX']

# create a new array to store the output CSV data
output_data_array = []

# iterate over each year in the highest TMAX values hash
highest_tmax_values.each do |year, year_data|
  # iterate over each month in the year hash
  year_data.each do |month, tmax|
    # create a new row for the output CSV
    output_row = [data[0]['STATION'], data[0]['NAME'], year, month, tmax]

    # add the output row to the output data array
    output_data_array << output_row
  end
end

# write the output CSV to a new file
CSV.open('3421718_maxes.csv', 'w') do |csv|
  csv << header_row
  output_data_array.each { |row| csv << row }
end