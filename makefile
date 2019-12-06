all: timestamp htmls

htmls:
	ruby src/main.rb -m

timestamp: src/* 
	touch timestamp

check:
	ruby src/linkchecker.rb

clean:
	ruby src/main.rb -c
	rm -f timestamp
