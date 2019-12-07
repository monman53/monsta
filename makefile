all: timestamp htmls

htmls:
	ruby main.rb -m

timestamp: src/* main.rb adoc2html.rb
	touch timestamp

check:
	ruby linkchecker.rb

clean:
	ruby main.rb -c
	rm -f timestamp
