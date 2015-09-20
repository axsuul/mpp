#!/usr/bin/env ruby

require 'pathname'

# Rename paths with only ASCII characters
def asciify_paths(paths)
  fallback = { 'À' => 'A', 'Á' => 'A', 'Â' => 'A', 'Ã' => 'A', 'Ä' => 'A',
               'Å' => 'A', 'Æ' => 'AE', 'Ç' => 'C', 'È' => 'E', 'É' => 'E',
               'Ê' => 'E', 'Ë' => 'E', 'Ì' => 'I', 'Í' => 'I', 'Î' => 'I',
               'Ï' => 'I', 'Ñ' => 'N', 'Ò' => 'O', 'Ó' => 'O', 'Ô' => 'O',
               'Õ' => 'O', 'Ö' => 'O', 'Ø' => 'O', 'Ù' => 'U', 'Ú' => 'U',
               'Û' => 'U', 'Ü' => 'U', 'Ý' => 'Y', 'à' => 'a', 'á' => 'a',
               'â' => 'a', 'ã' => 'a', 'ä' => 'a', 'å' => 'a', 'æ' => 'ae',
               'ç' => 'c', 'è' => 'e', 'é' => 'e', 'ê' => 'e', 'ë' => 'e',
               'ì' => 'i', 'í' => 'i', 'î' => 'i', 'ï' => 'i', 'ñ' => 'n',
               'ò' => 'o', 'ó' => 'o', 'ô' => 'o', 'õ' => 'o', 'ö' => 'o',
               'ø' => 'o', 'ù' => 'u', 'ú' => 'u', 'û' => 'u', 'ü' => 'u',
               'ý' => 'y', 'ÿ' => 'y' }

  movie_paths.each do |path|
    ascii = true

    # Check if ASCII
    path.chars.each do |char|
      unless char.ascii_only?
        ascii = false
        break
      end
    end

    unless ascii
      ascii_path = path.encode('ASCII', fallback: lambda { |c| fallback[c] || '?' })
      puts "#{path} => #{ascii_path}"
    end
  end  
end

# Fetch subtitles for paths
def run_subliminal(label, paths, options = {})
  options.reverse_merge!(language: "en")

  option_args = options.each_with_object([]) { |(k, v), a| a << "--#{key} #{v}" }.join(' ')
  path_args = paths.map { |p| "\"#{p}\"" }.join(' ')

  puts "Running subliminal on #{label}..."

  system "subliminal download #{option_args} #{path_args}" 

  puts "Finished running subliminal on #{label}!"
end

media_root = Pathname.new("/mnt/media")
tv_paths = Dir.glob(media_root.join("TV/*/Season*"))
movie_paths = Dir.glob(media_root.join("Movies/*"))

#run_subliminal("TV Shows", tv_paths, age: "30d")
#run_subliminal("Movies", movie_paths)
