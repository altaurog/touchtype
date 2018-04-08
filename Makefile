all: app/app.js

app/app.js: src/App.elm src/HtmlDisplay.elm src/TouchType.elm src/ListExtra.elm
	elm make --output $@ $<

test:
	elm test
