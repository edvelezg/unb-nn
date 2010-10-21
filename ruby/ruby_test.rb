class RandomizingArray < Array
  def <<(e)
    insert(rand(size), e)
  end
  def [](i)
    super(rand(size))
  end
end
a = RandomizingArray.new
a << 1 << 2
p a
a << 3 << 4
p a
a << 5 << 6 # => [6, 3, 4, 5, 2, 1]
p a
# That was fun; now let's get some of those entries back.

p a[0] # => 1
p a[0] # => 2
p a[0] # => 5
#No, seriously, a[0].
p a[0] # => 4
#It's a madhouse! A madhouse!
a[0] # => 3
#That does it!
class RandomizingArray
  remove_method('[]')
end
p a[0] # => 6
p a[0] # => 6
p a[0] # => 6
# But the overridden << operator still works randomly:
a << 7 # => [6, 3, 4, 7, 5, 2, 1]

p [1, 2, 3, 4].map { |e| e**6 + 3*e }
