#--------------------------------
# monman static site generator 
#--------------------------------

.PHONY:	all copy htmls clean script

PWD		= $(shell pwd)

SRCDIR	= src
BINDIR	= bin
DOCDIR	= doc
HTMLDIR	= html
PUBDIR	= public

RENDER	= asciidoc
OPTIONS	= -b html5 -ns -a toc -a asciimath -a source-highlighter=highlight

SRCS	= $(shell find $(HTMLDIR) -name '*.adoc')
OBJS	= $(SRCS:.adoc=.html)
TARGET	= htmls


default: copy htmls

all: clean script default

htmls: $(OBJS)

copy:
	@rsync -arEt $(DOCDIR)/ $(HTMLDIR)
	@rsync -arEt $(PUBDIR)/ $(HTMLDIR)

script: src/template.pl
	@ln -s ../src/template.pl $(BINDIR)/template

%.html: %.adoc
	@$(RENDER) $(OPTIONS) $<
	@$(BINDIR)/template $< $@ > $@.tmp
	@mv $@.tmp $@
	@echo convert $<
	
clean:
	@rm -rf $(BINDIR)/*
	@rsync -arEt --delete $(DOCDIR)/ $(HTMLDIR)
