# inspired by a data console on tng

def generate_line
  h = rand(24)
  m = rand(60)
  s = rand(0.0..60.0)
  keyword = %w[FWS RET XXR DTM PLI X10 EXO GRN APP ELE PWR TSR SRS NFA QRY ADV NUL COM ADV REG].sample
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
  status = %w[A A A A A A A A A A B B B C X R T Z P].sample
  number = rand(110000)
  '[%02d:%02d:%05.2f] %s/%s %s {%s}%08d' % [h, m, s, keyword, hash, sep, status, number]
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
      sleep sleeptime
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

refreshing_list
