class Game
  def initialize(slovo)
    @letters = get_letters(slovo.downcase)

    @errors = 0

    @good_letters = []
    @bad_letters = []

    @status = 0
  end

  def get_letters(slovo)
    if slovo == nil || slovo == ""
      abort "Вы не ввели слово для игры"
    end

    return slovo.split("")
  end

  def ask_next_letter
    puts "\n Введите следующую букву"

    letter = ""

    while letter == ""
      letter = STDIN.gets.downcase.chomp
    end

    next_step(letter)
  end

  def next_step(bukva)
    if @status == -1 || @status == 1
      return
    end

    if @good_letters.include?(bukva) ||
      @bad_letters.include?(bukva)
      return
    end

    if @letters.include?(bukva) ||
      bukva == "е" && @letters.include?("ё") ||
      bukva == "ё" && @letters.include?("е") ||
      bukva == "и" && @letters.include?("й") ||
      bukva == "й" && @letters.include?("и")

      @good_letters << bukva

      if bukva == "е"
        @good_letters << "ё"
      elsif bukva == "ё"
        @good_letters << "е"
      elsif bukva == "и"
        @good_letters << "й"
      elsif bukva == "й"
        @good_letters << "и"
      end

      # условие, когда отгадано все слово
      if (@letters.uniq - @good_letters).empty?
        @status = 1
      end
    else
      @bad_letters << bukva

      if bukva == "е"
        @bad_letters << "ё"
      elsif bukva == "ё"
        @bad_letters << "е"
      elsif bukva == "и"
        @bad_letters << "й"
      elsif bukva == "й"
        @bad_letters << "и"
      end

      @errors += 1

      if @errors >= 7
        @status = -1
      end
    end
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end

  def status
    @status
  end

  def errors
    @errors
  end
end
