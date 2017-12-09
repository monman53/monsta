#--------------------------------
# monman static site generator 
#--------------------------------

.PHONY:	htmls

SRCS	= $(shell find root -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)

VPATH	= src


shs		= rmhtml

rbs		= convert

all: $(shs) $(rbs) htmls 

$(shs): %: %.sh
	cp $< $@

$(rbs): %: %.rb
	cp $< $@

htmls: $(OBJS)

%.html: %.adoc ./convert
	ruby ./convert $< > $(basename $<).html

clean:
	find ./root -name "*.html" -delete
	rm -f $(shs)
