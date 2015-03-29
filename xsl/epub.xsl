<?xml version='1.0'?>
<xsl:stylesheet
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	version="1.0">
<xsl:import href="epub-base.xsl"/>
<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/chunk-common.xsl"/>
<xsl:include href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/chunk-code.xsl"/>
<xsl:include href="http://docbook.sourceforge.net/release/xsl-ns/current/epub3/epub3-chunk-mods.xsl"/>

<xsl:param name="generate.toc">
book      title
</xsl:param>
<xsl:param name="process.empty.source.toc" select="1"/>
<xsl:param name="process.source.toc" select="1"/>
<xsl:param name="epub.cover.linear" select="1"/>

<xsl:template name="user.manifest.items">
  <xsl:element namespace="{$opf.namespace}" name="item">
    <xsl:attribute name="id">swarmwise-chunk-impressum</xsl:attribute>
    <xsl:attribute name="href">
      <xsl:value-of select="concat('impressum', $html.ext)"/>
    </xsl:attribute>
    <xsl:attribute name="media-type">application/xhtml+xml</xsl:attribute>
  </xsl:element>
  <xsl:element namespace="{$opf.namespace}" name="item">
    <xsl:attribute name="id">swarmwise-chunk-back-cover</xsl:attribute>
    <xsl:attribute name="href">
      <xsl:value-of select="concat('cover-back', $html.ext)"/>
    </xsl:attribute>
    <xsl:attribute name="media-type">application/xhtml+xml</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-img-rick</xsl:attribute>
    <xsl:attribute name="href">img/rick.png</xsl:attribute>
    <xsl:attribute name="media-type">image/png</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-img-thoughtmark</xsl:attribute>
    <xsl:attribute name="href">img/thoughtmark.png</xsl:attribute>
    <xsl:attribute name="media-type">image/png</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-img-quotemarks</xsl:attribute>
    <xsl:attribute name="href">img/quotemarks.png</xsl:attribute>
    <xsl:attribute name="media-type">image/png</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template name="chunk">
  <xsl:param name="node" select="."/>
  <!-- returns 1 if $node is a chunk -->

  <xsl:choose>
    <xsl:when test="$node/parent::*/processing-instruction('dbhtml')[normalize-space(.) = 'stop-chunking']">0</xsl:when>
    <xsl:when test="not($node/parent::*)">1</xsl:when>

    <xsl:when test="local-name($node) = 'sect1'                     and $chunk.section.depth &gt;= 1                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::d:sect1) &gt; 0)">
      <xsl:text>1</xsl:text>
    </xsl:when>
    <xsl:when test="local-name($node) = 'sect2'                     and $chunk.section.depth &gt;= 2                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::d:sect2) &gt; 0)">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="$node/parent::*"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="local-name($node) = 'sect3'                     and $chunk.section.depth &gt;= 3                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::d:sect3) &gt; 0)">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="$node/parent::*"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="local-name($node) = 'sect4'                     and $chunk.section.depth &gt;= 4                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::d:sect4) &gt; 0)">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="$node/parent::*"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="local-name($node) = 'sect5'                     and $chunk.section.depth &gt;= 5                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::d:sect5) &gt; 0)">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="$node/parent::*"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="local-name($node) = 'section'                     and $chunk.section.depth &gt;= count($node/ancestor::d:section)+1                     and ($chunk.first.sections != 0                          or count($node/preceding-sibling::d:section) &gt; 0)">
      <xsl:call-template name="chunk">
        <xsl:with-param name="node" select="$node/parent::*"/>
      </xsl:call-template>
    </xsl:when>

    <xsl:when test="local-name($node)='toc'">1</xsl:when>
<!-- No chunking of epigraphs because of that stupid picture in chapter 9...
    <xsl:when test="local-name($node)='epigraph' and $node/parent::d:chapter">1</xsl:when>
