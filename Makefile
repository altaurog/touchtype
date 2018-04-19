all: app/index.html

app/index.html: src/App.elm src/HtmlDisplay.elm src/TouchType.elm src/ListExtra.elm src/Style.elm
	elm make --output $@ $<

test:
	elm test
