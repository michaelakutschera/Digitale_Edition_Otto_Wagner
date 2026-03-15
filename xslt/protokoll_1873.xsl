<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Basis-URL für Verweise -->
    <xsl:variable name="base-url">https://michaelakutschera.github.io/dein-repo/</xsl:variable>
    
    <xsl:template match="/">
        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <title>
                    <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                <link rel="stylesheet" href="../css/style.css"/>
            </head>
            
            <body>
                <h1>
                    <xsl:value-of select="//tei:title"/>
                </h1>
                
                <!-- Navigationsleiste zurück zur Startseite -->
                <nav>
                    <a href="../index.html">Zur Startseite</a>
                </nav>
                
                <div class="edition">
                    <div class="facsimile">
                        <h2>Faksimile</h2>
                        <xsl:apply-templates select="//tei:surface"/>
                    </div>
                    
                    <div class="transcription">
                        <h2>Transkription</h2>
                        <xsl:apply-templates select="//tei:body"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Faksimile anzeigen -->
    <xsl:template match="tei:surface">
        <div class="page">
            <p>Seite <xsl:value-of select="@n"/></p>
            
            <!-- PDF als Link öffnen -->
            <a href="{tei:graphic/@url}" target="_blank" class="pdf-link">
                PDF Seite <xsl:value-of select="@n"/> öffnen
            </a>
        </div>
    </xsl:template>
    
    <!-- Body anzeigen -->
    <xsl:template match="tei:body">
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- div anzeigen -->
    <xsl:template match="tei:div">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Absätze anzeigen -->
    <xsl:template match="tei:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Zeilenumbrüche -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template> 
    
    <!-- Seitenumbrüche -->
    <xsl:template match="tei:pb">
        <div class="page-break">
            [Seite <xsl:value-of select="@n"/>]
        </div>
    </xsl:template>
    
    <!-- Datum -->
    <xsl:template match="tei:date">
        <time datetime="{@when}">
            <xsl:apply-templates/>
        </time>
    </xsl:template>
    
    <!-- Sprecher -->
    <xsl:template match="tei:speaker">
        <strong class="speaker">
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <!-- RoleName -->
    <xsl:template match="tei:roleName">
        <span class="role">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Tabellen -->
    <xsl:template match="tei:table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
    
    <xsl:template match="tei:row">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    
    <xsl:template match="tei:cell">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    
    <!-- Measure -->
    <xsl:template match="tei:measure">
        <span class="measure">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- choice/orig/reg oder abbr/expan -->
    <xsl:template match="tei:choice">
        <span class="orig" title="Original: {tei:orig}">
            <xsl:apply-templates select="tei:reg | tei:expan"/>
        </span>
        <span class="note">[Original: <xsl:apply-templates select="tei:orig | tei:abbr"/>]</span>
    </xsl:template>
    
    <!-- Unterschriften -->
    <xsl:template match="tei:signed">
        <p class="signature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- Personen klickbar machen -->
    <xsl:template match="tei:persName">
        <a class="person-link">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <!-- Organisationen klickbar machen -->
    <xsl:template match="tei:orgName">
        <a class="organisation-link">
            <xsl:attribute name="href">
                <xsl:value-of select="@ref"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <!-- Hervorhebungen -->
    <xsl:template match="tei:hi">
        <span class="{@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Stempel/Archivnummern -->
    <xsl:template match="tei:fw">
        <span class="fw {@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Unleserliche Stellen -->
    <xsl:template match="tei:gap">
        <span class="gap" title="unleserlich">[...]</span>
    </xsl:template>
    
    <!-- Supplied -->
    <xsl:template match="tei:supplied">
        <span class="supplied" title="Ergänzt">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Seg -->
    <xsl:template match="tei:seg">
        <span class="seg {@rend}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>