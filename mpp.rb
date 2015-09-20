#!/usr/bin/env ruby

require 'pathname'

# Defaults 
language = "en"

paths = []
media_root = Pathname.new("/mnt/media")
tv_paths = Dir.glob(media_root.join("TV/*/Season*"))
movie_paths = Dir.glob(media_root.join("Movies/*"))

movie_paths.each do |path|
  ascii = true

  path.chars.each do |char|
   unless char.ascii_only?
     ascii = false
     break
   end
  end

  if ascii
    

  else
    ascii_path = path.encode(Encoding.find('ASCII'), invalid: :replace, undef: :replace, replace: '')
    puts "#{path} => #{ascii_path}"
  end
end

def run_subliminal(label, paths, options = {})
  options.reverse_merge!(language: language)

  option_args = options.each_with_object([]) { |(k, v), a| a << "--#{key} #{v}" }.join(' ')
  path_args = paths.map { |p| "\"#{p}\"" }.join(' ')

  puts "Running subliminal on #{label}..."

  system "subliminal download #{option_args} #{path_args}" 

  puts "Finished running subliminal on #{label}!"
end

#run_subliminal("TV Shows", tv_paths, age: "30d")
#run_subliminal("Movies", movie_paths)
