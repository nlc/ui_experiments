class Interface
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
    @files = []

    @w = w
    @h = h
  end

  def get_files
    @files = Dir[@wd]
  end

  def draw
    (@h * 3).times do
      puts
    end

    print @segments[0]
    @wd.length.times do
      print @segments[1]
    end
    print @segments[2]
    puts
    print @segments[3]
    print @wd
    print @segments[3]
    puts
    print @segments[5]
    @wd.length.times do
      print @segments[1]
    end
    print @segments[4]
    puts
    (@h - 1).times do |y|
      @w.times do |x|
        print '.'
      end
      puts
    end
  end
end
