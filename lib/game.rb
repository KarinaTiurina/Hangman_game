class Game
  attr_reader :errors, :letters, :good_letters, :bad_letters, :status

  attr_accessor :version

  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo.downcase)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = :in_progress # :won, :lost
  end

  def max_errors
    MAX_ERRORS
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Вы не ввели слово для игры"
    end

    slovo.split("")
  end

  def ask_next_letter
    puts "\n Введите следующую букву"

    letter = ""

    while letter == ""
      letter = STDIN.gets.downcase.chomp
    end

    next_step(letter)
  end

  def is_good?(letter)
    letters.include?(letter) ||
      letter == "е" && letters.include?("ё") ||
      letter == "ё" && letters.include?("е") ||
      letter == "и" && letters.include?("й") ||
      letter == "й" && letters.include?("и")
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when 'е' then letters << 'ё'
    when 'ё' then letters << 'е'
    when 'и' then letters << 'й'
    when 'й' then letters << 'и'
    end
  end

  def solved?
    (@letters.uniq - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) ||
      @bad_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def next_step(letter)
    return if @status == :lost || @status == :won

    return if repeated?(letter)

    if is_good?(letter)
      add_letter_to(@good_letters, letter)

      # условие, когда отгадано все слово
      @status = :won if solved?
    else
      add_letter_to(@bad_letters, letter)

      @errors += 1

      @status = :lost if lost?
    end
  end
end
