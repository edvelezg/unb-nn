#!/usr/bin/env ruby

infile = ARGV[0]
once = false
str = ""
File.foreach(infile) do |line|
  arr = line.gsub("\s+", " ").gsub('(', '').gsub(')','').split(" ")
  if !once
    if arr[0] != "#"
      arr.insert(0, "#")
    end
    once = true
  end
  str += arr.join("\t") + "\n"
end

File.open(infile, "w") { |file| file.puts str }
