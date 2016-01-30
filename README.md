# Swarmwise
Český překlad knihy Swarmwise a webová prezentace.

Pro vygenerování PDF ze zdrojáků budete potřebovat Xsltproc, Fop a DocBook XSL NS Stylesheets v1.78. Pak stačí jen pustit Make.

FOP v1.1 obsahuje chybu, kvůli které se špatně zarovnává obsah (strana v-vii). Pro vysázení finální verze PDF používejte [vývojovou verzi z SVN](http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/).

Pokud ještě není uzavřený [bug 2438](https://issues.apache.org/jira/browse/FOP-2438), aplikujte na zdrojové kódy [tento patch](https://issues.apache.org/jira/secure/attachment/12691423/nbsp.patch)

## Návod pro Ubuntu 14.04
```bash
sudo apt-get install xsltproc fop docbook-xsl zip git
git clone https://github.com/pirati-cz/swarmwise-cs
cd swarmwise-cs
make
```

Evenutelní konerze z epub do mobi lze udělat pomocí open-source nástroje [calibre](https://calibre-ebook.com/).
```bash
sudo apt-get install calibre
ebook-convert "swarmwise.epub" "swarmwise.mobi"
```
