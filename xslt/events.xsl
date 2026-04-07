<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <title>Eventverzeichnis - Otto Wagner Edition</title>
                <link rel="stylesheet" href="../css/stylesheet_wagner_verzeichnisse.css"/>
                
            </head>
            <body>
                <!-- Header-->
                <header class="page-header">
                    <h1>Eventverzeichnis</h1>
                </header>
                
                <!-- Navigation -->
                <nav class="nav-bar">
                    <div class="nav-container">
                        <a href="../index.html" class="nav-button">Startseite</a>
                        <a href="Promemoria_1876.html" class="nav-button">Promemoria 1876</a>
                    </div>
                </nav>
                
                <!-- Inhalt -->
                <main class="events">
                    <ul class="eventverzeichnis">
                        <xsl:apply-templates select="//tei:event">
                            <xsl:sort select="tei:label" data-type="text" order="ascending"/>
                        </xsl:apply-templates>
                    </ul>
                </main>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:event">
        <li>
            <h2>
                <xsl:value-of select="tei:label"/>
            </h2>
            
            <!-- Wikidata-Link -->
            <xsl:if test="tei:idno[@type='wd']">
                <p class="wikidata">
                    <a href="https://www.wikidata.org/wiki/{tei:idno[@type='wd']}" target="_blank">
                        Wikidata-Eintrag
                    </a>
                </p>
            </xsl:if>
            
            <!-- Datum -->
            <xsl:if test="tei:note[@type='date']">
                <p class="event-date">
                    <strong>Datum: </strong>
                    <xsl:value-of select="tei:note[@type='date']"/>
                </p>
            </xsl:if>
            
            <!-- Ort mit Link zum Ortsverzeichnis -->
            <xsl:if test="tei:note[@type='place']">
                <p class="event-place">
                    <strong>Ort: </strong>
                    <xsl:choose>
                        <!-- Wenn ein target existiert, link zum Ortsverzeichnis -->
                        <xsl:when test="tei:note[@type='place']/@target">
                            <a href="{tei:note[@type='place']/@target}">
                                <xsl:value-of select="tei:note[@type='place']"/>
                            </a>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="tei:note[@type='place']"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </p>
            </xsl:if>
            
            <!-- Beschreibung -->
            <xsl:if test="tei:note[@type='desc']">
                <p class="description">                   
                    <xsl:value-of select="tei:note[@type='desc']"/>
                </p>
            </xsl:if>                    
        </li>
    </xsl:template>
    
</xsl:stylesheet>