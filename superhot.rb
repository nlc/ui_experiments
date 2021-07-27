require 'byebug'

class Interface
  def get_files
    @files = Dir.children(@wd)
  end

  def initialize(w, h)
    @segments = [
      "\xe2\x94\x8c",
      "\xe2\x94\x80",
      "\xe2\x94\x90",
      "\xe2\x94\x82",
      "\xe2\x94\x98",
      "\xe2\x94\x94"
    ]

    @wd = Dir.pwd
    @files = get_files

    @w = w
    @h = h
  end

  def go_to(x, y)
    print "\033[#{y};#{x}H"
  end

  def cls
    print "\033[2J\033[H"
  end

  # w and h are the dimensions of the blank area INSIDE the box
  # so the actual total area will be (w+2)*(h+2)
  def draw_box(x, y, w, h, ch=' ')
    go_to(x, y)

    print @segments[0]
    w.times do
      print @segments[1]
    end
    print @segments[2]

    h.times do |i|
      go_to(x, y + i + 1)
      print @segments[3]
      w.times do
        print ch
      end
      print @segments[3]
    end

    go_to(x, y + h + 1)
    print @segments[5]
    w.times do
      print @segments[1]
    end
    print @segments[4]
  end

  def draw_text_box(x, y, text)
    lines = text.split(/\n/)
    longest = lines.map(&:length).max
    draw_box(x, y, longest, lines.length)
    lines.each_with_index do |line, i|
      go_to(x + 1, y + i + 1)
      print line
    end
  end

  def draw_field(x, y, w, h, ch='.')
    h.times do |i|
      go_to(x, y + i)
      print ch * w
    end
  end

  def draw_test
    cls
    draw_text_box(1, 1, @wd)

    draw_box(1, 4, @w, @h, '.')

    draw_text_box(4, 6, @files[0..9].join("\n"))

    go_to(1, 6 + @h)
  end
end
