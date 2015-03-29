<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY % common.entities SYSTEM "http://docbook.sourceforge.net/release/xsl-ns/current/common/entities.ent">
%common.entities;
]>

<xsl:stylesheet  
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:rx="http://www.renderx.com/XSL/Extensions"
	xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
	version="1.0">

<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/fo/docbook.xsl"/>
<xsl:param name="local.l10n.xml" select="document('l10n-data.xml')"/>
<xsl:param name="page.width">15.2cm</xsl:param>
<xsl:param name="page.height">22.9cm</xsl:param>
<xsl:param name="page.margin.inner">2cm</xsl:param>
<xsl:param name="page.margin.outer">2cm</xsl:param>
<xsl:param name="page.margin.top">1.27cm</xsl:param>
<xsl:param name="page.margin.bottom">1.27cm</xsl:param>
<xsl:param name="body.font.family">Cardo</xsl:param>
<xsl:param name="body.font.size">11pt</xsl:param>
<xsl:param name="title.font.family">Cardo</xsl:param>
<xsl:param name="body.start.indent">0pt</xsl:param>
<xsl:param name="admon.textlabel" select="0"/>
<xsl:param name="generate.toc">
book title
</xsl:param>
<xsl:param name="process.source.toc" select="1"/>
<xsl:param name="process.empty.source.toc" select="1"/>
<xsl:param name="variablelist.as.blocks" select="1"/>
<xsl:param name="double.sided" select="1"/>
<xsl:param name="header.rule" select="0"/>
<xsl:param name="footer.rule" select="0"/>
<xsl:param name="fop1.extensions" select="1"/>
<!-- FIXME: enable index generation when FOP gets support for pageref merging -->
<xsl:param name="generate.index" select="0"/>
<xsl:param name="xref.with.number.and.title" select="0"/>

<xsl:param name="formal.title.placement">
figure after
example before
equation before
table before
procedure before
task before
</xsl:param>

<xsl:attribute-set name="normal.para.spacing">
  <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
  <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0pt</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0pt</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0pt</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0pt</xsl:attribute>
  <xsl:attribute name="text-indent">0.5cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="verbatim.properties">
  <xsl:attribute name="text-indent">0pt</xsl:attribute>
  <xsl:attribute name="wrap-option">inherit</xsl:attribute>
  <xsl:attribute name="text-align">justify</xsl:attribute>
  <xsl:attribute name="page-break-inside">avoid</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.literallayout.properties" use-attribute-sets="verbatim.properties">
  <xsl:attribute name="white-space-collapse">true</xsl:attribute>
  <xsl:attribute name="white-space-treatment">inherit</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="abstract.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="start-indent">inherit</xsl:attribute>
  <xsl:attribute name="end-indent">inherit</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="list.block.spacing">
  <xsl:attribute name="space-before.minimum">
    <xsl:choose>
      <xsl:when test="self::d:variablelist">0pt</xsl:when>
      <xsl:otherwise>0.4em</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="space-before.optimum">
    <xsl:choose>
      <xsl:when test="self::d:variablelist">0pt</xsl:when>
      <xsl:otherwise>0.5em</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="space-before.maximum">
    <xsl:choose>
      <xsl:when test="self::d:variablelist">0pt</xsl:when>
      <xsl:otherwise>0.6em</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="space-after.minimum">
    <xsl:choose>
      <xsl:when test="self::d:variablelist">0pt</xsl:when>
      <xsl:otherwise>0.4em</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="space-after.optimum">
    <xsl:choose>
      <xsl:when test="self::d:variablelist">0pt</xsl:when>
      <xsl:otherwise>0.5em</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="space-after.maximum">
    <xsl:choose>
      <xsl:when test="self::d:variablelist">0pt</xsl:when>
      <xsl:otherwise>0.6em</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="variablelist.term.properties">
  <xsl:attribute name="font-weight">bold</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="mediaobject.properties">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="formal.title.properties">
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:attribute name="text-indent">0pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.colophon.properties">
  <xsl:attribute name="space-before">1em</xsl:attribute>
  <xsl:attribute name="space-after">1em</xsl:attribute>
  <xsl:attribute name="font-size">8pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.colophon.title.properties" use-attribute-sets="swarmwise.colophon.properties">
  <xsl:attribute name="font-size">9pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.cover.properties">
  <xsl:attribute name="margin">5pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="cover.block.spacing">
  <xsl:attribute name="space-before">0.5em</xsl:attribute>
  <xsl:attribute name="space-after">0.5em</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="cover.authorblurb.properties">
  <xsl:attribute name="border-top">0.25mm solid #F7B632</xsl:attribute>
  <xsl:attribute name="padding-top">0.5em</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="cover.author.properties">
  <xsl:attribute name="font-family">Liberation Sans</xsl:attribute>
  <xsl:attribute name="color">#F7B632</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.cover.content.properties">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="margin">1.3cm</xsl:attribute>
  <xsl:attribute name="color">#EBD69E</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.cover.graphic.properties">
  <xsl:attribute name="width">100%</xsl:attribute>
  <xsl:attribute name="height">auto</xsl:attribute>
  <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
  <xsl:attribute name="content-height">100%</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.isbn.properties">
  <xsl:attribute name="space-before">1em</xsl:attribute>
  <xsl:attribute name="font-size">10pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="book.titlepage.verso.style">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="book.titlepage.recto.style">
  <xsl:attribute name="hyphenate">false</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="component.title.properties">
  <xsl:attribute name="text-align">inherit</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.properties">
  <xsl:attribute name="space-before.minimum">1.5cm</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1.5cm</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.5cm</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.75cm</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.75cm</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.75cm</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.level1.properties">
  <xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="section.title.level2.properties">
  <xsl:attribute name="font-size">13pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="chapter.titlepage.recto.style">
  <xsl:attribute name="space-after.minimum">1.5cm</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1.5cm</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.5cm</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:attribute name="keep-with-next">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="toc.line.properties">
  <xsl:attribute name="font-weight">
    <xsl:choose>
      <xsl:when test="self::d:chapter">bold</xsl:when>
      <xsl:otherwise>normal</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="space-before">
    <xsl:choose>
      <xsl:when test="self::d:chapter">0.36cm</xsl:when>
      <xsl:otherwise>0pt</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-page">
    <xsl:choose>
      <xsl:when test="self::d:chapter">always</xsl:when>
      <xsl:otherwise>auto</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.index.line.properties" use-attribute-sets="toc.line.properties"/>

