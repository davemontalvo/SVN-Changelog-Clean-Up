# Filters an SVN changeLog file so that only the SVN operation and the path are displayed.
# Assumes the changlog was generated from a trunk/

# modify these according to your environment
input_file = "changeLog.txt"
output_file = "output.txt"

# get interesting lines out of file
file = File.new input_file
arr = Array.new
file.each {
  |line|
  pattern = /[A-Z]{1} \/trunk\//
  if line =~ pattern
    pattern_sub = /\/trunk\/.*/
    line_end = line.sub(pattern_sub, '');
    line.sub!(pattern, '');
    line.strip!
    arr << line+'->'+line_end
  end
}
arr.sort!.uniq!

# add svn operation to beginning of alphabetized
# list of lines
out = Array.new
arr.each {
  |line|
  pattern = /->(.*)$/
  line.match pattern
  prefix = $1.strip!
  line.sub!(pattern, '')
  out << prefix+' -> '+line
}

# print results
file = File.new output_file, "w"
file.write out
file.close

