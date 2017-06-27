#--------------------------------
# monman static site generator 
#--------------------------------

.PHONY:	htmls

OPTIONS	= -b html5 -s -a toc -a asciimath -a source-highlighter=highlight

SRCS	= $(shell find root -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)

VPATH	= src


shs		= template rmhtml

all: $(shs) htmls 

$(shs): %: %.sh
	cp $< $@

#
# template: src/template.sh
# 	cp ./src/template.sh ./template

htmls: $(OBJS)

%.html: %.adoc template
	@asciidoc $(OPTIONS) $<
	@./template $< $@ > $@.tmp
	@mv $@.tmp $@
	@echo convert $<

clean:
	find ./root -name "*.html" -delete
	rm -f $(shs)
