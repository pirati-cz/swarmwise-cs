<xsl:stylesheet exclude-result-prefixes="d"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	version="1.0">
<xsl:param name="local.l10n.xml" select="document('l10n-data.xml')"/>
<xsl:param name="html.stylesheet">swarmwise.css</xsl:param>
<xsl:param name="make.clean.html" select="1"/>
<xsl:param name="chunk.section.depth">0</xsl:param>
<xsl:param name="chunk.tocs.and.lots" select="1"/>
<xsl:param name="formal.title.placement">
figure after
example before
equation before
table before
procedure before
task before
</xsl:param>
<xsl:param name="generate.toc">
book      title
</xsl:param>
<xsl:param name="process.empty.source.toc" select="1"/>
<xsl:param name="process.source.toc" select="1"/>
<xsl:param name="toc.list.type">div</xsl:param>
<xsl:param name="appendix.autolabel" select="0"/>
<xsl:param name="formal.object.break.after" select="0"/>
<xsl:param name="xref.with.number.and.title" select="0"/>
<xsl:param name="generate.index" select="0"/>

<xsl:template match="d:abstract">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:important">
  <table>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <tr>
      <td class="picture"><img src="img/thoughtmark.png" alt=""/></td>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<xsl:template match="d:attribution">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:text>&#x2014; </xsl:text>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:attribution/d:literallayout">
  <span class="literal">
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="d:blockquote">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <img src="img/quotemarks.png" alt="" class="float"/>
    <xsl:apply-templates select="*[local-name(.) != 'title' and local-name(.) != 'attribution']"/>
    <xsl:apply-templates select="d:attribution"/>
  </div>
</xsl:template>

<xsl:template match="d:literallayout">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:literal">
  <span>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="d:formalpara">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:formalpara/d:title|d:formalpara/d:info/d:title">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:formalpara/d:para">
  <p>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </p>
</xsl:template>

<xsl:template match="d:example/d:title|d:informalexample/d:title">
  <h6>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </h6>
</xsl:template>

<xsl:template match="d:varlistentry//d:para">
  <xsl:param name="extracontent" select="''"/>

  <p>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:copy-of select="$extracontent"/>
    <xsl:apply-templates/>
  </p>
</xsl:template>

<xsl:template match="d:varlistentry">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:choose>
      <xsl:when test="local-name(d:listitem/*[1]) = 'para'">
        <xsl:variable name="termcontent">
          <span class="term">
            <xsl:apply-templates select="d:term"/>
  	</span>
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
        <xsl:apply-templates select="d:term"/>
        <xsl:apply-templates select="d:listitem"/>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>

<xsl:template match="d:variablelist">
  <div>
    <xsl:call-template name="common.html.attributes"/>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- Keep <imagedata> to <img> conversion simple -->
<xsl:template name="process.image">
  <xsl:element name="img" namespace="http://www.w3.org/1999/xhtml">
    <xsl:attribute name="src">
      <xsl:apply-templates select="@fileref"/>
    </xsl:attribute>
    <xsl:attribute name="alt"/>
  </xsl:element>
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

<xsl:template match="d:toc" mode="title.markup">
  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'tableofcontents'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="*" mode="toc.markup">
  <xsl:apply-templates select="." mode="label.markup"/>
</xsl:template>

<xsl:template match="d:part" mode="toc.markup">
  <xsl:call-template name="gentext">
    <xsl:with-param name="key" select="'part'"/>
  </xsl:call-template>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="." mode="label.markup"/>
</xsl:template>

<xsl:template match="d:preface" mode="toc">
</xsl:template>

<xsl:template match="d:part" mode="toc">
  <div>
    <xsl:attribute name="class">
      <xsl:value-of select="local-name(.)"/>
    </xsl:attribute>
    <div class="title">
      <xsl:apply-templates select="." mode="object.title.markup"/>
    </div>
    <div class="subtoc">
      <xsl:apply-templates select="d:chapter" mode="toc"/>
    </div>
  </div>
</xsl:template>

<xsl:template match="d:chapter" mode="toc">
  <div>
    <xsl:attribute name="class">
      <xsl:value-of select="local-name(.)"/>
    </xsl:attribute>
    <xsl:call-template name="toc.line"/>
    <div class="subtoc">
      <xsl:apply-templates select="d:section" mode="toc"/>
    </div>
  </div>
