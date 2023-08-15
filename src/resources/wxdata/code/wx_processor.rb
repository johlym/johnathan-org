require 'csv'

# read the CSV file into a 2D array
data = CSV.read('3421718.csv', headers: true)

# remove the TMIN and TMAX columns from the data array
data.delete('TMIN')
data.delete('TMAX')

# create a hash to store the pivoted data
pivoted_data = {}

# iterate over each row in the data array
data.each do |row|
  # extract the year and day of year from the DATE column
  date = Date.parse(row['DATE'])
  year = date.year.to_s
  day_of_year = date.yday.to_s.rjust(3, '0')

  # create a new hash for the year if it doesn't exist yet
  pivoted_data[year] ||= {}

  # add the TAVG value to the corresponding day in the year hash
  pivoted_data[year][day_of_year] = row['TAVG']
end

# add leap day to the pivoted data for each year that has it
pivoted_data.each do |year, year_data|
  if Date.leap?(year.to_i)
    year_data['366'] = year_data['365']
  end
end

# create a new header row for the pivoted data
header_row = ['STATION', 'NAME', 'DATE', *pivoted_data.keys]

# create a new array to store the pivoted data
pivoted_data_array = []

# iterate over each unique combination of STATION and NAME in the original data array
data.group_by { |row| [row['STATION'], row['NAME']] }.each do |(station, name), rows|
  # create a new row for each day of the year
  (1..366).each do |day_of_year|
    # create a new row for the pivoted data
    pivoted_row = [station, name]

    # add the DATE column value to the pivoted row with only the Month and Day in MM-DD format
    pivoted_row << Date.parse(rows[day_of_year - 1]['DATE']).strftime('%m-%d')

    # add the TAVG values for each year to the pivoted row
    pivoted_data.each do |year, year_data|
      pivoted_row << year_data[day_of_year.to_s.rjust(3, '0')]
    end

    # add the pivoted row to the pivoted data array
    pivoted_data_array << pivoted_row
  end
end

# write the pivoted data to a new CSV file
CSV.open('3421718_pivoted.csv', 'w') do |csv|
  csv << header_row
  pivoted_data_array.each { |row| csv << row }
end

require 'csv'

# read the CSV file into a 2D array
data = CSV.read('3421718.csv', headers: true)

# remove the TMIN and TAVG columns from the data array
data.delete('TMIN')
data.delete('TAVG')

# create a hash to store the pivoted data
pivoted_data = {}

# iterate over each row in the data array
data.each do |row|
  # extract the year and day of year from the DATE column
  date = Date.parse(row['DATE'])
  year = date.year.to_s
  day_of_year = date.yday.to_s.rjust(3, '0')

  # create a new hash for the year if it doesn't exist yet
  pivoted_data[year] ||= {}

  # add the TMAX value to the corresponding day in the year hash
  pivoted_data[year][day_of_year] = row['TMAX']
end

# add leap day to the pivoted data for each year that has it
pivoted_data.each do |year, year_data|
  if Date.leap?(year.to_i)
    year_data['366'] = year_data['365']
  end
end

# create a new header row for the pivoted data
header_row = ['STATION', 'NAME', 'DATE', *pivoted_data.keys]

# create a new array to store the pivoted data
pivoted_data_array = []

# iterate over each unique combination of STATION and NAME in the original data array
data.group_by { |row| [row['STATION'], row['NAME']] }.each do |(station, name), rows|
  # create a new row for each day of the year
  (1..366).each do |day_of_year|
    # create a new row for the pivoted data
    pivoted_row = [station, name]

    # add the DATE column value to the pivoted row with only the Month and Day in MM-DD format
    pivoted_row << Date.parse(rows[day_of_year - 1]['DATE']).strftime('%m-%d')

    # add the TMAX values for each year to the pivoted row
    pivoted_data.each do |year, year_data|
      pivoted_row << year_data[day_of_year.to_s.rjust(3, '0')]
    end

    # add the pivoted row to the pivoted data array
    pivoted_data_array << pivoted_row
  end
end

# write the pivoted data to a new CSV file
CSV.open('3421718_pivoted_max.csv', 'w') do |csv|
  csv << header_row
  pivoted_data_array.each { |row| csv << row }
end