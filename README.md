# Swarmwise
Český překlad knihy Swarmwise a webová prezentace.

Pro vygenerování PDF ze zdrojáků budete potřebovat Xsltproc, Fop a DocBook XSL NS Stylesheets v1.78. Pak stačí jen pustit Make.

FOP v1.1 obsahuje chybu, kvůli které se špatně zarovnává obsah (strana v-vii). Pro vysázení finální verze PDF používejte [vývojovou verzi z SVN](http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/).

Pokud ještě není uzavřený [bug 2438](https://issues.apache.org/jira/browse/FOP-2438), aplikujte na zdrojové kódy [tento patch](https://issues.apache.org/jira/secure/attachment/12691423/nbsp.patch)