<xsl:attribute-set name="swarmwise.book.titlepage.recto.title">
  <xsl:attribute name="margin-top">4.5cm</xsl:attribute>
  <xsl:attribute name="font-size">52pt</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="font-variant">small-caps</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:attribute name="padding-bottom">0.15cm</xsl:attribute>
  <xsl:attribute name="border-bottom">thin solid black</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.2cm</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.2cm</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.2cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.book.titlepage.recto.subtitle">
  <xsl:attribute name="font-size">16pt</xsl:attribute>
  <xsl:attribute name="font-style">italic</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.4cm</xsl:attribute>
  <xsl:attribute name="space-before.optimum">0.4cm</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.4cm</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.2cm</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.2cm</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.2cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.book.titlepage.recto.author">
  <xsl:attribute name="font-size">22pt</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="text-align">center</xsl:attribute>
  <xsl:attribute name="space-before.minimum">1.27cm</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1.27cm</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.27cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.part.number.properties">
  <xsl:attribute name="font-size">54pt</xsl:attribute>
  <xsl:attribute name="margin-top">1.52cm</xsl:attribute>
  <xsl:attribute name="margin-bottom">0.9cm</xsl:attribute>
  <xsl:attribute name="padding-bottom">0.4cm</xsl:attribute>
  <xsl:attribute name="border-bottom">thin solid black</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.part.title.properties">
  <xsl:attribute name="font-size">24pt</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.chapter.number.properties">
  <xsl:attribute name="font-size">13pt</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.25cm</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.25cm</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.25cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.chapter.title.properties">
  <xsl:attribute name="font-size">22pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.important.properties">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="border-top">medium solid gray</xsl:attribute>
  <xsl:attribute name="border-bottom">medium solid gray</xsl:attribute>
  <xsl:attribute name="font-size">13pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="line-height">1.5</xsl:attribute>
  <xsl:attribute name="color">gray</xsl:attribute>
  <xsl:attribute name="page-break-inside">avoid</xsl:attribute>
  <xsl:attribute name="text-indent">0pt</xsl:attribute>
  <xsl:attribute name="hyphenate">true</xsl:attribute>
  <xsl:attribute name="hyphenation-push-character-count">4</xsl:attribute>
  <xsl:attribute name="hyphenation-remain-character-count">4</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.blockquote.properties" use-attribute-sets="swarmwise.important.properties">
  <xsl:attribute name="border-top-color">#C0C0C0</xsl:attribute>
  <xsl:attribute name="border-bottom-color">#C0C0C0</xsl:attribute>
  <xsl:attribute name="font-weight">normal</xsl:attribute>
  <xsl:attribute name="line-height">1.3</xsl:attribute>
  <xsl:attribute name="padding-top">0.25cm</xsl:attribute>
  <xsl:attribute name="padding-bottom">0.25cm</xsl:attribute>
  <xsl:attribute name="margin-left">0.5cm</xsl:attribute>
  <xsl:attribute name="margin-right">0.5cm</xsl:attribute>
  <xsl:attribute name="font-variant">small-caps</xsl:attribute>
  <xsl:attribute name="background-image">url('img/quotemarks.png')</xsl:attribute>
  <xsl:attribute name="background-repeat">no-repeat</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.attribution.properties">
  <xsl:attribute name="font-style">italic</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.blockquote.para.properties">
  <xsl:attribute name="text-indent">1.27cm</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.literal.properties">
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
  <xsl:attribute name="white-space-collapse">false</xsl:attribute>
  <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.attribution.literal.properties">
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
  <xsl:attribute name="white-space-collapse">false</xsl:attribute>
  <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
  <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.example.properties">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="border">thin solid #C0C0C0</xsl:attribute>
  <xsl:attribute name="background-color">#E6E6E6</xsl:attribute>
  <xsl:attribute name="font-size">11pt</xsl:attribute>
  <xsl:attribute name="padding">0.36cm</xsl:attribute>
  <xsl:attribute name="margin">0pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.example.title.properties">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="keep-with-next">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.preface.para.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-size">8pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.epigraph.para.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-style">italic</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.epigraph.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="font-style">italic</xsl:attribute>
  <xsl:attribute name="break-before">odd-page</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.preface.epigraph.properties" use-attribute-sets="swarmwise.epigraph.properties">
  <xsl:attribute name="break-before">auto</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.highlights.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="margin-top">72pt</xsl:attribute>
  <xsl:attribute name="text-align">justify</xsl:attribute>
  <xsl:attribute name="text-align-last">center</xsl:attribute>
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.highlights.para.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="text-indent">0pt</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.formalpara.properties">
  <xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">0.5em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.6em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.6em</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.formalpara.title.properties">
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="text-indent">0pt</xsl:attribute>
  <xsl:attribute name="keep-with-next">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.appendix.section.properties" use-attribute-sets="section.level1.properties">
  <xsl:attribute name="break-before">even-page</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.page.header.properties" use-attribute-sets="section.level1.properties">
  <xsl:attribute name="font-variant">small-caps</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="swarmwise.toc.part.properties">
  <xsl:attribute name="font-size">12pt</xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
  <xsl:attribute name="space-before.minimum">0.55cm</xsl:attribute>
  <xsl:attribute name="space-before.optimum">0.66cm</xsl:attribute>
  <xsl:attribute name="space-before.maximum">0.75cm</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.3cm</xsl:attribute>
  <xsl:attribute name="space-after.optimum">0.36cm</xsl:attribute>
  <xsl:attribute name="space-after.maximum">0.4cm</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
