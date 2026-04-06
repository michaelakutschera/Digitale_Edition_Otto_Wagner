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
            <!-- Hauptname: der erste name (meist historic) -->
            <h2>
                <xsl:value-of select="tei:name[1]"/>
            </h2>
            
            <!-- Zusätzlicher historischer Hinweis, falls es einen zweiten historic Namen gibt -->
            <xsl:if test="tei:name[2] and tei:name[1] != tei:name[2]">
                <p class="historic-name">
                    <strong>Auch bekannt als: </strong> 
                    <xsl:value-of select="tei:name[2]"/>
                </p>
            </xsl:if>
            
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
            
            <!-- Alle Notes anzeigen -->
            <xsl:for-each select="tei:note">
                <p class="note">
                    <xsl:value-of select="."/>
                </p>
            </xsl:for-each>
            
        </li>
    </xsl:template>
    
</xsl:stylesheet>