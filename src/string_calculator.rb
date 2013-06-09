class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    # Split string to integer numbers array
    integers = split_string_to_numbers(numbers)

    # We do not allow negative numbers
    if integers.any? { |x| x < 0 } then
      raise ArgumentError, 'negatives not allowed ' + integers.select { |x| x < 0 }.to_s
    end

    # Add all numbers except bigger than 1000
    integers.inject(0) do |sum, number|
      sum + if number <= 1000
        number
      else
        0
      end
    end
  end

  private

  def split_string_to_numbers(numbers)
    # Set default delimiters
    delimiters = [',', "\n"]

    # If there is user defined delimiter(s) extract them to array
    if numbers.start_with?('//') then
      delimiter_str, numbers = numbers.match(/\A\/\/(\S+)\n(.*)/m).captures
      if delimiter_str.start_with?('[') then
        delimiters = delimiter_str.scan(/\[(.*?)\]/).flatten
      else
        delimiters = [delimiter_str] << "\n"
      end
    end

    # Convert number string to array with one string element
    numbers = [numbers]

    # Loop through each delimiter and split numbers string
    delimiters.each do |delimiter|
      split_progress = numbers
      numbers = []

      split_progress.each do |number|
        number.split(delimiter).each { |x| numbers << x  }
      end
    end

    # Convert splitted number string to integers
    numbers = numbers.map do |number|
      number.to_i
    end
  end
end