</xsl:attribute-set>

<!-- Fix page numbers for table of contents -->
<xsl:template name="page.number.format">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:param name="master-reference" select="''"/>

  <xsl:choose>
    <xsl:when test="$element = 'toc' and parent::d:book">i</xsl:when>
    <xsl:when test="$element = 'toc' and self::d:book">i</xsl:when>
    <xsl:when test="$element = 'set'">i</xsl:when>
    <xsl:when test="$element = 'book'">i</xsl:when>
    <xsl:when test="$element = 'preface'">i</xsl:when>
    <xsl:when test="$element = 'dedication'">i</xsl:when>
    <xsl:when test="$element = 'acknowledgements'">i</xsl:when>
    <xsl:otherwise>1</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="toc.line">
  <xsl:param name="toc-context" select="NOTANODE"/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="label">
    <xsl:apply-templates select="." mode="label.markup"/>
  </xsl:variable>

  <fo:block xsl:use-attribute-sets="toc.line.properties">
    <fo:inline keep-with-next.within-line="always">
      <fo:basic-link internal-destination="{$id}">
        <xsl:if test="$label != ''">
          <xsl:copy-of select="$label"/>
          <xsl:value-of select="$autotoc.label.separator"/>
        </xsl:if>
        <xsl:apply-templates select="." mode="titleabbrev.markup"/>
      </fo:basic-link>
    </fo:inline>
    <fo:inline keep-together.within-line="always" keep-with-next.within-line="always">
      <xsl:text> </xsl:text>
      <fo:leader leader-pattern="dots"
                 leader-pattern-width="3pt"
                 leader-alignment="reference-area"
                 keep-with-next.within-line="always"/>
      <xsl:text> </xsl:text>
    </fo:inline>
      <fo:basic-link internal-destination="{$id}">
        <fo:page-number-citation ref-id="{$id}"/>
      </fo:basic-link>
  </fo:block>
</xsl:template>

<!-- Formatting for table of contents -->
<xsl:template match="d:preface" mode="toc"/>

<xsl:template match="d:part" mode="toc">
  <fo:block xsl:use-attribute-sets="swarmwise.toc.part.properties">
    <xsl:apply-templates select="." mode="object.title.markup"/>
<!--
    <xsl:text>: </xsl:text>
    <xsl:apply-templates select="d:title" mode="toc"/>
-->
  </fo:block>
  <xsl:apply-templates select="*[not(self::d:title)]" mode="toc"/>
</xsl:template>

<xsl:template match="d:appendix" mode="object.title.template">
  <xsl:text>Ostatní</xsl:text>
</xsl:template>

<xsl:template match="d:appendix" mode="toc">
  <xsl:param name="toc-context" select="."/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="cid">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$toc-context"/>
    </xsl:call-template>
  </xsl:variable>

  <fo:block xsl:use-attribute-sets="swarmwise.toc.part.properties">
<!--
    <xsl:text>Ostatní</xsl:text>
-->
    <xsl:apply-templates select="." mode="object.title.markup"/>
  </fo:block>
  <fo:block id="toc.{$cid}.{$id}">
    <xsl:attribute name="margin-{$direction.align.start}">
      <xsl:call-template name="set.toc.indent"/>
    </xsl:attribute>

    <xsl:apply-templates select="*[not(self::d:title)]" mode="toc"/>
  </fo:block>
</xsl:template>

<!-- Formatting for <important> blocks with fancy graphics -->
<xsl:template match="d:important">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block xsl:use-attribute-sets="swarmwise.important.properties">
    <fo:table id="{$id}" table-layout="fixed" width="100%">
      <fo:table-column column-width="2cm" column-number="1"/>
      <fo:table-column column-width="proportional-column-width(1)" column-number="2"/>
      <fo:table-body>
        <fo:table-row>
          <fo:table-cell>
            <fo:block>
              <fo:external-graphic src="url('img/thoughtmark.png')"/>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell padding-top="0.25cm" padding-bottom="0.25cm">
            <xsl:call-template name="anchor"/>
            <xsl:apply-templates/>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </fo:block>
</xsl:template>

<xsl:template match="d:important//d:para">
  <fo:block>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- Formatting for <blockquote> blocks with fancy graphics -->
<xsl:template match="d:blockquote">
  <fo:block xsl:use-attribute-sets="swarmwise.blockquote.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates select="*[local-name(.) != 'title'
                                 and local-name(.) != 'attribution']"/>
    <xsl:if test="d:attribution">
      <xsl:choose>
        <xsl:when test="d:attribution/d:literallayout">
          <fo:block text-align="right" xsl:use-attribute-sets="swarmwise.attribution.literal.properties">
            <!-- mdash -->
            <xsl:text>&#x2014; </xsl:text>
            <fo:inline xsl:use-attribute-sets="swarmwise.attribution.properties">
              <xsl:apply-templates select="d:attribution"/>
            </fo:inline>
          </fo:block>
	</xsl:when>
        <xsl:otherwise>
          <fo:block text-align="right">
            <!-- mdash -->
            <xsl:text>&#x2014; </xsl:text>
            <fo:inline xsl:use-attribute-sets="swarmwise.attribution.properties">
              <xsl:apply-templates select="d:attribution"/>
            </fo:inline>
          </fo:block>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template match="d:blockquote/d:para">
  <fo:block xsl:use-attribute-sets="swarmwise.blockquote.para.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:attribution/d:literallayout">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="d:literallayout">
  <fo:block xsl:use-attribute-sets="swarmwise.literallayout.properties">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:literal">
  <fo:inline xsl:use-attribute-sets="swarmwise.literal.properties">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<!-- Formatting for <informalexample> blocks (sample documents) -->
