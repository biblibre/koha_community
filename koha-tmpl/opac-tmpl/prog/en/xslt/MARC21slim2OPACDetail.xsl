<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: MARC21slim2DC.xsl,v 1.1 2003/01/06 08:20:27 adam Exp $ -->
<xsl:stylesheet version="1.0"
  xmlns:marc="http://www.loc.gov/MARC21/slim"
  xmlns:items="http://www.koha.org/items"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="marc items">
    <xsl:import href="MARC21slimUtils.xsl"/>
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
            <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="marc:record">
        <xsl:variable name="leader" select="marc:leader"/>
        <xsl:variable name="leader6" select="substring($leader,7,1)"/>
        <xsl:variable name="leader7" select="substring($leader,8,1)"/>
        <xsl:variable name="controlField008" select="marc:controlfield[@tag=008]"/>
        <xsl:variable name="materialTypeCode">
            <xsl:choose>
                <xsl:when test="$leader6='a'">
                    <xsl:choose>
                        <xsl:when test="$leader7='a' or $leader7='c' or $leader7='d' or $leader7='m'">BK</xsl:when>
                        <xsl:when test="$leader7='b' or $leader7='i' or $leader7='s'">SE</xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$leader6='t'">BK</xsl:when>
                <xsl:when test="$leader6='p'">MM</xsl:when>
                <xsl:when test="$leader6='m'">CF</xsl:when>
                <xsl:when test="$leader6='e' or $leader6='f'">MP</xsl:when>
                <xsl:when test="$leader6='g' or $leader6='k' or $leader6='o' or $leader6='r'">VM</xsl:when>
                <xsl:when test="$leader6='c' or $leader6='d' or $leader6='i' or $leader6='j'">MU</xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="materialTypeLabel">
            <xsl:choose>
                <xsl:when test="$leader6='a'">
                    <xsl:choose>
                        <xsl:when test="$leader7='a' or $leader7='c' or $leader7='d' or $leader7='m'">Book</xsl:when>
                        <xsl:when test="$leader7='b' or $leader7='i' or $leader7='s'">Serial</xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$leader6='t'">Book</xsl:when>
                <xsl:when test="$leader6='p'">Mixed Materials</xsl:when>
                <xsl:when test="$leader6='m'">Computer File</xsl:when>
                <xsl:when test="$leader6='e' or $leader6='f'">Map</xsl:when>
                <xsl:when test="$leader6='g' or $leader6='k' or $leader6='o' or $leader6='r'">Visual Material</xsl:when>
                <xsl:when test="$leader6='c' or $leader6='d' or $leader6='i' or $leader6='j'">Music</xsl:when>
            </xsl:choose>
        </xsl:variable>

        <!-- Title Statement -->
<style type="text/css">
    .label {
        font-size: 80%;
        color: grey;
    }
