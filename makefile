#--------------------------------
# monman static site generator 
#--------------------------------

.PHONY:	htmls

OPTIONS	= -b html5 -s -a toc -a asciimath -a source-highlighter=highlight

SRCS	= $(shell find root -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)


all: template htmls 

template: src/template.pl
	cp ./src/template.pl ./template

htmls: $(OBJS)

%.html: %.adoc src/template.pl
	@asciidoc $(OPTIONS) $<
	@./template $< $@ > $@.tmp
	@mv $@.tmp $@
	@echo convert $<

clean:
	find ./root -name "*.html" -delete
	rm -f template