<xsl:template match="d:informalexample">
  <fo:block xsl:use-attribute-sets="swarmwise.example.properties">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:informalexample/d:title">
  <fo:block xsl:use-attribute-sets="swarmwise.example.title.properties">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- Formatting for <preface> body (tiny story inside preface) -->
<xsl:template match="d:preface/d:para">
  <fo:block xsl:use-attribute-sets="swarmwise.preface.para.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- Formatting for <epigraph> blocks (stories at the end of each chapter) -->
<xsl:template match="d:epigraph">
  <fo:block xsl:use-attribute-sets="swarmwise.epigraph.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates select="d:para|d:simpara|d:formalpara|d:literallayout"/>
    <xsl:if test="d:attribution">
      <fo:inline>
        <xsl:text>&#x2014;</xsl:text>
        <xsl:apply-templates select="d:attribution"/>
      </fo:inline>
    </xsl:if>
  </fo:block>
</xsl:template>

<xsl:template match="d:preface/d:epigraph">
  <fo:block xsl:use-attribute-sets="swarmwise.preface.epigraph.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates select="d:para|d:simpara|d:formalpara|d:literallayout"/>
    <xsl:if test="d:attribution">
      <fo:inline>
        <xsl:text>&#x2014;</xsl:text>
        <xsl:apply-templates select="d:attribution"/>
      </fo:inline>
    </xsl:if>
  </fo:block>
</xsl:template>

<!-- Formatting for <highlights> blocks (tiny story inside preface) -->
<xsl:template match="d:highlights">
  <fo:block xsl:use-attribute-sets="swarmwise.highlights.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:highlights/d:para">
  <fo:block xsl:use-attribute-sets="swarmwise.highlights.para.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- Formatting for <variablelist> (yes, it's crazy) -->
<xsl:template match="d:varlistentry" mode="vl.as.blocks">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="local-name(d:listitem/*[1]) = 'para'">
      <xsl:variable name="termcontent">
        <fo:inline id="{$id}" xsl:use-attribute-sets="variablelist.term.properties">
          <xsl:apply-templates select="d:term"/>
	</fo:inline>
      </xsl:variable>
      <xsl:apply-templates select="d:listitem/*[1]">
        <xsl:with-param name="extracontent">
          <xsl:copy-of select="$termcontent"/>
	  <xsl:text> </xsl:text>
	</xsl:with-param>
      </xsl:apply-templates>
      <xsl:apply-templates select="d:listitem/*[position()>1]"/>
    </xsl:when>
    <xsl:otherwise>
      <fo:block id="{$id}" xsl:use-attribute-sets="variablelist.term.properties
                                                   list.item.spacing"
          keep-together.within-column="always" 
          keep-with-next.within-column="always">
        <xsl:apply-templates select="d:term"/>
      </fo:block>

      <fo:block>
        <xsl:apply-templates select="d:listitem"/>
      </fo:block>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="d:varlistentry//d:para">
  <xsl:param name="extracontent" select="''"/>

  <fo:block xsl:use-attribute-sets="para.properties">
    <xsl:copy-of select="$extracontent"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:varlistentry/d:listitem">
  <xsl:apply-templates/>
</xsl:template>

<!-- Formatting for <mediaobject> with margins etc. -->
<xsl:template match="d:mediaobject|d:mediaobjectco">

  <xsl:variable name="olist" select="d:imageobject|d:imageobjectco
                     |d:videoobject|d:audioobject
                     |d:textobject"/>

  <xsl:variable name="object.index">
    <xsl:call-template name="select.mediaobject.index">
      <xsl:with-param name="olist" select="$olist"/>
      <xsl:with-param name="count" select="1"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object" select="$olist[position() = $object.index]"/>

  <xsl:variable name="align">
    <xsl:value-of select="$object/descendant::d:imagedata[@align][1]/@align"/>
  </xsl:variable>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block id="{$id}" xsl:use-attribute-sets="mediaobject.properties">
    <xsl:if test="$align != '' ">
      <xsl:attribute name="text-align">
        <xsl:value-of select="$align"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates select="$object"/>
    <xsl:apply-templates select="d:caption"/>
  </fo:block>
</xsl:template>

<xsl:template match="d:figure|d:table|d:example" mode="label.markup">
  <xsl:choose>
    <xsl:when test="@label">
      <xsl:value-of select="@label"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:number format="1" from="d:book|d:article" level="any"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- Page header/footer formatting -->
<xsl:template name="header.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <xsl:choose>
    <xsl:when test="$position = 'center' and $sequence = 'odd' and local-name(.) != 'colophon'">
      <fo:block xsl:use-attribute-sets="swarmwise.page.header.properties">
        <xsl:value-of select="/d:book/d:bookinfo/d:author"/>
      </fo:block>
    </xsl:when>
    <xsl:when test="$position = 'center' and $sequence = 'even' and local-name(.) != 'colophon'">
      <fo:block xsl:use-attribute-sets="swarmwise.page.header.properties">
        <xsl:value-of select="/d:book/d:bookinfo/d:title"/>
      </fo:block>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="footer.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <fo:block>
    <xsl:choose>
      <xsl:when test="$pageclass = 'titlepage'">
      </xsl:when>
      <xsl:when test="$position='center' and local-name(.) != 'colophon'">
        <fo:page-number/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- Formatting for <formalpara> -->
