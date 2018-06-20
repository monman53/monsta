require 'asciidoctor'
require 'date'
require 'fileutils'

filename = ARGV[0]
document = Asciidoctor.load_file(filename)



#----------------
# header
#----------------
puts "<!doctype html>"
puts "<meta charset='UTF-8'>"
puts "<meta name='viewport' content='width=device-width, initial-scale=1'>"
puts "<link rel='shortcut icon' type='image/png' href='/img/favicon.png'/>"
puts "<title>#{document.doctitle} : monman53" + "</title>"

# highlightjs
puts "<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css'>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js'></script>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/rust.min.js'></script>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/tex.min.js'></script>"
puts "<script>hljs.initHighlightingOnLoad();</script>"
# MathJax
puts "<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML'></script>"
# main css
puts "<link rel='stylesheet' href='/css/main.css'>"

# title
puts "<p><a href='/'>monman53.github.io</a></p>"
puts "<hr>"
puts "<h1>#{document.doctitle}</h1>"

# Google Analytics
File.open("google_analytics", "r") do |f|
    puts(f.read)
end



#----------------
# content
#----------------

# main
puts document.content

# footnotes
if document.footnotes?
    puts "<hr>"
    puts "<h4>脚注</h4>"
    document.footnotes.each{|footnote|
        puts "<p id='_footnote_#{footnote[:index].to_s}'><small>#{footnote[:index].to_s}. #{footnote[:text]}</small></p>"
    }
end



#----------------
# footer
#----------------
puts "<hr>"
puts "<p>last modified : #{File::Stat.new(filename).mtime}</p>"
puts "<p><a href='/'>monman53.github.io</a></p>"
puts "<p>this page is generated by <a href='https://github.com/monman53/monsta'>monsta</a></p>"
