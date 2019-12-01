.PHONY:	htmls

SRCS	= $(shell find public -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)

VPATH	= src


# rbs		= converter linkchecker

all: $(shs) $(rbs) htmls 


# $(rbs): %: %.rb
# 	cp $< $@


htmls: $(OBJS)

%.html: %.adoc src/converter.rb
	ruby src/converter.rb $< > $(basename $<).html


check:
	ruby src/linkchecker.rb

clean:
	find ./public -name "*.html" -delete
	rm -f $(rbs)