<xsl:template match="d:formalpara">
  <fo:block xsl:use-attribute-sets="swarmwise.formalpara.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:formalpara/d:title|d:formalpara/d:info/d:title">
  <fo:block xsl:use-attribute-sets="swarmwise.formalpara.title.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:formalpara/d:para">
  <fo:block xsl:use-attribute-sets="para.properties">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- Formatting for title pages -->
<xsl:template match="d:title" mode="part.titlepage.recto.auto.mode">
  <fo:block xsl:use-attribute-sets="part.titlepage.recto.style">
    <fo:block xsl:use-attribute-sets="swarmwise.part.number.properties">
<!--
      <xsl:call-template name="division.title">
        <xsl:with-param name="node" select="ancestor-or-self::d:part[1]"/>
      </xsl:call-template>
-->
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'part'"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="ancestor::d:part[1]" mode="label.markup"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="swarmwise.part.title.properties">
      <xsl:apply-templates/>
    </fo:block>
  </fo:block>
</xsl:template>

<xsl:template match="d:title" mode="chapter.titlepage.recto.auto.mode">
  <fo:block xsl:use-attribute-sets="chapter.titlepage.recto.style">
    <fo:block xsl:use-attribute-sets="swarmwise.chapter.number.properties">
<!--
      <xsl:call-template name="component.title">
        <xsl:with-param name="node" select="ancestor-or-self::d:chapter[1]"/>
      </xsl:call-template>
-->
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'chapter'"/>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="ancestor::d:chapter[1]" mode="label.markup"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="swarmwise.chapter.title.properties">
      <xsl:apply-templates/>
    </fo:block>
  </fo:block>
</xsl:template>

<xsl:template match="d:appendix/d:section">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:element name="fo:{$section.container.element}"
           use-attribute-sets="swarmwise.appendix.section.properties">
    <xsl:attribute name="id"><xsl:value-of 
                        select="$id"/></xsl:attribute>
    <xsl:call-template name="section.content"/>
  </xsl:element>
</xsl:template>

<!-- Fix page numbering after front cover -->
<xsl:template name="initial.page.number">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:param name="master-reference" select="''"/>

  <xsl:variable name="first">
    <xsl:choose>
      <xsl:when test="$force.blank.pages = 0">auto</xsl:when>
      <xsl:otherwise>auto-odd</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <!-- Select the first content that the stylesheet places
       after the TOC -->
  <xsl:variable name="first.book.content"
                select="ancestor::d:book/*[
                          not(self::d:title or
                              self::d:subtitle or
                              self::d:titleabbrev or
                              self::d:bookinfo or
                              self::d:info or
                              self::d:dedication or
                              self::d:acknowledgements or
                              self::d:preface or
                              self::d:toc or
                              self::d:lot)][1]"/>
  <xsl:choose>
    <!-- double-sided output -->
    <xsl:when test="$double.sided != 0">
      <xsl:choose>
        <xsl:when test="$element = 'toc'"><xsl:value-of select="$first"/></xsl:when>
        <xsl:when test="$element = 'book'">
	  <xsl:choose>
	    <xsl:when test="$master-reference = 'titlepage'">1</xsl:when>
            <xsl:otherwise><xsl:value-of select="$first"/></xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
        <!-- preface typically continues TOC roman numerals -->
        <!-- If changed to 1 here, then change page.number.format too -->
        <xsl:when test="$element = 'preface'"><xsl:value-of select="$first"/></xsl:when>
        <xsl:when test="($element = 'dedication' or $element = 'article')
                    and not(preceding::d:chapter
                            or preceding::d:preface
                            or preceding::d:appendix
                            or preceding::d:article
                            or preceding::d:dedication
                            or parent::d:part
                            or parent::d:reference)">1</xsl:when>
        <xsl:when test="generate-id($first.book.content) =
                        generate-id(.)">1</xsl:when>
        <xsl:otherwise><xsl:value-of select="$first"/></xsl:otherwise>
      </xsl:choose>
    </xsl:when>

    <!-- single-sided output -->
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$element = 'toc'">auto</xsl:when>
        <xsl:when test="$element = 'book'">
	  <xsl:choose>
	    <xsl:when test="$master-reference = 'titlepage'">1</xsl:when>
            <xsl:otherwise>auto</xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
        <xsl:when test="$element = 'preface'">auto</xsl:when>
       <xsl:when test="($element = 'dedication' or $element = 'article') and
                        not(preceding::d:chapter
                            or preceding::d:preface
                            or preceding::d:appendix
                            or preceding::d:article
                            or preceding::d:dedication
                            or parent::d:part
                            or parent::d:reference)">1</xsl:when>
        <xsl:when test="generate-id($first.book.content) =
                        generate-id(.)">1</xsl:when>
        <xsl:otherwise>auto</xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="user.pagemasters">
    <fo:simple-page-master master-name="swarmwise-cover-page"
                           page-width="{$page.width}"
                           page-height="{$page.height}"
                           margin="0pt">
      <xsl:if test="$axf.extensions != 0">
        <xsl:call-template name="axf-page-master-properties">
          <xsl:with-param name="page.master">titlepage-first</xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <fo:region-body margin="0pt"
                      background-color="#322D59"
                      column-gap="{$column.gap.titlepage}"
                      column-count="{$column.count.titlepage}">
      </fo:region-body>
    </fo:simple-page-master>
    <fo:page-sequence-master master-name="swarmwise-cover">
      <fo:single-page-master-reference master-reference="swarmwise-cover-page"/>
    </fo:page-sequence-master>
