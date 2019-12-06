def head(document, filename)
  html = ""

  html += "<meta charset='UTF-8'>"
  html += "<meta name='viewport' content='width=device-width, initial-scale=1'>"
  html += "<title>" + document.doctitle + "</title>"

  html
end
