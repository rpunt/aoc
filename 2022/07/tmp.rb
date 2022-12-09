#!/usr/bin/env ruby

disk = {
  "a" => {
    "e" => { "i"=>584 },
    "f" => 29116,
    "g" => 2557,
    "h.lst" => 62596
  },
  "b.txt" => 14848514,
  "c.dat" => 8504156,
  "d" => {
    "j" => 4060174,
    "d.log" => 8033020,
    "d.ext" => 5626152,
    "k" => 7214296
  }
}

def sum_children(graph)
  child_sizes = 0
  graph.keys.each do |key|
    child_sizes += graph[key].is_a?(Hash) ? sum_children(graph[key]) : graph[key]
  end

  return child_sizes
end

def find_directories(graph, directories = [])
  # dir_keys = graph.keys.select { |k| graph[k].is_a?(Hash) }

  graph.each do |k,v|
    if v.is_a?(Hash)
      find_directories(v, directories.push(k))
      # directories.pop
    end
  end

  return directories
end

# end

def nested_keys(hash, keys = [])
  # go through each key-value pair
  hash.each do |key, val|
    # if the value is a Hash, recurse and
    # add the key to the array of parents
    if val.is_a? Hash
      nested_keys(val, keys.push(key))
      # remove last parent when we're done
      # with this pair
      keys.pop
    else
      # if the value is not a Hash, set the
      # value to parents + current key
      hash[key] = keys + [key]
    end
  end
end

def sum_dir_less_than(cap)
  #
end


puts sum_children(disk)
puts sum_children(disk['a'])
puts sum_children(disk['d'])

require 'pry'; binding.pry

# find any hash whose child sizes are <= 100000
