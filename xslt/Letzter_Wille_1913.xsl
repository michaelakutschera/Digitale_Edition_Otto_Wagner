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
                <link rel="stylesheet" href="stylesheet_wagner.css"/>
                <script src="edition.js"></script>
            </head>
            <body>
                <header>
                    <h1><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                    <!--Button für den Wechsel zwischen dem Original und der Normalisierten Version. -->
                    
                    <button id="toggle-choice">Original ↔ Normalisiert</button>
                    <span id="choice-label">[Original]</span>
                </header>
                
                <main>
                    <!-- Ansicht vom pdf und dem Text nebeneinander. -->
                    <div id="pdf-panel">
                        <iframe id="pdf-frame" src="Letzter_Wille_1913.pdf#page=1"></iframe>
                    </div>
                    
                    <div id="text-panel">
                        <div id="transcription">
                            <xsl:apply-templates select="//tei:text/tei:body"/>
                        </div>
                    </div>
                </main>
                
                <script src="edition.js"></script>
            </body>
        </html>
        
    </xsl:template>
    <!-- Body: Inhalt direkt ausgeben, Seitenumbrüche als Marker -->
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- pb als Seitenmarker ausgeben -->
    <xsl:template match="tei:pb">
        <p class="page-label">Seite <xsl:value-of select="@n"/></p>
    </xsl:template>
    <xsl:template match="tei:note"/>
    
    <!-- Strukturelemente: head, div, p -->
    <xsl:template match="tei:head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="class">div-<xsl:value-of select="@type"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <!-- Stempel und Archivnotizen-->
    <xsl:template match="tei:fw[@type='archival']">
        <span class="fw-archival"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:fw[@type='library-stamp']">
        <span class="fw-stamp">[Stempel: <xsl:apply-templates/>]</span>
    </xsl:template>
    <!-- Wandelt "personen.xml#pe_x" in "personen.html#pe_x" um -->
    <xsl:template name="ref-to-html">
        <xsl:param name="ref"/>
        <xsl:param name="fallback-file"/>
        <xsl:variable name="anchor">
            <xsl:if test="contains($ref, '#')">
                <xsl:value-of select="concat('#', substring-after($ref, '#'))"/>
            </xsl:if>
        </xsl:variable>
        
        
        <!-- Dateiname aus ref extrahieren und .xml durch .html ersetzen -->
        <xsl:variable name="filename-xml">
            <xsl:choose>
                <xsl:when test="contains($ref, '#')">
                    <xsl:value-of select="substring-before($ref, '#')"/>
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="$ref"/></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
    </xsl:template>
    
    <!-- Entitäten: Link zu den Personen, Orten, Organisationen und Datum. 
    Umwandlung: xml-Ref zu einer html-ref-->
    <xsl:template match="tei:persName">
        <span class="persName">
            <xsl:variable name="ref" select="@ref"/>
            <xsl:choose>
                <xsl:when test="$ref != ''">
                    <a class="entity-link" title="Personenregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="$ref"/>
                                <xsl:with-param name="fallback-file">personen.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:orgName">
        <span class="orgName">
            <xsl:variable name="ref" select="@ref"/>
            <xsl:choose>
                <xsl:when test="$ref != ''">
                    <a class="entity-link" title="Organisationsregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="$ref"/>
                                <xsl:with-param name="fallback-file">organisationen.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:placeName">
        <span class="placeName">
            <xsl:variable name="ref" select="@ref"/>
            <xsl:choose>
                <xsl:when test="$ref != ''">
                    <a class="entity-link" title="Ortsregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="$ref"/>
                                <xsl:with-param name="fallback-file">orte.html</xsl:with-param>
                            </xsl:call-template>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </a>
                </xsl:when>
                <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:date">
        <span class="date">
            <xsl:variable name="ref" select="@ref"/>
            <xsl:choose>
                <xsl:when test="$ref != ''">
                    <a class="entity-link" title="Ereignisregister">
                        <xsl:attribute name="href">
                            <xsl:call-template name="ref-to-html">
                                <xsl:with-param name="ref" select="$ref"/>
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
    
    <!-- Chocie: orig/reg und abbr/expan -->
    <xsl:template match="tei:choice">
        <xsl:apply-templates select="tei:orig | tei:abbr"/>
        <xsl:apply-templates select="tei:reg | tei:expan"/>
    </xsl:template>
    
    <xsl:template match="tei:orig">
        <span class="orig-text" title="Originalschreibweise">
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:reg">
        <span class="reg-text" title="Normalisierte Schreibweise">
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:abbr">
        <span class="orig-text" title="Abkürzung">
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:expan">
        <span class="reg-text" title="Aufgelöst">
            <xsl:apply-templates/></span>
    </xsl:template>
    
    <!-- Inline-Elemente: roleName, lb, gap, supplied, hi, measure, signed -->
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
    
    <xsl:template match="tei:gap">
        <span class="gap" title="unleserlich"></span>
    </xsl:template>
    
    <xsl:template match="tei:supplied">
        <span class="supplied" title="Editorische Ergänzung">[<xsl:apply-templates/>]</span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend='underline-black']">
        <span class="underline"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tei:measure">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:signed">
        <span class="signed"><xsl:apply-templates/></span>
    </xsl:template>
    
</xsl:stylesheet>