</xsl:template>

<xsl:template name="front.cover">
  <xsl:call-template name="page.sequence">
    <xsl:with-param name="master-reference" select="'swarmwise-cover'"/>
    <xsl:with-param name="initial-page-number" select="1"/>
    <xsl:with-param name="force-page-count">no-force</xsl:with-param>
    <xsl:with-param name="content">
      <fo:block xsl:use-attribute-sets="swarmwise.cover.properties">
        <fo:external-graphic src="url('img/obalka.svg')" xsl:use-attribute-sets="swarmwise.cover.graphic.properties"/>
      </fo:block>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="back.cover">
  <xsl:call-template name="page.sequence">
    <xsl:with-param name="master-reference" select="'swarmwise-cover'"/>
    <xsl:with-param name="initial-page-number" select="1"/>
    <xsl:with-param name="force-page-count">no-force</xsl:with-param>
    <xsl:with-param name="content">
      <fo:block xsl:use-attribute-sets="swarmwise.cover.content.properties">
        <fo:external-graphic src="url('img/rick.png')" xsl:use-attribute-sets="swarmwise.cover.graphic.properties"/>
        <xsl:apply-templates select="/d:book/d:bookinfo/d:abstract" mode="cover"/>
        <xsl:apply-templates select="/d:book/d:bookinfo/d:authorblurb" mode="cover"/>
      </fo:block>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="d:abstract" mode="cover">
  <fo:block xsl:use-attribute-sets="cover.block.spacing">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:authorblurb" mode="cover">
  <fo:block xsl:use-attribute-sets="cover.authorblurb.properties">
    <xsl:apply-templates select="/d:book/d:bookinfo/d:author" mode="cover"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:author" mode="cover">
  <fo:inline xsl:use-attribute-sets="cover.author.properties">
    <xsl:apply-templates select="d:honorific"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="d:firstname"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="d:othername"/>
    <xsl:text> </xsl:text>
    <fo:inline font-weight="bold">
      <xsl:apply-templates select="d:surname"/>
    </fo:inline>
  </fo:inline>
</xsl:template>

<xsl:template match="d:copyright" mode="book.titlepage.verso.auto.mode">
  <xsl:variable name="role">
    <xsl:choose>
      <xsl:when test="@role">
        <xsl:value-of select="@role"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'copyright'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <fo:block>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="$role"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="dingbat">
      <xsl:with-param name="dingbat">copyright</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:call-template name="copyright.years">
      <xsl:with-param name="years" select="d:year"/>
      <xsl:with-param name="print.ranges" select="$make.year.ranges"/>
      <xsl:with-param name="single.year.ranges"
                      select="$make.single.year.ranges"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates select="d:holder" mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="d:author|d:bookinfo/d:title|d:book/d:title" mode="colophon.mode">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="d:colophon">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="master-reference">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <xsl:call-template name="page.sequence">
    <xsl:with-param name="master-reference" select="$master-reference"/>
    <xsl:with-param name="initial-page-number">auto</xsl:with-param>
    <xsl:with-param name="force-page-count">no-force</xsl:with-param>
    <xsl:with-param name="content">
      <fo:block break-after="even-page"/>
      <fo:block-container position="absolute" bottom="0pt" display-align="after">
        <fo:block xsl:use-attribute-sets="swarmwise.colophon.title.properties">
          <xsl:apply-templates select="/d:book/d:bookinfo/d:author" mode="colophon.mode"/>
          <xsl:apply-templates select="/d:book/d:bookinfo/d:title" mode="colophon.mode"/>
	</fo:block>
        <fo:block xsl:use-attribute-sets="swarmwise.colophon.properties">
          <xsl:apply-templates/>
        </fo:block>
      </fo:block-container>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="d:isbn" mode="book.titlepage.verso.auto.mode">
  <fo:block xsl:use-attribute-sets="swarmwise.isbn.properties">
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'ISBN'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template name="swarmwise.impressum">
  <fo:block-container position="absolute" bottom="0pt" display-align="after">
    <fo:block xsl:use-attribute-sets="book.titlepage.verso.style">
      <xsl:apply-templates select="d:bookinfo/d:copyright" mode="book.titlepage.verso.auto.mode"/>
      <xsl:apply-templates select="d:bookinfo/d:isbn" mode="book.titlepage.verso.auto.mode"/>
      </fo:block>
  </fo:block-container>
</xsl:template>

<xsl:template match="d:legalnotice" mode="book.titlepage.verso.auto.mode">
  <fo:block xsl:use-attribute-sets="book.titlepage.verso.style">
    <xsl:apply-templates select="." mode="book.titlepage.verso.mode"/>
  </fo:block>
</xsl:template>

<xsl:template name="book.titlepage.verso">
  <fo:block>
    <xsl:apply-templates select="d:bookinfo/d:legalnotice" mode="book.titlepage.verso.auto.mode"/>
    <xsl:apply-templates select="d:info/d:legalnotice" mode="book.titlepage.verso.auto.mode"/>
  </fo:block>
  <xsl:call-template name="swarmwise.impressum"/>
</xsl:template>

<xsl:template name="book.titlepage.recto">
  <fo:block xsl:use-attribute-sets="swarmwise.book.titlepage.recto.title">
    <xsl:apply-templates select="/d:book/d:bookinfo/d:title" mode="titlepage.mode"/>
  </fo:block>
  <fo:block xsl:use-attribute-sets="swarmwise.book.titlepage.recto.subtitle">
    <xsl:apply-templates select="/d:book/d:bookinfo/d:subtitle" mode="titlepage.mode"/>
  </fo:block>
  <fo:block xsl:use-attribute-sets="swarmwise.book.titlepage.recto.author">
    <xsl:apply-templates select="/d:book/d:bookinfo/d:author" mode="swarmwise.titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="d:author" mode="swarmwise.titlepage.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="d:author" mode="titlepage.mode"/>