-->
    <xsl:when test="local-name($node)='preface'">1</xsl:when>
    <xsl:when test="local-name($node)='chapter'">1</xsl:when>
    <xsl:when test="local-name($node)='appendix'">1</xsl:when>
    <xsl:when test="local-name($node)='article'">1</xsl:when>
    <xsl:when test="local-name($node)='topic'">1</xsl:when>
    <xsl:when test="local-name($node)='part'">1</xsl:when>
    <xsl:when test="local-name($node)='reference'">1</xsl:when>
    <xsl:when test="local-name($node)='refentry'">1</xsl:when>
    <xsl:when test="local-name($node)='index' and ($generate.index != 0 or count($node/*) &gt; 0)                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
    <xsl:when test="local-name($node)='bibliography'                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
    <xsl:when test="local-name($node)='glossary'                     and (local-name($node/parent::*) = 'article'                     or local-name($node/parent::*) = 'book'                     or local-name($node/parent::*) = 'part'                     )">1</xsl:when>
    <xsl:when test="local-name($node)='colophon'">1</xsl:when>
    <xsl:when test="local-name($node)='book'">1</xsl:when>
    <xsl:when test="local-name($node)='set'">1</xsl:when>
    <xsl:when test="local-name($node)='setindex'">1</xsl:when>
    <xsl:when test="local-name($node)='legalnotice'                     and $generate.legalnotice.link != 0">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="d:toc|d:epigraph" mode="recursive-chunk-filename" priority="1">
  <xsl:param name="recursive" select="false()"/>

  <!-- returns the filename of a chunk -->
  <xsl:variable name="ischunk">
    <xsl:call-template name="chunk"/>
  </xsl:variable>

  <xsl:variable name="dbhtml-filename">
    <xsl:call-template name="pi.dbhtml_filename"/>
  </xsl:variable>

  <xsl:variable name="filename">
    <xsl:choose>
      <xsl:when test="$dbhtml-filename != ''">
        <xsl:value-of select="$dbhtml-filename"/>
      </xsl:when>
      <!-- if this is the root element, use the root.filename -->
      <xsl:when test="not(parent::*) and $root.filename != ''">
        <xsl:value-of select="$root.filename"/>
        <xsl:value-of select="$html.ext"/>
      </xsl:when>
      <!-- Special case -->
      <xsl:when test="self::d:legalnotice and not($generate.legalnotice.link = 0)">
        <xsl:choose>
          <xsl:when test="(@id or @xml:id) and not($use.id.as.filename = 0)">
            <!-- * if this legalnotice has an ID, then go ahead and use -->
            <!-- * just the value of that ID as the basename for the file -->
            <!-- * (that is, without prepending an "ln-" too it) -->
            <xsl:value-of select="(@id|@xml:id)[1]"/>
            <xsl:value-of select="$html.ext"/>
          </xsl:when>
          <xsl:otherwise>
            <!-- * otherwise, if this legalnotice does not have an ID, -->
            <!-- * then we generate an ID... -->
            <xsl:variable name="id">
              <xsl:call-template name="object.id"/>
            </xsl:variable>
            <!-- * ...and then we take that generated ID, prepend an -->
            <!-- * "ln-" to it, and use that as the basename for the file -->
            <xsl:value-of select="concat('ln-',$id,$html.ext)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- if there's no dbhtml filename, and if we're to use IDs as -->
      <!-- filenames, then use the ID to generate the filename. -->
      <xsl:when test="(@id or @xml:id) and $use.id.as.filename != 0">
        <xsl:value-of select="(@id|@xml:id)[1]"/>
        <xsl:value-of select="$html.ext"/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$ischunk='0'">
      <!-- if called on something that isn't a chunk, walk up... -->
      <xsl:choose>
        <xsl:when test="count(parent::*)&gt;0">
          <xsl:apply-templates mode="recursive-chunk-filename" select="parent::*">
            <xsl:with-param name="recursive" select="$recursive"/>
          </xsl:apply-templates>
        </xsl:when>
        <!-- unless there is no up, in which case return "" -->
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:when>

    <xsl:when test="not($recursive) and $filename != ''">
      <!-- if this chunk has an explicit name, use it -->
      <xsl:value-of select="$filename"/>
    </xsl:when>

    <xsl:otherwise>
      <xsl:if test="/d:set">
        <!-- in a set, make sure we inherit the right book info... -->
        <xsl:apply-templates mode="recursive-chunk-filename" select="parent::*">
          <xsl:with-param name="recursive" select="true()"/>
        </xsl:apply-templates>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="self::d:toc">
          <xsl:text>toc</xsl:text>
	</xsl:when>
	<xsl:otherwise>
          <xsl:text>epi</xsl:text>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:number level="any" format="01" from="d:book"/>
      <xsl:if test="not($recursive)">
        <xsl:value-of select="$html.ext"/>
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="d:toc|d:epigraph" priority="1">
  <xsl:variable name="ischunk">
    <xsl:call-template name="chunk"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$ischunk = 0">
      <xsl:apply-imports/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="process-chunk-element"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="swarmwise.wrap.chunk">
  <xsl:param name="title">
    <xsl:apply-templates select="$node" mode="object.title.markup.textonly"/>
  </xsl:param>
  <xsl:param name="content" select="''"/>

  <html>
    <head>
      <xsl:call-template name="system.head.content"/>
      <xsl:call-template name="head.content">
        <xsl:with-param name="title" select="$title"/>
      </xsl:call-template>
    </head>
    <body>
      <xsl:call-template name="body.attributes"/>
      <xsl:copy-of select="$content"/>
    </body>
  </html>
