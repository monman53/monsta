require 'exifr'
require 'exifr/jpeg'

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
        exif_text = ""
        exif_text += "#{exif.focal_length.to_int}mm, "
        exif_text += "F#{exif.f_number.to_f}, "
        exif_text += "SS#{exif.exposure_time}, "
        exif_text += "ISO#{exif.iso_speed_ratings}, "
        exif_text += "#{exif.lens_model}, "
        exif_text += "#{exif.model}"
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