<xsl:template match="d:othercredit" mode="titlepage.mode"/>
<xsl:template match="d:abstract" mode="titlepage.mode"/>

<xsl:template match="d:book" mode="running.head.mode"/>
<xsl:template match="d:book" mode="running.foot.mode"/>
<xsl:template match="d:preface" mode="running.head.mode"/>

<!-- Formatting for <index> -->
<xsl:template name="indexdiv.title"/>

<xsl:template name="index.titlepage.recto">
  <fo:block xsl:use-attribute-sets="swarmwise.appendix.section.properties section.title.properties section.title.level1.properties">
<xsl:call-template name="component.title">
<xsl:with-param name="node" select="ancestor-or-self::d:index[1]"/>
<xsl:with-param name="pagewide" select="1"/>
</xsl:call-template></fo:block>
  <xsl:choose>
    <xsl:when test="d:indexinfo/d:subtitle">
      <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:indexinfo/d:subtitle"/>
    </xsl:when>
    <xsl:when test="d:docinfo/d:subtitle">
      <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:docinfo/d:subtitle"/>
    </xsl:when>
    <xsl:when test="d:info/d:subtitle">
      <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:info/d:subtitle"/>
    </xsl:when>
    <xsl:when test="d:subtitle">
      <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:subtitle"/>
    </xsl:when>
  </xsl:choose>

  <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:indexinfo/d:itermset"/>
  <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:docinfo/d:itermset"/>
  <xsl:apply-templates mode="index.titlepage.recto.auto.mode" select="d:info/d:itermset"/>
</xsl:template>

<xsl:template name="swarmwise.index.line">
  <xsl:param name="term"/>
  <xsl:param name="pagerefs"/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <fo:block xsl:use-attribute-sets="swarmwise.index.line.properties">
    <fo:inline keep-with-next.within-line="always">
      <xsl:value-of select="$term"/>
    </fo:inline>
    <fo:inline keep-together.within-line="always" keep-with-next.within-line="always">
      <xsl:text> </xsl:text>
      <fo:leader leader-pattern="dots"
                 leader-pattern-width="3pt"
                 leader-alignment="reference-area"
                 keep-with-next.within-line="always"/>
      <xsl:text> </xsl:text>
    </fo:inline>
    <xsl:copy-of select="$pagerefs"/>
  </fo:block>
</xsl:template>

<xsl:template match="d:indexterm" mode="index-primary">
  <xsl:param name="scope" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="type" select="''"/>

  <xsl:variable name="key" select="&primary;"/>
  <xsl:variable name="refs" select="key('primary', $key)[&scope;]"/>

  <xsl:variable name="term.separator">
    <xsl:call-template name="index.separator">
      <xsl:with-param name="key" select="'index.term.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="range.separator">
    <xsl:call-template name="index.separator">
      <xsl:with-param name="key" select="'index.range.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="number.separator">
    <xsl:call-template name="index.separator">
      <xsl:with-param name="key" select="'index.number.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="term">
    <xsl:for-each select="$refs/d:primary">
      <xsl:if test="@id or @xml:id">
        <fo:inline id="{(@id|@xml:id)[1]}"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:value-of select="d:primary"/>
  </xsl:variable>

  <xsl:variable name="pagerefs">
    <xsl:choose>
      <xsl:when test="$xep.extensions != 0">
        <xsl:if test="$refs[not(d:see) and not(d:secondary)]">
          <xsl:copy-of select="$term.separator"/>
          <xsl:variable name="primary" select="&primary;"/>
          <xsl:variable name="primary.significant" select="concat(&primary;, $significant.flag)"/>
          <rx:page-index list-separator="{$number.separator}"
                         range-separator="{$range.separator}">
            <xsl:if test="$refs[@significance='preferred'][not(d:see) and not(d:secondary)]">
              <rx:index-item xsl:use-attribute-sets="index.preferred.page.properties xep.index.item.properties"
                ref-key="{$primary.significant}"/>
            </xsl:if>
            <xsl:if test="$refs[not(@significance) or @significance!='preferred'][not(d:see) and not(d:secondary)]">
              <rx:index-item xsl:use-attribute-sets="xep.index.item.properties"
                ref-key="{$primary}"/>
            </xsl:if>
          </rx:page-index>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="page-number-citations">
          <xsl:for-each select="$refs[not(d:see)
                                and not(d:secondary)]">
            <xsl:apply-templates select="." mode="reference">
              <xsl:with-param name="scope" select="$scope"/>
              <xsl:with-param name="role" select="$role"/>
              <xsl:with-param name="type" select="$type"/>
              <xsl:with-param name="position" select="position()"/>
            </xsl:apply-templates>
          </xsl:for-each>
        </xsl:variable>

        <xsl:copy-of select="$page-number-citations"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <fo:block>
    <xsl:if test="$axf.extensions != 0">
      <xsl:attribute name="axf:suppress-duplicate-page-number">true</xsl:attribute>
    </xsl:if>

    <xsl:call-template name="swarmwise.index.line">
      <xsl:with-param name="term" select="$term"/>
      <xsl:with-param name="pagerefs" select="$pagerefs"/>
    </xsl:call-template>

    <xsl:if test="$refs[not(d:secondary)]/*[self::d:see]">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &sep;, &sep;, d:see))[&scope;][1])]"
                           mode="index-see">
         <xsl:with-param name="scope" select="$scope"/>
         <xsl:with-param name="role" select="$role"/>
         <xsl:with-param name="type" select="$type"/>
         <xsl:sort select="translate(d:see, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </xsl:if>

  </fo:block>

  <xsl:if test="$refs/d:secondary or $refs[not(d:secondary)]/*[self::d:seealso]">
    <fo:block start-indent="1pc">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &sep;, &sep;, d:seealso))[&scope;][1])]"
                           mode="index-seealso">
         <xsl:with-param name="scope" select="$scope"/>
         <xsl:with-param name="role" select="$role"/>
         <xsl:with-param name="type" select="$type"/>
         <xsl:sort select="translate(d:seealso, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="$refs[d:secondary and count(.|key('secondary', concat($key, &sep;, &secondary;))[&scope;][1]) = 1]"
                           mode="index-secondary">
       <xsl:with-param name="scope" select="$scope"/>
       <xsl:with-param name="role" select="$role"/>
       <xsl:with-param name="type" select="$type"/>
       <xsl:sort select="translate(&secondary;, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </fo:block>
  </xsl:if>
