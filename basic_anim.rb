fname = ARGV.shift

unless fname
  puts "Usage: basic_anim <file name>"
  exit 1
end

fdata = File.read(fname)

frame_delim = fdata.split(/\n/).first

frames = fdata.split("\n" + frame_delim + "\n")
metadata = frames.shift.gsub(frame_delim + "\n", '')

frame_duration = metadata.to_f

frames.each do |frame|
  puts %x(clear)
  puts frame
  sleep frame_duration
end
