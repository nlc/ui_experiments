# inspired by a data console on tng

def generate_line
  h = rand(24)
  m = rand(60)
  s = rand(0.0..60.0)
  suffix =
    if rand < 0.05
      %w[a b e r].sample
    else
      ' '
    end
  number1 = ((rand 20..800) / 8) * 8 - (rand < 0.01 ? 1 : 0)
  keyword = %w[FWS RET XXR DTM PLI X10 EXO GRN APP ELE PWR TSR SRS NFA QRY ADV NUL COM ADV REG APL].sample
  hash = 32.times.map{'0123456789abcdef'.chars.sample}.join
  sep =
    case keyword
    when 'ADV'
      '>>'
    when 'REG'
      '<<'
    else
      '::'
    end
  status = %w[A A A A A A A A A A B B B C X R T Z P ?].sample
  number2 = rand(110000)
  '[%02d:%02d:%06.3f]% 4d%s %s/%s %s {%s}%08d' % [h, m, s, number1, suffix, keyword, hash, sep, status, number2]
end

def refreshing_list
  loop do
    sleeptime = rand(0.00..0.1)

    print "\033[2J\033[H"
    sleep rand(0.1..0.3)

    rand(5...25).times do
      if rand < 0.05
        print "\033[1m"
        puts generate_line
        print "\033[0m"
      else
        puts generate_line
      end
      sleep sleeptime * rand(0.5..2.0)
    end
    sleep rand(0.3..0.5)
  end
end

def changing_line
  loop do
    print "\033[2K\r"
    print generate_line
    sleep rand(0.0..0.5)
  end
end

def moving_focus
  loop do
    num_lines = 20
    lines = num_lines.times.map { generate_line }

    print "\033[2J\033[H"
    lines.each { |line| puts line }

    hl_line = rand(num_lines)
    (rand(3..8)).times do
      print "\033[#{hl_line + 1}H"
      print lines[hl_line]

      hl_line = rand(num_lines)
      print "\033[#{hl_line + 1}H"
      print "\033[1m"
      print lines[hl_line]
      print "\033[0m"

      sleep rand(0.1..1.0)
    end
  end
end

def list_and_scroll_hl
  print "\033[?25l"
  loop do
    sleeptime = rand(0.0..0.1)

    print "\033[2J\033[H"
    sleep rand(0.1..0.3)

    num_lines = rand(5..25)
    lines = num_lines.times.map { generate_line }

    lines.each do |line|
      puts line

      sleep sleeptime * rand(0.5..2.0)
    end

    num_hl_lines = rand(3..6)
    hl_lines = (0...num_lines).to_a.sample(num_hl_lines).sort

    last_hl_line = nil
    hl_lines.each do |hl_line|
      if last_hl_line
        print "\033[#{last_hl_line + 1}H"
        print "\033[0m"
        print lines[last_hl_line]
      end

      print "\033[#{hl_line + 1}H"
      print "\033[1m"
      print lines[hl_line]
      print "\033[0m"

      last_hl_line = hl_line

      sleep rand(0.1..0.5)
    end

    sleep 0.5
  end
rescue Interrupt
  print "\033[2J\033[H"
  print "\033[?25h"
end

list_and_scroll_hl
