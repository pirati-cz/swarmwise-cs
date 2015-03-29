<?xml version='1.0'?>
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	version="1.0">
<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/epub3/docbook.xsl"/>
<xsl:include href="xhtml-common.xsl"/>

<xsl:template name="book.titlepage.separator">
</xsl:template>

<xsl:template name="user.manifest.items">
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

<xsl:template name="manifest.fonts">
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-cardo-bold</xsl:attribute>
    <xsl:attribute name="href">fonts/Cardo-Bold.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-cardo-italic</xsl:attribute>
    <xsl:attribute name="href">fonts/Cardo-Italic.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-cardo</xsl:attribute>
    <xsl:attribute name="href">fonts/Cardo-Regular.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-libsans-bold</xsl:attribute>
    <xsl:attribute name="href">fonts/LiberationSans-Bold.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-libsans</xsl:attribute>
    <xsl:attribute name="href">fonts/LiberationSans-Regular.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-ubuntu-italic</xsl:attribute>
    <xsl:attribute name="href">fonts/Ubuntu-RI.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-font-ubuntu</xsl:attribute>
    <xsl:attribute name="href">fonts/Ubuntu-R.ttf</xsl:attribute>
    <xsl:attribute name="media-type">application/x-font-ttf</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-licence-copying</xsl:attribute>
    <xsl:attribute name="href">fonts/COPYING.txt</xsl:attribute>
    <xsl:attribute name="media-type">text/plain</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-licence-ofl</xsl:attribute>
    <xsl:attribute name="href">fonts/OFL.txt</xsl:attribute>
    <xsl:attribute name="media-type">text/plain</xsl:attribute>
  </xsl:element>
  <xsl:element name="item" namespace="{$opf.namespace}">
    <xsl:attribute name="id">swarmwise-licence-ufl</xsl:attribute>
    <xsl:attribute name="href">fonts/UFL.txt</xsl:attribute>
    <xsl:attribute name="media-type">text/plain</xsl:attribute>
  </xsl:element>
</xsl:template>

<xsl:template match="d:index|d:colophon" mode="ncx">
</xsl:template>

</xsl:stylesheet>
