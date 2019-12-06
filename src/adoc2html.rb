require 'asciidoctor'

def adoc2html(filename)
  #----------------
  # macros
  #----------------
  require_relative './macros'

  #================================
  # rendering html
  #================================
  document = Asciidoctor.load_file(filename)

  require_relative './head'
  require_relative './body'

  html  = "<!doctype html>"
  html += "<html lang='ja'>"
  html += "<head>" + head(document, filename) + "</head>"
  html += "<body>" + body(document, filename) + "</body>";
  html += "</html>"

  html
end
