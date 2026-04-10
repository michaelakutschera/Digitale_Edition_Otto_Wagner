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
                
                <header>
                    <div class="title-box">
                        <h1>Digitale Edition Otto Wagner</h1> 
                    </div>         
                </header>
                
                <!-- Navigation -->
                <nav class="nav-bar">
                    <div class="nav-container">
                        <a href="../index.html" class="nav-button">Startseite </a>
                        <a href="%C3%9Cbereinkunft_1873.html" class="nav-button">Übereinkunft 1873</a>
                        <a href="Protokoll_1873.html" class="nav-button">Protokoll 1873</a>
                        <a href="Promemoria_1876.html" class="nav-button">Promemoria 1876</a> 
                        <a href="Letzter_Wille_1888.html" class="nav-button">Letzter Wille 1888</a>
                        <a href="Letzter_Wille_1913.html" class="nav-button">Lezter Wille 1913</a>
                        <a href="personen.html" class="nav-button">Personenverzeichnis</a>
                        <a href="organisationen.html" class="nav-button">Organisationsverzeichnis</a>
                        <a href="orte.html" class="nav-button">Ortsverzeichnis</a>
                    </div>
                </nav>
                
                <!-- Inhalt -->
                <main class="events">
                    <!-- Überschrift direkt ausgeben -->
                    <h2><xsl:value-of select="//tei:head"/></h2>
                    
                    <ul class="eventverzeichnis">
                        <xsl:apply-templates select="//tei:event">
                            <xsl:sort select="tei:label" data-type="text" order="ascending"/>
                        </xsl:apply-templates>
                    </ul>
                    
                </main>
                    <!-- Footer -->
                    <footer class="site-footer">
                        <div class="footer-content">
                            <div class="footer-section">
                                <h3>Projekt:</h3>
                                <p>Digitale Edition Otto Wagner<br/>
                                    136060-1 UE Digitale Edition<br/>
                                    Wintersemester 2025/26<br/>
                                    Universtiät Wien</p>
                            </div>
                            <div class="footer-section"> 
                                <h3>Betreuung und Kontakt:</h3>
                                <p>Erstellt von: Michaela Kutschera BA<br/>
                                    E-Mail: <a href="a11831654@unet.univie.ac.at">a11831654@unet.univie.ac.at</a><br/>
                                    © 2026</p>
                            </div>
                            <div class="footer-section">
                                <h3>Quellen:</h3>
                                <p>Transkription basierend auf den Originaldokumenten<br/>
                                    aus der Wienbibliothek im Rathaus.<br/>
                                </p>
                            </div>
                        </div>
                    </footer>            
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:event">
        <li>
            <h3>
                <xsl:value-of select="tei:label"/>
            </h3>
            
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
                        <!-- KI Hilfe mit dem richtigen Verweisen -->
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