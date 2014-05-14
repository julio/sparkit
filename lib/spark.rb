module Spark
  class Grapher
    TICKS = %w{ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ }.freeze

    def self.render(numbers)
      Spark::Grapher.new.render(numbers)
    end

    def render(numbers)
      @numbers = numbers

      normalize_numbers
      numbers_to_bars
    end

    private

    attr_reader :numbers

    def normalize_numbers
      remove_commas
      convert_string_to_array_of_numbers
    end

    def range
      return @range if @range

      range = max-min
      range = 1 if range < 1
      @range = range
    end

    def min
      @min ||= numbers.min
    end

    def max
      @max ||= numbers.max
    end

    def convert_string_to_array_of_numbers
      @numbers = numbers.split.map(&:to_i)
    end

    def remove_commas
      @numbers = numbers.gsub(',', ' ')
    end

    def numbers_to_bars
      numbers.map { |n| TICKS[number_to_bar_index(n)] }.join
    end

    def number_to_bar_index(n)
      ((n - min) * (TICKS.size - 1)) / range
    end
  end
end

# ---- test from the command line ----

def running_script?
  $0 == __FILE__
end

if running_script?
  if File.exist?(ARGV[0])
    puts Spark::Grapher.render(ARGF.read)
  else
    puts Spark::Grapher.render(ARGV[0])
  end
end
