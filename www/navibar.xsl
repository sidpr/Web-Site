<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="udata[@module = 'core'][@method = 'navibar']">
 <div class="navibar">
  <xsl:apply-templates select="items/item" mode="navibar"/>	
 </div>
</xsl:template>

<xsl:template match="item" mode="navibar">
 <a href="{@link}{$lite_q}"><xsl:value-of select="." /></a> &gt;
</xsl:template>

<xsl:template match="item[position() = last()]" mode="navibar">
 <xsl:value-of select="." />
</xsl:template>

<!-- Альтернативные крошки для каталога с непрямыи ссылками -->

<xsl:template match="udata" mode="navi-crumb">
 <div class="navibar">
 <xsl:for-each select="items/item">
 	<xsl:sort select="@id" order="ascending" data-type="number" />
    <xsl:choose>
    	<xsl:when test="position() = last()">
        	 <xsl:choose>
                    <xsl:when test="$pre_lang = '/fr'">
                        <xsl:value-of select="@title_fr"  disable-output-escaping="yes"  />
                    </xsl:when>
                    <xsl:when test="$pre_lang = '/en'">
                        <xsl:value-of select="@title_eng"  disable-output-escaping="yes"  />
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="@title"  disable-output-escaping="yes"  />
                    </xsl:otherwise>
                </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
        	<a href="{concat($pre_lang, '/catalog_search/?c_id=', @id, $lite_a)}">
            <!--<xsl:value-of select="@title" disable-output-escaping="yes"/>-->
                <xsl:choose>
                    <xsl:when test="$pre_lang = '/fr'">
                        <xsl:value-of select="@title_fr"  disable-output-escaping="yes"  />
                    </xsl:when>
                    <xsl:when test="$pre_lang = '/en'">
                        <xsl:value-of select="@title_eng"  disable-output-escaping="yes"  />
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="@title"  disable-output-escaping="yes"  />
                    </xsl:otherwise>
                </xsl:choose>
            </a> &gt;
        </xsl:otherwise>
     </xsl:choose>
 </xsl:for-each>
 </div>
</xsl:template>

<!-- / Альтернативные крошки для каталога с непрямыи ссылками -->
</xsl:stylesheet>