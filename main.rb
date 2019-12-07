require 'find'
require 'optparse'

require_relative 'adoc2html'

#----------------
# parse options
op = OptionParser.new
opts = {
  make: false,
  clean: false,
}
op.on('-m') {
  opts[:make] = true
}
op.on('-c') {
  opts[:clean] = true
}
op.parse(ARGV)
#----------------

Find.find('public') {|f|

  ext  = File.extname(f)
  name = File.dirname(f) + '/' + File.basename(f, ext)

  #----------------
  # convert .adoc to .html
  if opts[:make]
    if ext == '.adoc'
      html = name + '.html'
      adoc = name + '.adoc'
      if File.exist?(html)
        if File.mtime(adoc) > File.mtime(html) or File.mtime('./timestamp') > File.mtime(html)
          puts adoc + ' -> ' + html
          File.open(html, 'w') do |f| 
            f.puts(adoc2html(adoc))
          end
        end
      else
        puts adoc + ' -> ' + html
        File.open(html, 'w') do |f| 
          f.puts(adoc2html(adoc))
        end
      end
    end
  end
  #----------------

  #----------------
  # clean html
  if opts[:clean]
    if ext == '.html'
      html = name + '.html'
      adoc = name + '.adoc'
      if File.exist?(adoc)
        puts 'rm ' + f
        File.delete(html)
      end
    end
  end
  #----------------
  
  #----------------
  # directory
  # if File.directory?(f)
  #   if Dir.empty?(f)
  #     puts f
  #   end
  # end
  #----------------
}
