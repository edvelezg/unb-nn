#!/usr/bin/env ruby

file = File.open("damping_data.csv", "w")

@Amp   = 1
@alpha = -3
@beta  = 20

def damping_fn(x)
  return @Amp*Math.exp(@alpha*(x))*Math.cos(@beta*(x))
end

change = 0.01
old_v = 0.0
new_v = damping_fn(-1*change)
next_v = damping_fn(0*change)

# puts "#{-1*change},#{new_v},none,#{next_v}"
for i in 1..100
  old_v = new_v
  new_v = next_v
  next_v = damping_fn(i*change)
  file.puts "#{new_v},#{old_v},#{next_v}"
end
