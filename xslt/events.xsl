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
                <title>Eventverzeichnis</title>
                <link rel="stylesheet" href="../css/style.css"/>
            </head>
            
            <body>
                <h1>Eventverzeichnis</h1>
                
                <ul class="Eventverzeichnis">
                    <xsl:apply-templates select="//tei:event">
                        <xsl:sort select="tei:label" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:event">
        <li>
            <span>
                <xsl:value-of select="tei:label"/>
            </span>
            
            <br/>
            
            <!-- Hier verarbeite ich den desc-Inhalt strukturierter -->
            <div class="event-desc">
                <!-- Datum extrahieren -->
                <xsl:if test="tei:desc/tei:date">
                    <span class="event-date">
                        <strong>Datum: </strong>
                        <xsl:value-of select="tei:desc/tei:date"/>
                        <xsl:if test="tei:desc/tei:date/@when">
                            (<xsl:value-of select="tei:desc/tei:date/@when"/>)
                        </xsl:if>
                        <br/>
                    </span>
                </xsl:if>
                
                <!-- Ort extrahieren -->
                <xsl:if test="tei:desc/tei:placeName">
                    <span class="event-place">
                        <strong>Ort: </strong>
                        <xsl:value-of select="tei:desc/tei:placeName"/>
                        <xsl:if test="tei:desc/tei:placeName/@ref">
                            (<xsl:value-of select="tei:desc/tei:placeName/@ref"/>)
                        </xsl:if>
                        <br/>
                    </span>
                </xsl:if>
            </div>
            
            <!-- Wikidata-ID anzeigen, falls vorhanden -->
            <xsl:if test="tei:idno[@type='wd']">
                <div class="wikidata">
                    <strong>Wikidata: </strong>
                    <a href="https://www.wikidata.org/wiki/{tei:idno[@type='wd']}">
                        <xsl:value-of select="tei:idno[@type='wd']"/>
                    </a>
                </div>
            </xsl:if>
        </li>
    </xsl:template>
    
</xsl:stylesheet>