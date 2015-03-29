Pro vygenerování PDF ze zdrojáků budete potřebovat Xsltproc, Fop a DocBook XSL NS Stylesheets v1.78. Pak stačí jen pustit Make.

FOP v1.1 obsahuje chybu, kvůli které se špatně zarovnává obsah (strana v-vii). Pro vysázení finální verze PDF používejte vývojovou verzi z SVN:
http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/

Pokud ještě není uzavřený bug 2438, aplikujte na zdrojové kódy tento patch:
https://issues.apache.org/jira/secure/attachment/12691423/nbsp.patch

----------

You need Xsltproc, FOP and DocBook XSL NS Stylesheets v1.78 for generating PDF from these sources. Then just run Make.

FOP v1.1 has a bug which causes alignment problems in Table of Contents. Use development version to generate final PDF. SVN repository:
http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk/

If bug 2438 is still open, you'll also need to apply the following patch to FOP sources:
https://issues.apache.org/jira/secure/attachment/12691423/nbsp.patch
