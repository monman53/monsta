require 'asciidoctor'
require 'asciidoctor/extensions'
require 'exifr/jpeg'
require 'date'
require 'fileutils'
require 'pathname'

#----------------
# load input
#----------------

filename = ARGV[0]
document = Asciidoctor.load_file(filename)


#----------------
# macros
#----------------

class ImageGridBlockMacro < Asciidoctor::Extensions::BlockMacroProcessor
    use_dsl

    named :image_grid

    def process parent, target, attrs
        html = ""
        if target == 'begin'
            html = "<div class='image-grid'>\n"
        end
        if target == 'end'
            html = "</div>"
        end
        create_pass_block parent, html, attrs, subs: nil
    end
end

class ImageCellBlockMacro < Asciidoctor::Extensions::BlockMacroProcessor
    use_dsl

    named :image_cell

    def process parent, target, attrs
        exif = EXIFR::JPEG.new("public"+target+".jpg")
        exif_text = "#{exif.focal_length.to_int}mm, F#{exif.f_number.to_f}, SS#{exif.exposure_time}, ISO#{exif.iso_speed_ratings}, #{exif.lens_model}, #{exif.model}"
        html = %(
            <div class="image-cell">
                <a href="#{target}.jpg">
                    <img src="#{target}.thumb.jpg" title="#{attrs['title']}" alt="#{attrs['title']}">
                </a>
                <p class='image-cell-exif'>#{exif_text}</p>
                <p class='image-cell-caption'>#{attrs['title']}</p>
            </div>
        )
        create_pass_block parent, html, attrs, subs: nil
    end
end

Asciidoctor::Extensions.register do
    block_macro ImageGridBlockMacro if document.basebackend? 'html'
    block_macro ImageCellBlockMacro if document.basebackend? 'html'
end

document = Asciidoctor.load_file(filename)


#----------------
# header
#----------------
puts "<!doctype html>"
puts "<html lang='ja'>"
puts "<meta charset='UTF-8'>"
puts "<meta name='viewport' content='width=device-width, initial-scale=1'>"
puts "<meta name='google-site-verification' content='IdlNRkQRrU0RZunvl7Dj8p1UPrs7wJBHJ2KrsrDI9bo' />"
puts "<link rel='shortcut icon' type='image/png' href='/img/favicon.png'/>"
puts "<title>#{document.doctitle} : monman53" + "</title>"

# highlightjs
puts "<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/monokai.min.css'>"
#puts "<link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/styles/github.min.css'>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/highlight.min.js'></script>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/rust.min.js'></script>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/tex.min.js'></script>"
puts "<script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.12.0/languages/vim.min.js'></script>"
puts "<script>hljs.initHighlightingOnLoad();</script>"
# MathJax
puts "<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML'></script>"
puts "<script type='text/x-mathjax-config'>MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$']]}});</script>"
# main css
puts "<link rel='stylesheet' href='/css/main.css'>"
puts "<header><div class='pad'>"
# bread crumbs
path = Pathname.new(filename)
base = Pathname.new("./public")
path = path.relative_path_from(base).sub_ext(".html")
bread = "<a href='/'>monman53.github.io</a> / "
path.descend do |v|
    if v.extname != ".html"
        bread += "<a href='/" + v.to_s + "/'>" + v.basename.to_s + "</a> / "
    else
        if v.basename.to_s != "index.html"
            bread += "<a href='/" + v.to_s + "'>" + v.basename.to_s + "</a>"
        end
    end
end
puts "<p class='bread'>" + bread + "</p>"
puts "<p style='font-size: small;'>Last Modified : #{File::Stat.new(filename).mtime}</p>"
puts "</div></header>"


#----------------
# main content
#----------------

# title
puts "<article><div class='pad'>"
puts "<h1>#{document.doctitle}</h1>"

# Google Analytics
File.open("google_analytics", "r") do |f|
    puts(f.read)
end

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

puts "</div></article>"

#----------------
# footer
#----------------
puts "<footer><div class='pad'>"
#puts "<p>Created : #{File::Stat.new(filename).ctime}</p>"
puts "<p>Last Modified : #{File::Stat.new(filename).mtime}</p>"
puts "<p><a href='/'>monman53.github.io</a></p>"
puts "<p>This page is generated by <a href='https://github.com/monman53/monsta'>monsta</a>.</p>"
#puts "<p><a rel='license' href='https://creativecommons.org/licenses/by/4.0/' class='license'><svg><use xlink:href='/img/cc-by.svg'></use></svg></a>"
#puts "<br>This work is licensed under a <a rel='license' href='https://creativecommons.org/licenses/by/4.0/'>Creative Commons Attribution 4.0 International License</a>.</p>"
puts "<p><a rel='license' href='http://creativecommons.org/licenses/by/4.0/'><img alt='Creative Commons License' style='border-width:0' src='https://i.creativecommons.org/l/by/4.0/80x15.png' /></a></p>"
puts "<p>This work is licensed under a <a rel='license' href='http://creativecommons.org/licenses/by/4.0/'>Creative Commons Attribution 4.0 International License</a>.</p>"
puts "</div></footer>"
