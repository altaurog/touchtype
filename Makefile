CLOSURE_FLAGS=--language_in ECMASCRIPT5 --compilation_level ADVANCED_OPTIMIZATIONS --warning_level QUIET
all: touchtype.min.js

touchtype.js: src/App.elm src/HtmlDisplay.elm src/TouchType.elm src/ListExtra.elm src/Style.elm
	yarn run elm make --output $@ $<

test:
	elm test

%.min.js: %.js
	closure-compiler $(CLOSURE_FLAGS) --js $< > $@
