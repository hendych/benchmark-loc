# Add modular imports to each headers in Traveloka project.
# Will take parameter and add @import <param_header> to all headers.
# Usage: append_import TVLFoundation.
def append_import()
  header_name = ARGV[0]
  dir_glob = ARGV[1]

  Dir.glob(dir_glob) { |dir|
    filename = File.basename(dir)
    file_contents = []
    skip_file = false
    has_found_copyright_text = false
    has_found_end_of_copyright = false
    has_added_import = false

    File.open(dir, "r") { |file|
      file.each { |line|
        if line.include? header_name
          puts "Skipping #{filename}"
          skip_file = true
          break
        end

        if line.include? "Copyright"
          has_found_copyright_text = true

          file_contents << line
          next
        end

        if line.include? '//'
          has_found_end_of_copyright = true

          file_contents << line
          next
        end

        if has_found_copyright_text && has_found_end_of_copyright && !has_added_import
          has_added_import = true

          file_contents << "\n"
          file_contents << "@import #{header_name};"
          file_contents << "\n"
          file_contents << line
          next
        end

        file_contents << line
      }

      file.close
    }

    next if skip_file

    if !has_added_import
      puts "Cannot add import to #{filename}"

      next
    end

    File.open(dir, 'w') { |f|
      file_contents.each { |text|
        f.write "#{text}"
      }

      f.close
    }
  }
end


if ARGV[0] == nil && ARGV[1] == nil
  puts "Error, empty header name"
  puts "Usage: append_import <header_name_to_be_added> <directory>"
  puts "Example: append_import TVLFoundation \"Traveloka/Bus/Booking/**/*.h\""

  return
end

append_import()
