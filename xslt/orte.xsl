<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="de">
            <head>
            <meta charset="UTF-8"/>
            <title>Ortsverzeichnis</title>
            <link rel="stylesheet" href="stylesheet_wagner_verzeichnisse.css"/>
            </head>
            <body>
                <header>
                <h1>Ortsverzeichnis</h1>
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
                        <a href="personen.html" class="nav-button">Personenverzeichnis</a>
                        <a href="organisationen.html" class="nav-button">Organisationsverzeichnis</a>
                        <a href="events.html" class="nav-button">Eventverzeichnis</a>
                    </div>
                </nav>
                
                <ul class="Ortsverzeichnis">
                    <xsl:apply-templates select="//tei:place">
                        <xsl:sort select="tei:placeName" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="tei:place">
        <li>
            <h2>
                <xsl:value-of select="tei:placeName"/>
            </h2>
            
            <!-- Historisch, wenn vorhanden.  -->
            <xsl:if test="tei:placeName[@type='historic']">
                <p class="historic-name">
                    <strong>Historische Brücke:</strong> 
                    <xsl:value-of select="tei:placeName[@type='historic']"/>
                </p>
            </xsl:if>
            
        <!--Check ob die idno vorhanden ist und wenn ja Link anzeigen zum Wikidataeintrag.-->
        <xsl:if test="tei:idno[@type='wd']">
            <p class="wikidata">
                <a href="https://www.wikidata.org/wiki/{tei:idno[@type='wd']}">Wikidata</a>
            </p>
        </xsl:if>
            
        <!-- Koordinaten (Geo).-->   
            <xsl:if test="tei:note[@type='location']/tei:geo">
                <p class="koordinaten">
                    Koordinaten: <xsl:value-of select="tei:note[@type='location']/tei:geo"/>
                </p>
            </xsl:if>
            
        <!--Beschreibung/Note (type vorhanden).-->
            <xsl:if test="tei:note[@type='desc']">
                <p class="beschreibung">                   
                    <xsl:value-of select="tei:note[@type='desc']"/>
                </p>
            </xsl:if>
        </li>
    </xsl:template>
</xsl:stylesheet>