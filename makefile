.PHONY:	htmls

SRCS	= $(shell find public -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)

VPATH	= src


rbs		= convert

all: $(shs) $(rbs) htmls 


$(rbs): %: %.rb
	cp $< $@


htmls: $(OBJS)

%.html: %.adoc ./convert
	ruby src/convert.rb $< > $(basename $<).html


clean:
	find ./public -name "*.html" -delete
	rm -f $(rbs)
