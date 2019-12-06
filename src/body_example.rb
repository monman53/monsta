def body(document, filename)
  html = ""

  #----------------
  # header 
  html += "<div>header</div>"
  #----------------

  #----------------
  # title
  html += "<h1>#{document.doctitle}</h1>"
  #----------------

  #================
  # Main contents
  #================
  html += document.content


  #----------------
  # footer
  html += "<div>footer</div>"
  #----------------

  html
end
