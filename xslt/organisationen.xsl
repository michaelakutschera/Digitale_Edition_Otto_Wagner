<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <title>Organisationsverzeichnis</title>
                <link rel="stylesheet" href="stylesheet_wagner.css"/>
            </head>
            <body>
                <h1>Organisationsverzeichnis</h1>
                <ul class="Organisationsverzeichnis">
                    <xsl:apply-templates select="//tei:org">
                        <xsl:sort select="tei:name[1]" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:org">
        <li>
            <!-- Hauptname (der erste name) -->
            <h2>
                <xsl:value-of select="tei:name[1]"/>
            </h2>
            
            <!-- Wikidata-Link -->
            <xsl:if test="tei:idno[@type='wd']">
                <p class="wikidata">
                    <a href="https://www.wikidata.org/wiki/{tei:idno[@type='wd']}">Wikidata</a>
                </p>
            </xsl:if>
            
            <!-- Namensvarianten (type='variant') -->
            <xsl:if test="tei:name[@type='variant']">
                <p class="varianten-label">Namensvarianten:</p>
                <ul class="varianten">
                    <xsl:for-each select="tei:name[@type='variant']">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
            
            <!-- Ort aus note type="place" mit target (einheitlich wie bei Events) -->
            <xsl:if test="tei:note[@type='place']">
                <p class="org-place">
                    <strong>Ort: </strong>
                    <a href="{tei:note[@type='place']/@target}">
                        <xsl:value-of select="tei:note[@type='place']"/>
                    </a>
                </p>
            </xsl:if>
            
            <!-- Alle anderen Notes (ohne type='place') -->
            <xsl:for-each select="tei:note[not(@type='place')]">
                <p class="note">
                    <xsl:value-of select="."/>
                </p>
            </xsl:for-each>
            
        </li>
    </xsl:template>
    
</xsl:stylesheet>