class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The @ is what allows us to communicate with the browser
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @word_count = @text.split.size
    # Could also do: text_split_into_array = @text; then @word_count = text_split_into_array.size(or .length or .count)

    text_to_string = s=@text
    @character_count_with_spaces = text_to_string.strip.length

    string_without_spaces = text_to_string.gsub(" ","")
    @character_count_without_spaces = string_without_spaces.length

    string_as_downcase = text_to_string.downcase
    string_without_special_characters = string_as_downcase.gsub(/[^a-z0-9\s]/i,"")
    array_of_text = string_without_special_characters.split
    special_word_as_downcase = @special_word.downcase
    list_of_occurences = array_of_text.grep(special_word_as_downcase)
    @occurrences = list_of_occurences.count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    apr_as_decimal = @apr*0.01
    monthly_rate = apr_as_decimal/12
    numerator = monthly_rate*@principal
    months = @years*12
    denominator = 1-(1+monthly_rate)**-months

    @monthly_payment = numerator/denominator

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    time_in_seconds = @ending-@starting
    @seconds = time_in_seconds
    time_in_minutes = @seconds/60
    @minutes = time_in_minutes
    time_in_hours = @minutes/60
    @hours = time_in_hours
    time_in_days = @hours/24
    @days = time_in_days
    time_in_weeks = @days/7
    @weeks = time_in_weeks
    time_in_years = @days/365.25
    @years = time_in_years

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    if @count.odd?
      @median = @sorted_numbers[(@count-1)/2]
    else
      @median = (@sorted_numbers[(@count/2)-1]+@sorted_numbers[@count/2])/2
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    difference_from_mean = []
    difference_squared = []
    @numbers.each do |num|
      difference = num-@mean
      difference_from_mean.push(difference)
    end
    difference_from_mean.each do |dif|
      squared = dif**2
      difference_squared.push(squared)
    end
    sum_of_squares = difference_squared.sum

    @variance = sum_of_squares/@count

    @standard_deviation = @variance**0.5

    frequency = @numbers.reduce(Hash.new(0)) do
    |h,v|h[v]+=1;h
    end
    @mode = @numbers.max_by{|v|frequency[v]}


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
