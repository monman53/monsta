require 'asciidoctor'

def adoc2html(filename)
  #----------------
  # macros
  #----------------
  require_relative './src/macros'

  #================================
  # rendering html
  #================================
  document = Asciidoctor.load_file(filename)

  require_relative './src/head'
  require_relative './src/body'

  html  = "<!doctype html>"
  html += "<html lang='ja'>"
  html += "<head>" + head(document, filename) + "</head>"
  html += "<body>" + body(document, filename) + "</body>";
  html += "</html>"

  html
end
