def head(document, filename)
  html = ""

  html += "<meta charset='UTF-8'>"
  html += "<meta name='viewport' content='width=device-width, initial-scale=1'>"
  html += "<link rel='shortcut icon' type='image/png' href='/images/favicon.png'/>"
  html += "<title>#{document.doctitle} : monman53" + "</title>"

  # highlightjs
  html += "<link rel='stylesheet' href='/styles/highlight/nord.css'>"
  html += "<script src='/scripts/highlight.pack.js'></script>"
  html += "<script>hljs.initHighlightingOnLoad();</script>"

  # MathJax
  html += "<script id='MathJax-script' async src='/scripts/mathjax/tex-chtml.js'></script>"
  html += "<script type='text/x-mathjax-config'>"
  html += "MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$']]}});"
  html += "</script>"

  # main css
  html += "<link rel='stylesheet' href='/styles/main.css'>"

  # Google Analytics
  html += "<!-- Global site tag (gtag.js) - Google Analytics -->"
  html += "<script async src='https://www.googletagmanager.com/gtag/js?id=UA-111264044-1'></script>"
  html += "<script>"
  html += "  window.dataLayer = window.dataLayer || [];"
  html += "  function gtag(){dataLayer.push(arguments);}"
  html += "  gtag('js', new Date());"
  html += "  gtag('config', 'UA-111264044-1');"
  html += "</script>"

  html
end
