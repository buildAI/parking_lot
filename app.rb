require_relative './lib/helper/command_line_helper.rb'

include CommandLineHelper

def process_input(input)
  command, *args = input.split(' ')
  functionality = command_to_functionality[command]
  case command
  when 'create_parking_lot'
    @parking_lot = functionality.call(*args)
    puts "Created a parking lot with #{@parking_lot.size} slots" if @parking_lot
  when 'park'
    park { functionality.call(*args) }
  when 'leave'
    leave { functionality.call(*args) }
  when 'status'
    status { functionality.call }
  when 'registration_numbers_for_cars_with_colour'
    registration_numbers_for_cars_with_colour { functionality.call(*args) }
  when 'slot_numbers_for_cars_with_colour'
    slot_numbers_for_cars_with_colour { functionality.call(*args) }
  when 'slot_number_for_registration_number'
    slot_number_for_registration_number { functionality.call(*args) }
  else
    puts "Invalid command. Exiting."
    exit
  end
end

def main
  if ARGV.length == 1
    begin
      file = File.open(ARGV[0], "r")
    rescue Errno::ENOENT
      puts "File not found. Exiting."
      exit
    end
    file.each_line do |line|
      process_input(line)
    end
  else
    until (input = gets.chomp) == 'exit'
      process_input(input)
    end
  end
end

main()
