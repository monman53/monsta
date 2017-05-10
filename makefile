#--------------------------------
# monman static site generator 
#--------------------------------

.PHONY:	all copy htmls clean script

PWD		= $(shell pwd)

BINDIR	= bin
DOCDIR	= doc
HTMLDIR	= html

RENDER	= asciidoc
OPTIONS	= -b html5 -ns -a toc -a asciimath

SRCS	= $(shell find $(HTMLDIR) -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)
TARGET	= htmls


all: copy $(OBJS)

build: clean script copy htmls

copy:
	@rsync -arEt $(DOCDIR)/ $(HTMLDIR)

script: src/template.sh
	@ln -s ../src/template.sh $(BINDIR)

%.html: %.adoc
	@$(RENDER) $(OPTIONS) $<
	@$(BINDIR)/template.sh $< $@ > $@.tmp
	@mv $@.tmp $@
	@echo convert $<
	
clean:
	@rm -rf $(BINDIR)/*
	@rsync -arEt --delete $(DOCDIR)/ $(HTMLDIR)
