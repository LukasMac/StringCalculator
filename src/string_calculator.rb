class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?

    # Split string to integer numbers array
    integers = split_string_to_numbers(numbers)

    # Validate
    validate_input(integers)

    # Add all numbers except bigger than 1000
    integers.inject(0) do |sum, number|
      if number <= 1000
        sum + number
      else
        sum
      end
    end
  end

  private

  def default_delimiters
    [',', "\n"]
  end

  # Validate input. Raise ArgumentError if negative number found
  def validate_input(integers)
    # We do not allow negative numbers
    if integers.any? { |x| x < 0 } then
      raise ArgumentError, 'negatives not allowed ' + integers.select { |x| x < 0 }.to_s
    end
  end


  # Extract delimiters and numbers from given String calculator parameter
  def extract_delimiters_and_numbers(numbers_str)
    # Set default delimiters
    delimiters = default_delimiters

    # If there is user defined delimiter(s) extract them to array
    if numbers_str.start_with?('//')
      delimiter_str, numbers_str = numbers_str.match(/\A\/\/(\S+)\n(.*)/m).captures

      # If we have multiple delimiters defined, extract them to array
      # Otherwise just return that single delimiter and also include new line as delimiter
      if delimiter_str.start_with?('[') then
        delimiters = delimiter_str.scan(/\[(.*?)\]/).flatten
      else
        delimiters = [delimiter_str] << "\n"
      end
    end

    [delimiters, [numbers_str]]
  end


  # Split string of delimited number and return them as array of integers
  def split_string_to_numbers(numbers_str)
    delimiters, numbers = extract_delimiters_and_numbers(numbers_str)

    # Loop through each delimiter and split numbers string
    delimiters.each do |delimiter|
      split_progress = numbers
      numbers = []

      split_progress.each do |number|
        number.split(delimiter).each { |x| numbers << x  }
      end
    end

    # Convert splitted number string to integers
    numbers.map { |number| number.to_i }
  end
end