</style>
        <div id="views">
        <xsl:if test="marc:datafield[@tag=245]">
        <h1>
            <xsl:for-each select="marc:datafield[@tag=245]">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abfghk</xsl:with-param>
                    </xsl:call-template>
            </xsl:for-each>
        </h1>
        </xsl:if>

        <span class="views"><span id="Normalview">Normal View</span> <a id="MARCview" href="/cgi-bin/koha/opac-MARCdetail.pl?biblionumber={marc:datafield[@tag=999]/marc:subfield[@code='c']}">MARC View</a> <a id="ISBDview" href="/cgi-bin/koha/opac-ISBDdetail.pl?biblionumber={marc:datafield[@tag=999]/marc:subfield[@code='c']}">Card View (ISBD)</a></span>
        </div> 

        <xsl:choose>
        <xsl:when test="marc:datafield[@tag=100] or marc:datafield[@tag=110] or marc:datafield[@tag=111] or marc:datafield[@tag=700] or marc:datafield[@tag=710] or marc:datafield[@tag=711]">

        <h5 class="author">by
        <xsl:for-each select="marc:datafield[@tag=100 or @tag=700]">
        <a>
        <xsl:choose>
            <xsl:when test="marc:subfield[@code=9]">
                <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
            <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="nameABCDQ"/></a>
        <xsl:choose>
        <xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="marc:datafield[@tag=110 or @tag=710]">
        <a>
        <xsl:choose>
            <xsl:when test="marc:subfield[@code=9]">
                <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
            <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>      
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="nameABCDN"/></a>
        <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="marc:datafield[@tag=111 or @tag=711]">
        <a>
        <xsl:choose>
            <xsl:when test="marc:subfield[@code=9]">
                <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
            <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=au:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="nameACDEQ"/></a>
        <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>

        </xsl:for-each>
        </h5>
        </xsl:when>
        </xsl:choose>

        <div class="summary">

        <xsl:if test="$materialTypeCode">
        <p><span class="label">Type: </span>
        <img src="/opac-tmpl/prog/famfamfam/{$materialTypeCode}.png"/><xsl:value-of select="$materialTypeLabel"/>
        </p>
        </xsl:if>
        <xsl:if test="marc:datafield[@tag=440 or @tag=490]">
        <p><span class="label">Series: </span>
        <xsl:for-each select="marc:datafield[@tag=440]">
            <xsl:call-template name="chopPunctuation">
                            <xsl:with-param name="chopString">
                                <xsl:call-template name="subfieldSelect">
                                    <xsl:with-param name="codes">av</xsl:with-param>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
                    <xsl:call-template name="part"/>
            <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="marc:datafield[@tag=490][@ind1=0]">
             <a href="/cgi-bin/koha/opac-search.pl?se:{marc:subfield[@code='a']}">
                        <xsl:call-template name="chopPunctuation">
                            <xsl:with-param name="chopString">
                                <xsl:call-template name="subfieldSelect">
                                    <xsl:with-param name="codes">av</xsl:with-param>
                                </xsl:call-template>
                            </xsl:with-param>
                        </xsl:call-template>
            </a>
                    <xsl:call-template name="part"/>
        <xsl:choose><xsl:when test="position()=last()"><xsl:text>.</xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose>
        </xsl:for-each>
        </p>
        </xsl:if>
        <xsl:if test="marc:datafield[@tag=260]">
        <p><span class="label">Publisher: </span>
            <xsl:for-each select="marc:datafield[@tag=260]">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">bcg</xsl:with-param>
                    </xsl:call-template>
            </xsl:for-each>
        </p> 
        </xsl:if>
        <xsl:if test="marc:datafield[@tag=020]">
        <p><span class="label">ISBN: </span>
        <xsl:for-each select="marc:datafield[@tag=020]">
                <xsl:value-of select="marc:subfield[@code='a']"/>
        </xsl:for-each>
        </p>
        </xsl:if>

        <xsl:if test="marc:datafield[@tag=022]">
        <p><span class="label">ISSN: </span>
        <xsl:for-each select="marc:datafield[@tag=022]">
                <xsl:value-of select="marc:subfield[@code='a']"/>
        </xsl:for-each>
        </p>
        </xsl:if>

        <xsl:if test="marc:datafield[@tag=130]|marc:datafield[@tag=240]|marc:datafield[@tag=730][@ind2!=2]">
        <p><span class="label">Uniform titles: </span>
        <xsl:for-each select="marc:datafield[@tag=130]|marc:datafield[@tag=240]|marc:datafield[@tag=730][@ind2!=2]">
            <xsl:variable name="str">
                <xsl:for-each select="marc:subfield">
                    <xsl:if test="(contains('adfklmor',@code) and (not(../marc:subfield[@code='n' or @code='p']) or (following-sibling::marc:subfield[@code='n' or @code='p'])))">
                        <xsl:value-of select="text()"/>
                        <xsl:text> </xsl:text>
                     </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            <xsl:call-template name="chopPunctuation">
                <xsl:with-param name="chopString">
                    <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
                        
                </xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        </p>
        </xsl:if>

        <xsl:if test="marc:datafield[@tag=650]">
            <p><span class="label">Related Subjects: </span>
            <xsl:for-each select="marc:datafield[@tag=650]">
            <a>
            <xsl:choose>
            <xsl:when test="marc:subfield[@code=9]">
                <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?authid=<xsl:value-of select="marc:subfield[@code=9]"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=su:<xsl:value-of select="marc:subfield[@code='a']"/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
            <xsl:call-template name="chopPunctuation">
                <xsl:with-param name="chopString">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">abcdvxyz</xsl:with-param>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
            </a>
            <xsl:choose>
            <xsl:when test="position()=last()"></xsl:when>
            <xsl:otherwise> | </xsl:otherwise>
            </xsl:choose>

            </xsl:for-each>
            </p>
        </xsl:if>

        <xsl:if test="marc:datafield[@tag=856]">
        <p><span class="label">Online Resources: </span>
        <xsl:for-each select="marc:datafield[@tag=856]">
            <a><xsl:attribute name="href"> <xsl:value-of select="marc:subfield[@code='u']"/></xsl:attribute>
            <xsl:if test="marc:subfield[@code='y' or @code='3' or @code='z']">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">y3z</xsl:with-param>
                    </xsl:call-template>
            </xsl:if></a>
            <xsl:choose>
            <xsl:when test="position()=last()"></xsl:when>
            <xsl:otherwise> | </xsl:otherwise>
            </xsl:choose>
            
        </xsl:for-each>
        </p>
        </xsl:if>

        <!-- 780 -->
        <xsl:if test="marc:datafield[@tag=780]/marc:subfield[@code='a']">
        <xsl:for-each select="marc:datafield[@tag=780]">
        <p><span class="label">
        <xsl:choose>
        <xsl:when test="@ind2=0">
            Continues:
        </xsl:when>
        <xsl:when test="@ind2=1">
            Continues in part:
        </xsl:when>
        <xsl:when test="@ind2=2">
            Supersedes:
        </xsl:when>
        <xsl:when test="@ind2=3">
            Supersedes in part:
        </xsl:when>
        <xsl:when test="@ind2=4">
            Formed by the union: ... and: ...
        </xsl:when>
        <xsl:when test="@ind2=5">
            Absorbed:
        </xsl:when>
        <xsl:when test="@ind2=6">
            Absorbed in part:
        </xsl:when>
        <xsl:when test="@ind2=7">
            Separated from:
        </xsl:when>
        </xsl:choose>
        </span>
            <a><xsl:attribute name="href">/cgi-bin/koha/opac-search.pl?q=<xsl:value-of select="marc:subfield[@code='t']"/></xsl:attribute>
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">atxwg</xsl:with-param>
                    </xsl:call-template>
            </a>
        </p>
        <xsl:choose>
        <xsl:when test="@ind1=0">
            <p><xsl:value-of select="marc:subfield[@code='n']"/></p>
        </xsl:when>
        </xsl:choose>

        </xsl:for-each>
        </xsl:if>

        </div>

    </xsl:template>

    <xsl:template name="nameABCDQ">
            <xsl:call-template name="chopPunctuation">
                <xsl:with-param name="chopString">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">aq</xsl:with-param>
                    </xsl:call-template>
                </xsl:with-param>
                <xsl:with-param name="punctuation">
                    <xsl:text>:,;/ </xsl:text>
                </xsl:with-param>
            </xsl:call-template>
        <xsl:call-template name="termsOfAddress"/>
    </xsl:template>

    <xsl:template name="nameABCDN">
        <xsl:for-each select="marc:subfield[@code='a']">
                <xsl:call-template name="chopPunctuation">
                    <xsl:with-param name="chopString" select="."/>
                </xsl:call-template>
        </xsl:for-each>
        <xsl:for-each select="marc:subfield[@code='b']">
                <xsl:value-of select="."/>
        </xsl:for-each>
        <xsl:if test="marc:subfield[@code='c'] or marc:subfield[@code='d'] or marc:subfield[@code='n']">
                <xsl:call-template name="subfieldSelect">
                    <xsl:with-param name="codes">cdn</xsl:with-param>
                </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="nameACDEQ">
            <xsl:call-template name="subfieldSelect">
                <xsl:with-param name="codes">acdeq</xsl:with-param>
            </xsl:call-template>
    </xsl:template>
    <xsl:template name="termsOfAddress">
        <xsl:if test="marc:subfield[@code='b' or @code='c']">
            <xsl:call-template name="chopPunctuation">
                <xsl:with-param name="chopString">
                    <xsl:call-template name="subfieldSelect">
                        <xsl:with-param name="codes">bc</xsl:with-param>
                    </xsl:call-template>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="part">
        <xsl:variable name="partNumber">
            <xsl:call-template name="specialSubfieldSelect">
                <xsl:with-param name="axis">n</xsl:with-param>
                <xsl:with-param name="anyCodes">n</xsl:with-param>
                <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="partName">
            <xsl:call-template name="specialSubfieldSelect">
                <xsl:with-param name="axis">p</xsl:with-param>
                <xsl:with-param name="anyCodes">p</xsl:with-param>
                <xsl:with-param name="afterCodes">fghkdlmor</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="string-length(normalize-space($partNumber))">
                <xsl:call-template name="chopPunctuation">
                    <xsl:with-param name="chopString" select="$partNumber"/>
                </xsl:call-template>
        </xsl:if>
        <xsl:if test="string-length(normalize-space($partName))">
                <xsl:call-template name="chopPunctuation">
                    <xsl:with-param name="chopString" select="$partName"/>
                </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="specialSubfieldSelect">
        <xsl:param name="anyCodes"/>
        <xsl:param name="axis"/>
        <xsl:param name="beforeCodes"/>
        <xsl:param name="afterCodes"/>
        <xsl:variable name="str">
            <xsl:for-each select="marc:subfield">
                <xsl:if test="contains($anyCodes, @code)      or (contains($beforeCodes,@code) and following-sibling::marc:subfield[@code=$axis])      or (contains($afterCodes,@code) and preceding-sibling::marc:subfield[@code=$axis])">
                    <xsl:value-of select="text()"/>
                    <xsl:text> </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="substring($str,1,string-length($str)-1)"/>
    </xsl:template>
</xsl:stylesheet>