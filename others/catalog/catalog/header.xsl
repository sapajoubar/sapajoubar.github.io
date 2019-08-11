<xsl:stylesheet exclude-result-prefixes="opds" version="1.0" xmlns:opds="http://www.w3.org/2005/Atom"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--
      The purpose of this template is to act as a holder for allowing the user to include custom
      headers on each page of a generaded catalog.   The default template provides an empty header.
      The reason that the header.html is provided via a xsl transform is so that the user has
      access to the runtime parmaters passed in in case any of these are used in the content
      that is to be included.

      If the user replaces this template with their own custom one then they may also need to adjust
      the following files:
          catalog.xsl
          fullentry.xsl
      and change the attributes of the first <iframe> tag to set a size appropriate to hold their
      custom header content.
      -->
  <xsl:output method="html" version="4.01"/>
  <xsl:output doctype-public="-//W3c//DTD html 4.01//EN"/>
  <xsl:output doctype-system="http://www.w3c.org/tr/html4/strict.dtd"/>
  <xsl:output indent="yes"/>
  <xsl:param name="libraryTitle"/>
  <xsl:param name="programName"/>
  <xsl:param name="programVersion"/>
  <xsl:param name="thumbWidth">84</xsl:param>
  <xsl:param name="thumbHeight">125</xsl:param>
  <xsl:param name="generateDownloads">true</xsl:param>
  <xsl:param name="browseByCover">false</xsl:param>
  <xsl:param name="bookCount"/>
  <xsl:param name="i18n.and"/>
  <xsl:param name="i18n.dateGenerated"/>
  <xsl:param name="i18n.backToMain"/>
  <xsl:param name="i18n.summarysection"/>
  <xsl:param name="i18n.downloads"/>
  <xsl:param name="i18n.links"/>
  <xsl:param name="i18n.downloadfile"/>
  <xsl:param name="i18n.downloadsection"/>
  <xsl:param name="i18n.relatedsection"/>
  <xsl:param name="i18n.linksection"/>
  <xsl:param name="intro.goal"/>
  <xsl:param name="intro.wiki.title"/>
  <xsl:param name="intro.wiki.url"/>
  <xsl:param name="intro.team.title"/>
  <xsl:param name="intro.team.list1"/>
  <xsl:param name="intro.team.list2"/>
  <xsl:param name="intro.team.list3"/>
  <xsl:param name="intro.team.list4"/>
  <xsl:param name="intro.thanks.1"/>
  <xsl:param name="intro.thanks.2"/>


  <xsl:template match="/">
    <small>
    </small>
  </xsl:template>

</xsl:stylesheet>