<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        
        <html lang="de">
            
            <head>
                <meta charset="UTF-8"/>
                <title>Personenverzeichnis</title>
                <link rel="stylesheet" href="../css/style.css"/>
            </head>
            
            <body>
                
                <h1>Personenverzeichnis</h1>
                
                <ul class="personenverzeichnis">
                    
                    <xsl:apply-templates select="//tei:person">
                        <xsl:sort select="tei:persName[1]/tei:surname" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
        
        
    </xsl:template>
        
    <xsl:template match="tei:person">
        <li>
            <xsl:if test="tei:person">
                <xsl:attribute name="id">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
            </xsl:if>
            
            <h2>
                <xsl:apply-templates select="tei:persName[1]"/>
            </h2>
            
            <xsl:if test="tei:idno[@type='wd']">
                <p>
                    <a href="https://www.wikidata.org/wiki/{tei:idno[@type='wd']}">
                        Wikidata
                    </a>
                </p>
            </xsl:if>
            
            <xsl:if test="tei:persName[@type='variant']">
                <p>Namensvarianten:</p>
                <ul>
                    <xsl:for-each select="tei:persName[@type='variant']">
                        <li>
                            <xsl:value-of select="."/>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
            
            <xsl:if test="tei:note">
                
                <xsl:for-each select="tei:note">
                    <p class="note">
                        <xsl:value-of select="."/>
                    </p>
                </xsl:for-each> 
            </xsl:if>
                  </li>
    </xsl:template>
    
    <xsl:template match="tei:persName">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:forename | tei:surname | tei:roleName | tei:nameLink | tei:addName">
        <xsl:value-of select="."/>
        <xsl:text></xsl:text>
    </xsl:template>
    
</xsl:stylesheet>

        
    
