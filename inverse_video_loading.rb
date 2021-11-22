class InverseVideoBar
  attr_accessor :string, :length, :ivstart, :ivend
  def initialize(string='', length=nil, ivstart=-1, ivend=-1)
    @string = string
    @length = length
    @ivstart = ivstart
    @ivend = ivend
  end

  def draw(coord_x=nil, coord_y=nil)
    print "\033[#{coord_y};#{coord_x}H" unless coord_x.nil? || coord_y.nil?

    inverted = false
    (@length || @string.length).times do |i|
      if (@ivstart...@ivend).include? i
        print "\033[7m" unless inverted
        inverted = true
      else
        print "\033[0m" if inverted
        inverted = false
      end

      print @string[i] || ' '
    end

    print "\033[0m" if inverted
  end

  def set_fill_fraction(fraction)
    @ivstart = 0
    @ivend = (@length || @string.length) * fraction
  end
end

def basic_demo
  ivbar = InverseVideoBar.new('Now loading...', 20)

  ivbar.length.times do |i|
    ivbar.ivend = i
    print "\r"
    ivbar.draw
    sleep 0.5
  end

  puts
end

def fractional_demo
  ivbar = InverseVideoBar.new('', %x(tput cols).to_i)

  puts "\033[?25l"
  101.times do |i|
    fraction = i / 100.0
    ivbar.string = 'Loading your content... (% 3s%%)' % [i]
    ivbar.set_fill_fraction(fraction)

    print "\r"
    ivbar.draw
    sleep 0.1
  end
  puts "\033[?25h"

  puts
rescue SystemExit, Interrupt
  puts "\033[?25h"
end

def coords_demo
  bar_length = 40
  bar_location_x = 50
  bar_location_y = 10

  ivbar = InverseVideoBar.new('', bar_length)

  print "\033[#{bar_location_y - 1};#{bar_location_x - 1}H"
  print '╓─ ··                           · ───────╖'
  print "\033[#{bar_location_y + 1};#{bar_location_x - 1}H"
  print '╙─────── ·                           ·· ─╜'
  print "\033[#{bar_location_y};#{bar_location_x - 1}H║"
  print "\033[#{bar_location_y};#{bar_location_x + bar_length}H║"

  puts "\033[?25l"
  i = 0
  while i < 101
    fraction = i / 100.0
    ivbar.string = 'Loading your content... (% 3d%%)' % [i.to_i]
    ivbar.set_fill_fraction(fraction)

    ivbar.draw(bar_location_x, bar_location_y)

    i += rand
    sleep 0.1
  end
  puts "\033[?25h"

  puts
rescue SystemExit, Interrupt
  puts "\033[?25h"
end

coords_demo
