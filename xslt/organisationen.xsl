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
                <link rel="stylesheet" href="stylesheet_wagner_verzeichnisse.css"/>
            </head>
            <body>
                <header>
                <h1>Organisationsverzeichnis</h1>
                </header>
                
                <!-- Navigation -->
                <nav class="nav-bar">
                    <div class="nav-container">
                        <a href="../index.html" class="nav-button">Startseite</a>
                        <a href="%C3%9Cbereinkunft_1873.html" class="nav-button">Übereinkunft 1873</a>
                        <a href="Protokoll_1873.html" class="nav-button">Protokoll 1873</a>
                        <a href="Promemoria_1876.html" class="nav-button">Promemoria 1876</a> 
                        <a href="Letzter_Wille_1888.html" class="nav-button">Letzter Wille 1888</a>
                        <a href="Letzter_Wille_1913.html" class="nav-button">Lezter Wille 1913</a>                 
                    </div>
                </nav>
                
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
            
            <!-- Alle anderen Notes (ohne type='place') -->
            <xsl:for-each select="tei:note[not(@type='place')]">
                <p class="note">
                    <xsl:value-of select="."/>
                </p>
            </xsl:for-each>
            
        </li>
    </xsl:template>
    
</xsl:stylesheet>