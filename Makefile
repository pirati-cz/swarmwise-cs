FOP=fop
XSLT=xsltproc
MAIN=swarmwise.docbook
CHAPTERS=src/00-predmluva.docbook \
	src/01-jak-chapat-hejno.docbook \
	src/02-zakladame-hejno.docbook \
	src/03-jak-hejno-zorganizovat.docbook \
	src/04-diktujte-vizi-ne-poselstvi.docbook \
	src/05-udrzujte-pozornost-na-cili.docbook \
	src/06-k-certu-s-demokracii.docbook \
	src/07-jak-prezit-rust.docbook \
	src/08-jak-vyuzit-spolecenske-procesy.docbook \
	src/09-jak-zvladat-stara-media.docbook \
	src/10-jak-prezit-uspech.docbook \
	src/11-ostatni.docbook
IMAGES=img/cz-chap03-mgt-pyramids.svg \
	img/cz-chap03-org-chart.svg \
	img/locum-logo.png \
	img/thoughtmark.png \
	img/quotemarks.png \
	img/rick.png \
	img/swarmwise_image_1_-_screenshot.png \
	img/Swarmwise\ Image\ 4\ -\ TV\ Frame.png \
	img/Swarmwise\ Image\ 5\ -\ group\ sizes.png
PDF_IMAGES=$(IMAGES) img/obalka.svg
HTML_IMAGES=$(IMAGES) img/obalka-bg.svg
SOURCE=$(MAIN) $(CHAPTERS)

.PHONY: all clean

all: swarmwise.xhtml.zip swarmwise.pdf swarmwise.epub

swarmwise.css: css/html.css css/common.css
	cat $^ >$@

swarmwise.xhtml: xsl/xhtml.xsl xsl/xhtml-common.xsl $(SOURCE)
	$(XSLT) -o $@ $< $(MAIN)

swarmwise.fo: xsl/fo.xsl $(SOURCE)
	$(XSLT) -o $@ $< $(MAIN)

swarmwise.pdf: swarmwise.fo
	fop -c fop.xml $< $@

swarmwise.epub: xsl/epub.xsl xsl/epub-base.xsl xsl/xhtml-common.xsl css/epub.css css/common.css $(SOURCE) $(HTML_IMAGES)
	rm -rf tmp $@
	mkdir -p tmp/OEBPS/img
	cd tmp && $(XSLT) ../$< ../$(MAIN) >/dev/null
	cp $(HTML_IMAGES) tmp/OEBPS/img/
	cp -r fonts tmp/OEBPS/
	cat css/epub.css css/common.css >tmp/OEBPS/swarmwise.css
	cd tmp && zip -X0 ../$@ mimetype && zip -rX9 ../$@ . -x mimetype

swarmwise.xhtml.zip: swarmwise.xhtml swarmwise.css docbook.css $(HTML_IMAGES)
	rm -f $@
	zip -rX9 $@ $< swarmwise.css docbook.css $(HTML_IMAGES) fonts

clean:
	rm -rf tmp
	rm -f swarmwise.fo swarmwise.pdf swarmwise.xhtml swarmwise.epub
	rm -f swarmwise.css docbook.css swarmwise.xhtml.zip