</xsl:template>

<xsl:template match="d:indexterm" mode="index-secondary">
  <xsl:param name="scope" select="."/>
  <xsl:param name="role" select="''"/>
  <xsl:param name="type" select="''"/>

  <xsl:variable name="key" select="concat(&primary;, &sep;, &secondary;)"/>
  <xsl:variable name="refs" select="key('secondary', $key)[&scope;]"/>

  <xsl:variable name="term.separator">
    <xsl:call-template name="index.separator">
      <xsl:with-param name="key" select="'index.term.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="range.separator">
    <xsl:call-template name="index.separator">
      <xsl:with-param name="key" select="'index.range.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="number.separator">
    <xsl:call-template name="index.separator">
      <xsl:with-param name="key" select="'index.number.separator'"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="term">
    <xsl:for-each select="$refs/d:secondary">
      <xsl:if test="@id or @xml:id">
        <fo:inline id="{(@id|@xml:id)[1]}"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:value-of select="d:secondary"/>
  </xsl:variable>

  <xsl:variable name="pagerefs">
    <xsl:choose>
      <xsl:when test="$xep.extensions != 0">
        <xsl:if test="$refs[not(d:see) and not(d:tertiary)]">
          <xsl:copy-of select="$term.separator"/>
          <xsl:variable name="primary" select="&primary;"/>
          <xsl:variable name="secondary" select="&secondary;"/>
          <xsl:variable name="primary.significant" select="concat(&primary;, $significant.flag)"/>
          <rx:page-index list-separator="{$number.separator}"
                         range-separator="{$range.separator}">
            <xsl:if test="$refs[@significance='preferred'][not(d:see) and not(d:tertiary)]">
              <rx:index-item xsl:use-attribute-sets="index.preferred.page.properties xep.index.item.properties">
                <xsl:attribute name="ref-key">
                  <xsl:value-of select="$primary.significant"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="$secondary"/>
                </xsl:attribute>
              </rx:index-item>
            </xsl:if>
            <xsl:if test="$refs[not(@significance) or @significance!='preferred'][not(d:see) and not(d:tertiary)]">
              <rx:index-item xsl:use-attribute-sets="xep.index.item.properties">
                <xsl:attribute name="ref-key">
                  <xsl:value-of select="$primary"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="$secondary"/>
                </xsl:attribute>
              </rx:index-item>
            </xsl:if>
          </rx:page-index>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="page-number-citations">
          <xsl:for-each select="$refs[not(d:see)
                                and not(d:tertiary)]">
            <xsl:apply-templates select="." mode="reference">
              <xsl:with-param name="scope" select="$scope"/>
              <xsl:with-param name="role" select="$role"/>
              <xsl:with-param name="type" select="$type"/>
              <xsl:with-param name="position" select="position()"/>
            </xsl:apply-templates>
          </xsl:for-each>
        </xsl:variable>

        <xsl:copy-of select="$page-number-citations"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <fo:block>
    <xsl:if test="$axf.extensions != 0">
      <xsl:attribute name="axf:suppress-duplicate-page-number">true</xsl:attribute>
    </xsl:if>

    <xsl:call-template name="swarmwise.index.line">
      <xsl:with-param name="term" select="$term"/>
      <xsl:with-param name="pagerefs" select="$pagerefs"/>
    </xsl:call-template>

    <xsl:if test="$refs[not(d:tertiary)]/*[self::d:see]">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &secondary;, &sep;, &sep;, d:see))[&scope;][1])]"
                           mode="index-see">
        <xsl:with-param name="scope" select="$scope"/>
        <xsl:with-param name="role" select="$role"/>
        <xsl:with-param name="type" select="$type"/>
        <xsl:sort select="translate(d:see, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </xsl:if>

  </fo:block>

  <xsl:if test="$refs/d:tertiary or $refs[not(d:tertiary)]/*[self::d:seealso]">
    <fo:block start-indent="2pc">
      <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &secondary;, &sep;, &sep;, d:seealso))[&scope;][1])]"
                           mode="index-seealso">
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(d:seealso, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
      <xsl:apply-templates select="$refs[d:tertiary and count(.|key('tertiary', concat($key, &sep;, &tertiary;))[&scope;][1]) = 1]"
                           mode="index-tertiary">
          <xsl:with-param name="scope" select="$scope"/>
          <xsl:with-param name="role" select="$role"/>
          <xsl:with-param name="type" select="$type"/>
          <xsl:sort select="translate(&tertiary;, &lowercase;, &uppercase;)"/>
      </xsl:apply-templates>
    </fo:block>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
