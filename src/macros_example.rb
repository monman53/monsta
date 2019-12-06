# this example from
# https://asciidoctor.org/docs/user-manual/#block-macro-processor-example

class GistBlockMacro < Asciidoctor::Extensions::BlockMacroProcessor
  use_dsl

  named :gist

  def process parent, target, attrs
    title_html = (attrs.has_key? 'title') ?
        %(<div class="title">#{attrs['title']}</div>\n) : nil

    html = %(<div class="openblock gist">
#{title_html}<div class="content">
<script src="https://gist.github.com/#{target}.js"></script>
</div>
</div>)

    create_pass_block parent, html, attrs, subs: nil
  end
end

Asciidoctor::Extensions.register do
  block_macro GistBlockMacro if document.basebackend? 'html'
end
