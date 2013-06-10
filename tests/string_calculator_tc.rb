require 'test/unit'
require_relative '../src/string_calculator'

#noinspection RubyInstanceMethodNamingConvention
class StringCalculatorTc < Test::Unit::TestCase
  def calc
    StringCalculator.new
  end

  def test_add_emptyString_returnsZero
    result = calc.add('')

    assert_equal 0, result
  end

  def test_add_singleNumber_returnThatNumber
    result = calc.add('1')

    assert_equal 1, result
  end

  def test_add_twoSingleDigitNumbers_returnsTheirSum
    result = calc.add('1,2')

    assert_equal 3, result
  end

  def test_add_twoTwoDigitNumbers_returnsTheirSum
    result = calc.add('10,20')

    assert_equal 30, result
  end

  def test_add_multipleNumbers_returnsTheirSum
    result = calc.add('1,2,3')

    assert_equal 6, result
  end

  def test_add_twoSingleDigitNumbersSeparatedByNewLine_returnsTheirSum
    result = calc.add("1\n2")

    assert_equal 3, result
  end

  def test_add_twoTwoDigitNumbersSeparatedByNewLine_returnsTheirSum
    result = calc.add("10\n20")

    assert_equal 30, result
  end

  def test_add_threeNumbersSeparatedByCommaAndNewLine_returnsTheirSum
    result = calc.add("1,2\n3")

    assert_equal 6, result
  end

  def test_add_changeNumbersDelimiterToSemicolon_returnsNumbersSeparatedBySemicolonSum
    result = calc.add("//;\n1;2")

    assert_equal 3, result
  end

  def test_add_changeNumbersDelimiterToColumn_returnsNumbersSeparatedBySemicolonSum
    result = calc.add("//|\n1|10\n20")

    assert_equal 31, result
  end

  def test_add_negativeNumber_raisesArgumentErrorException
    assert_raise ArgumentError do
      calc.add('-1')
    end
  end

  def test_add_negativeNumbers_raisesArgumentErrorException2
    assert_raise ArgumentError do
      calc.add('1,-1')
    end
  end

  def test_add_negativeNumber_raisesArgumentErrorExceptionWithMessageContainingNegativeNumbers
    negative_number = '-1'

    exception = assert_raise(ArgumentError) do
      calc.add(negative_number)
    end

    assert_match(/#{negative_number}/, exception.message)
  end

  def test_add_negativeNumbers_raisesArgumentErrorExceptionWithMessageContainingNegativeNumbers2
    exception = assert_raise(ArgumentError) do
      calc.add('1,-1,-2')
    end

    assert_match(/\[-1, -2\]/, exception.message)
  end

  def test_add_numberBiggerThan1000_returnsZero
    result = calc.add('1001')

    assert_equal 0, result
  end

  def test_add_sum2with1001_returns2
    result = calc.add('2,1001')

    assert_equal 2, result
  end

  def test_add_threeNumbersSeparatedByMultipleCharsSeparator_returnsTheirSum
    result = calc.add("//[***]\n1***2***3")

    assert_equal 6, result
  end

  def test_add_threeNumbersSeparatedByMultipleDelimiters_returnsTheirSum
    result = calc.add("//[*][%]\n1*2%3")

    assert_equal 6, result
  end

  def test_add_threeNumbersSeparatedByMultipleCharsDelimiters_returnsTheirSum
    result = calc.add("//[**][%%]\n1**2%%3")

    assert_equal 6, result
  end
end