</xsl:template>

<xsl:template match="d:appendix" mode="toc">
  <div>
    <xsl:attribute name="class">
      <xsl:value-of select="local-name(.)"/>
    </xsl:attribute>
    <div class="title">
      <xsl:text>Ostatní</xsl:text>
    </div>
    <div class="subtoc">
      <xsl:apply-templates select="d:section" mode="toc"/>
    </div>
  </div>
</xsl:template>

<xsl:variable name="toc.listitem.type">
  <xsl:choose>
    <xsl:when test="$toc.list.type = 'dl'">dt</xsl:when>
    <xsl:when test="$toc.list.type = 'div'">div</xsl:when>
    <xsl:otherwise>li</xsl:otherwise>
  </xsl:choose>
</xsl:variable>

<xsl:template name="toc.line">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="depth" select="1"/>
  <xsl:param name="depth.from.context" select="8"/>

  <xsl:variable name="label">
    <xsl:apply-templates select="." mode="toc.markup"/>
  </xsl:variable>

  <xsl:variable name="line-label">
    <xsl:copy-of select="$label"/>
    <xsl:if test="$label != ''">
      <xsl:value-of select="$autotoc.label.separator"/>
    </xsl:if>
  </xsl:variable>
  
 <div class="title">
  <!-- * if $autotoc.label.in.hyperlink is zero, then output the label -->
  <!-- * before the hyperlinked title (as the DSSSL stylesheet does) -->
  <xsl:if test="$autotoc.label.in.hyperlink = 0">
    <xsl:copy-of select="$line-label"/>
  </xsl:if>

  <a>
    <xsl:attribute name="href">
      <xsl:call-template name="href.target">
        <xsl:with-param name="context" select="$toc-context"/>
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:attribute>
    
  <!-- * if $autotoc.label.in.hyperlink is non-zero, then output the label -->
  <!-- * as part of the hyperlinked title -->
  <xsl:if test="not($autotoc.label.in.hyperlink = 0)">
    <xsl:copy-of select="$line-label"/>
  </xsl:if>

    <xsl:apply-templates select="." mode="titleabbrev.markup"/>
  </a>
 </div>
</xsl:template>

<xsl:template name="part.titlepage.recto">
  <xsl:choose>
    <xsl:when test="d:partinfo/d:title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="d:partinfo/d:title"/>
    </xsl:when>
    <xsl:when test="d:docinfo/d:title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="d:docinfo/d:title"/>
    </xsl:when>
    <xsl:when test="d:info/d:title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="d:info/d:title"/>
    </xsl:when>
    <xsl:when test="d:title">
      <xsl:apply-templates mode="part.titlepage.recto.auto.mode" select="d:title"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="d:title" mode="part.titlepage.recto.auto.mode">
  <xsl:variable name="id">
    <xsl:choose>
      <!-- if title is in an *info wrapper, get the grandparent -->
      <xsl:when test="contains(local-name(..), 'info')">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="../.."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div class="title-prefix">
    <xsl:choose>
      <xsl:when test="$generate.id.attributes = 0">
        <a id="{$id}"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'part'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="ancestor::d:part[1]" mode="label.markup"/>
  </div>
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:choose>
      <xsl:when test="$show.revisionflag != 0 and @revisionflag">
	<span class="{@revisionflag}">
	  <xsl:apply-templates mode="titlepage.mode"/>
	</span>
      </xsl:when>
      <xsl:otherwise>
	<xsl:apply-templates mode="titlepage.mode"/>
      </xsl:otherwise>
    </xsl:choose>
  </div>
</xsl:template>

