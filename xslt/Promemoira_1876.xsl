<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title> 
                <link rel="stylesheet" href="../css/stylesheet_wagner.css"/>
                <script src="../js/edition.js"></script>
            </head>
            <body>
                
               
                <header>
                    <div class="title-box">
                        <h1>Digitale Edition Otto Wagner</h1>
                    </div>
                </header>
                
                <!-- Navigation -->
                <div class="nav-container">
                    <a href="../index.html" class="nav-button">Startseite</a>
                    <a href="%C3%9Cbereinkunft_1873.html" class="nav-button">Übereinkunft 1873</a>
                    <a href="Protokoll_1873.html" class="nav-button">Protokoll 1873</a>
                    <a href="Letzter_Wille_1888.html" class="nav-button">Letzter Wille 1888</a>
                    <a href="Letzter_Wille_1913.html" class="nav-button">Letzter Wille 1913</a>
                    <a href="personen.html" class="nav-button">Personenverzeichnis</a>
                    <a href="organisationen.html" class="nav-button">Organisationsverzeichnis</a>
                    <a href="orte.html" class="nav-button">Ortsverzeichnis</a>
                    <a href="events.html" class="nav-button">Eventverzeichnis</a>
                </div>
                
                <!--Button für den Wechsel zwischen dem Original und der Normalisierten Version. -->
                <div class="toggle-wraper">
                    <button id="toggle-choice">Original ↔ Normalisiert</button>
                    <span id="choice-label">[Original]</span>
                </div>
                              
                <main>
                    <!-- Ansicht vom pdf und dem Text nebeneinander. -->
                    <div id="pdf-panel">
                        <iframe id="pdf-frame" src="../pdf/Promemoria_1876.pdf#page=1"></iframe>
                    </div>
                    
                    <div id="text-panel">
                        <div id="transcription">
                            <xsl:apply-templates select="//tei:text/tei:body"/>
                        </div>
                    </div>
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
    
    <!-- Body: Inhalt direkt ausgeben, Seitenumbrüche als Marker. -->
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- pb als Seitenmarker ausgeben. -->
    <xsl:template match="tei:pb">
        <p class="page-lable">Seite <xsl:value-of select="@n"/></p> 
    </xsl:template>
    
    <!-- pb als Seitenmarker ausgeben innerhlab eines Zitats. -->
    <!-- KI Hilfe für die Lösung dieses Problems. -->
    <xsl:template match="tei:q/tei:pb">
        <span class="page-label-inline"> Seite <xsl:value-of select="@n"/></span>
    </xsl:template>
    
    <!-- Strukturelemente: head, div, p, q-->
    <xsl:template match="tei:head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="class">div
                    <xsl:value-of select="@type"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:q">
        <q><xsl:apply-templates/></q>
    </xsl:template>
    
    <!-- Stempel und Archivnotizen -->
    <xsl:template match="tei:fw[@type='archival']">
        <span class="fw-archival"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:fw[@type='library-stamp']">
        <span class="fw-stamp">[Stempel: <xsl:apply-templates/>]</span>
    </xsl:template>
    
    <!-- Wandelt "personen.xml#pe_x" in "personen.html#pe_x" um. -->
    <!-- KI Hilfe für die Umwandlung von xml zu html.-->
    <xsl:template name="ref-to-html">
        <xsl:param name="ref"/>
        <xsl:param name="fallback-file"/>
        
        <!-- Anker (z.B. "#pe_x") -->
        <xsl:variable name="anchor">
            <xsl:if test="contains($ref, '#')">
                <xsl:value-of select="concat('#', substring-after($ref, '#'))"/>
            </xsl:if>
        </xsl:variable>
        
        <!-- Dateiname vor dem Anker, .xml durch .html ersetzen -->
        <xsl:variable name="filename-xml">
            <xsl:choose>
                <xsl:when test="contains($ref, '#')">
                    <xsl:value-of select="substring-before($ref, '#')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$ref"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="filename-html">
            <xsl:value-of select="concat(substring-before($filename-xml, '.xml'), '.html')"/>
        </xsl:variable>
        <xsl:value-of select="concat($filename-html, $anchor)"/>
    </xsl:template>
    
    <!-- Personen -->
    <xsl:template match="tei:persName">
        <span class="persName">
            <xsl:choose>
                <xsl:when test="@ref != ''">
                    <a class="entity-link" title="Personenregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="@ref"/>
                                <xsl:with-param name="fallback-file">personen.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- Organisationen -->
    <xsl:template match="tei:orgName">
        <span class="orgName">
            <xsl:choose>
                <xsl:when test="@ref != ''">
                    <a class="entity-link" title="Organisationsregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="@ref"/>
                                <xsl:with-param name="fallback-file">organisationen.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- Orte -->
    <xsl:template match="tei:placeName">
        <span class="placeName">
            <xsl:choose>
                <xsl:when test="@ref != ''">
                    <a class="entity-link" title="Ortsregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="@ref"/>
                                <xsl:with-param name="fallback-file">orte.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- Ereignisse/Datum -->
    <xsl:template match="tei:date">
        <span class="date">
            <xsl:choose>
                <xsl:when test="@ref != ''">
                    <a class="entity-link" title="Ereignisregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="@ref"/>
                                <xsl:with-param name="fallback-file">events.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <abbr>
                        <xsl:if test="@when">
                            <xsl:attribute name="title"><xsl:value-of select="@when"/></xsl:attribute>
                        </xsl:if>
                        <xsl:apply-templates/>
                    </abbr>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <!-- Choice: orig/reg und abbr/expan -->
    <xsl:template match="tei:choice">
        <xsl:apply-templates select="tei:orig | tei:abbr"/>
        <xsl:apply-templates select="tei:reg | tei:expan"/>
    </xsl:template>
    
    <xsl:template match="tei:orig">
        <span class="orig-text" title="Originalschreibweise">
            <xsl:apply-templates></xsl:apply-templates></span>
    </xsl:template>
    
    <xsl:template match="tei:reg">
        <span class="reg-text" title="Normalisierte Schreibweise">
            <xsl:apply-templates></xsl:apply-templates></span>
    </xsl:template>
    
    <xsl:template match="tei:abbr">
        <span class="orig-text" title="Abkürzung">
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:expan">
        <span class="reg-text" title="Normalisierte Schreibweise">
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <!--Inline-Elemente: roleName, lb, measure, num, signed  -->
    <xsl:template match="tei:roleName">
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <xsl:choose>
            <xsl:when test="@break='no'"><br/></xsl:when>
            <xsl:otherwise><br/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:measure">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:num">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!--Unterschrift hier in einer anderen Farbe.-->
    <xsl:template match="tei:signed">
        <span class="signed {translate(@rend, ' ', '-')}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
 <!-- Anfürhungszeichen setzen. -->
    <xsl:template match="q">
        <xsl:text>„</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>“</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>