</xsl:template>

<xsl:template name="swarmwise.impressum">
  <xsl:call-template name="write.chunk">
    <xsl:with-param name="filename">
      <xsl:value-of select="concat($base.dir, 'impressum', $html.ext)" />
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="swarmwise.wrap.chunk">
        <xsl:with-param name="title" select="'Přední obálka'"/>
        <xsl:with-param name="content">
          <div class="impressum">
            <xsl:apply-templates select="d:bookinfo/d:legalnotice" mode="book.titlepage.verso.auto.mode"/>
            <xsl:apply-templates select="d:info/d:legalnotice" mode="book.titlepage.verso.auto.mode"/>
            <xsl:apply-templates select="d:bookinfo/d:copyright" mode="book.titlepage.verso.auto.mode"/>
            <xsl:apply-templates select="d:bookinfo/d:isbn" mode="book.titlepage.verso.auto.mode"/>
          </div>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="front.cover">
  <xsl:call-template name="write.chunk">
    <xsl:with-param name="filename">
      <xsl:value-of select="$epub.cover.pathname" />
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="swarmwise.wrap.chunk">
        <xsl:with-param name="title" select="'Přední obálka'"/>
        <xsl:with-param name="content">
          <div class="front-cover">
            <img src="img/obalka-bg.svg" alt=""/>
          </div>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="back.cover">
  <xsl:call-template name="write.chunk">
    <xsl:with-param name="filename">
      <xsl:value-of select="concat($base.dir, 'cover-back', $html.ext)" />
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="swarmwise.wrap.chunk">
        <xsl:with-param name="title" select="'Zadní obálka'"/>
        <xsl:with-param name="content">
          <div class="back-cover">
            <img src="img/rick.png" alt=""/>
            <xsl:apply-templates select="/d:book/d:bookinfo/d:abstract" mode="cover"/>
            <xsl:apply-templates select="/d:book/d:bookinfo/d:authorblurb" mode="cover"/>
          </div>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="metadata.cover">
  <xsl:element name="meta" namespace="{$opf.namespace}">
    <xsl:attribute name="content">
      <xsl:value-of select="$epub.cover.image.id"/>
    </xsl:attribute>
    <xsl:attribute name="name">cover</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template name="manifest.cover">
  <!-- Reference to cover html file -->
  <xsl:element namespace="{$opf.namespace}" name="item">
    <xsl:attribute name="id">
      <xsl:value-of select="$epub.cover.filename.id"/>
    </xsl:attribute>
    <xsl:attribute name="href">
      <xsl:value-of select="$epub.cover.filename"/>
    </xsl:attribute>
    <xsl:attribute name="media-type">
      <xsl:value-of select="$epub.xhtml.mediatype"/>
    </xsl:attribute>
  </xsl:element>

  <!-- special item with property="cover-image" -->
  <xsl:element namespace="{$opf.namespace}" name="item">
    <xsl:attribute name="id">
      <xsl:value-of select="$epub.cover.image.id"/>
    </xsl:attribute>
    <xsl:attribute name="properties">cover-image</xsl:attribute>
    <xsl:attribute name="href">img/obalka-bg.svg</xsl:attribute>
    <xsl:attribute name="media-type">image/svg+xml</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template name="spine.cover">
  <!-- generate the spine reference to that cover html file -->
  <xsl:element namespace="http://www.idpf.org/2007/opf" name="itemref">
    <xsl:attribute name="idref">
      <xsl:value-of select="$epub.cover.filename.id"/>
    </xsl:attribute>
    <xsl:attribute name="linear">
    <xsl:choose>
      <xsl:when test="$epub.cover.linear">
        <xsl:text>yes</xsl:text>
      </xsl:when>
      <xsl:otherwise>no</xsl:otherwise>
    </xsl:choose>
    </xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template match="/d:book" mode="package.spine">
  <xsl:element namespace="http://www.idpf.org/2007/opf" name="itemref">
    <xsl:attribute name="idref">
      <xsl:value-of select="concat($epub.package.id.prefix, generate-id(.))"/>
    </xsl:attribute>
  </xsl:element>
  <xsl:element namespace="http://www.idpf.org/2007/opf" name="itemref">
    <xsl:attribute name="idref">swarmwise-chunk-impressum</xsl:attribute>
  </xsl:element>
  <xsl:apply-templates select="*|.//d:refentry" mode="package.spine"/>
  <xsl:element namespace="http://www.idpf.org/2007/opf" name="itemref">
    <xsl:attribute name="idref">swarmwise-chunk-back-cover</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template match="d:epigraph" mode="object.title.markup.textonly">
  <xsl:text>Příhoda</xsl:text>
</xsl:template>

</xsl:stylesheet>
