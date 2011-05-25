# pulls out relevant lines from a history-generated
# svn changelog so I can see what files have changed
# since the last relase... so I know what files
# to make live for the current release

# get interesting lines out of file
file = File.new "changeLog.txt"
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
file = File.new "output.txt", "w"
file.write out
file.close