<xsl:template match="d:title" mode="chapter.titlepage.recto.auto.mode">
  <xsl:variable name="id">
    <xsl:choose>
      <!-- if title is in an *info wrapper, get the grandparent -->
      <xsl:when test="contains(local-name(..), 'info')">
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select="../.."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="object.id">
          <xsl:with-param name="object" select=".."/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div class="title-prefix">
    <xsl:choose>
      <xsl:when test="$generate.id.attributes = 0">
        <a id="{$id}"/>
      </xsl:when>
      <xsl:otherwise>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'chapter'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="ancestor::d:chapter[1]" mode="label.markup"/>
  </div>
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template name="book.titlepage.recto">
  <div class="titlepage-recto">
    <xsl:choose>
      <xsl:when test="d:bookinfo/d:title">
        <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:title"/>
      </xsl:when>
      <xsl:when test="d:info/d:title">
        <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:title"/>
      </xsl:when>
      <xsl:when test="d:title">
        <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:title"/>
      </xsl:when>
    </xsl:choose>
  
    <xsl:choose>
      <xsl:when test="d:bookinfo/d:subtitle">
        <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:subtitle"/>
      </xsl:when>
      <xsl:when test="d:info/d:subtitle">
        <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:subtitle"/>
      </xsl:when>
      <xsl:when test="d:subtitle">
        <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:subtitle"/>
      </xsl:when>
    </xsl:choose>
  
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:corpauthor"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:corpauthor"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:authorgroup"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:authorgroup"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:bookinfo/d:author"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="d:info/d:author"/>
  </div>
</xsl:template>

<xsl:template match="d:legalnotice" mode="book.titlepage.verso.auto.mode">
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode"/>
  </div>
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

  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
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
  </div>
</xsl:template>

<xsl:template match="d:isbn" mode="book.titlepage.verso.auto.mode">
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'ISBN'"/>
    </xsl:call-template>
    <xsl:call-template name="gentext.space"/>
    <xsl:apply-templates mode="titlepage.mode"/>
  </div>
</xsl:template>

<xsl:template match="d:para" mode="book.titlepage.verso.auto.mode">
  <p>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:apply-templates mode="book.titlepage.verso.auto.mode"/>
  </p>
</xsl:template>

<xsl:template name="book.titlepage.verso">
  <xsl:call-template name="swarmwise.impressum"/>
</xsl:template>

<xsl:template name="swarmwise.impressum">
  <div class="impressum">
    <xsl:apply-templates select="d:bookinfo/d:legalnotice" mode="book.titlepage.verso.auto.mode"/>
    <xsl:apply-templates select="d:info/d:legalnotice" mode="book.titlepage.verso.auto.mode"/>
    <xsl:apply-templates select="d:bookinfo/d:copyright" mode="book.titlepage.verso.auto.mode"/>
    <xsl:apply-templates select="d:bookinfo/d:isbn" mode="book.titlepage.verso.auto.mode"/>
  </div>
</xsl:template>

<xsl:template match="d:abstract" mode="cover">
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:authorblurb" mode="cover">
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:apply-templates select="/d:book/d:bookinfo/d:author" mode="cover"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="d:author" mode="cover">
  <span>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:apply-templates select="d:honorific"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="d:firstname"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="d:othername"/>
    <xsl:text> </xsl:text>
    <span style="font-weight: bold;">
      <xsl:apply-templates select="d:surname"/>
    </span>
  </span>
</xsl:template>

<xsl:template name="front.cover">
  <div class="front-cover">
    <img src="img/obalka-bg.svg" alt=""/>
  </div>
</xsl:template>

<xsl:template name="back.cover">
  <div class="back-cover">
    <img src="img/rick.png" alt=""/>
    <xsl:apply-templates select="/d:book/d:bookinfo/d:abstract" mode="cover"/>
    <xsl:apply-templates select="/d:book/d:bookinfo/d:authorblurb" mode="cover"/>
  </div>
</xsl:template>

<xsl:template match="d:book">
  <xsl:call-template name="id.warning"/>

  <xsl:call-template name="front.cover"/>
  <div>
    <xsl:apply-templates select="." mode="common.html.attributes"/>
    <xsl:call-template name="id.attribute">
      <xsl:with-param name="conditional" select="0"/>
    </xsl:call-template>

    <xsl:call-template name="book.titlepage"/>

    <xsl:apply-templates select="d:dedication" mode="dedication"/>
    <xsl:apply-templates select="d:acknowledgements" mode="acknowledgements"/>

    <xsl:variable name="toc.params">
      <xsl:call-template name="find.path.params">
        <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:call-template name="make.lots">
      <xsl:with-param name="toc.params" select="$toc.params"/>
      <xsl:with-param name="toc">
        <xsl:call-template name="division.toc">
          <xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')"/>
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:apply-templates/>
  </div>
  <xsl:call-template name="back.cover"/>
</xsl:template>

</xsl:stylesheet>
