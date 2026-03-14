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
                <title>
                    <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                <!-- href: CSS umbennen; nicht für alle Seiten dasselbe CSS -->
                <link rel="stylesheet" href="../css/style.css"/>
            </head>
            
            <body>
                <h1>
                    <xsl:value-of select="//tei:title"/>
                </h1>
                
                <div class="edition">
                <div class="facsimile">
                    <h2>Faksimilie</h2>
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
    
    <!--Faksimile anzeigen. Weiß nicht ganz wofür? Wie wird das pdf dann angezeigt?-->
    <xsl:template match="tei:surface">
        <div class="page">
            <p>Seite <xsl:value-of select="@n"/></p>
            
            <iframe>
                <xsl:attribute name="src">
                    <xsl:value-of select="tei:graphic/@url"/>
                </xsl:attribute>
            </iframe>
        </div>
    </xsl:template>
    
    <!-- Body anzeigen. -->
    <xsl:template match="tei:body">
        <div class="text">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- div anzeigen. -->
    <xsl:template match="tei:div">
        <div>
            <xsl:attribute name="class">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- Absätze anzeigen. -->
    <xsl:template match="tei:p">
        <p>
            <!--Sorgt dafür, dass verschachtelte Elemente weiter verarbeitet werden. -->
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!--Zeilenumbrüche anzeigen.-->
        <xsl:template match="tei:lb">
            <br/>
        </xsl:template> 
    
    <!-- Seitenumbrüche anzeigen.Bin mir nicht sicher ob ich das brauche.... -->
    <xsl:template match="tei:pb">
        <div class="pagebreaker">
            Seite <xsl:value-of select="@n"/>
        </div>
    </xsl:template>
    
    <!-- Datum anzeigen. -->
    <xsl:template match="tei:date">
        <time>
            <xsl:attribute name="datetime">
                <xsl:value-of select="@when"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </time>
    </xsl:template>
    
    <!-- Sprecher anzeigen. --> 
    <xsl:template match="tei:speaker">
        <strong class="speaker">
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    
    <!-- RoleName anzeigen. -->
    <xsl:template match="tei:roleName">
        <span class="role">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Tabellen anzeigen lassen. -->
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
    
    <!-- Mesaure anzeigen. -->
    <xsl:template match="tei:measure">
        <span class="measure">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- choice/org/reg oder abbr/expan anzeigen lassen, Mit xsl:apply-templates sind dann beide Varianten möglich -->
    <xsl:template match="tei:choice">
        <span class="orig">
            <xsl:apply-templates select="tei:orig"/>
        </span>
        <span class="reg">
            <xsl:apply-templates select="tei:reg"/>
        </span>
        <span class="abbr">
            <xsl:apply-templates select="tei:abbr"/>
        </span>
        <span class="expan">
            <xsl:apply-templates select="tei:expan"/>
        </span>
        </xsl:template>
    
    
    <!-- Unterschriften anzeigen. -->
    <xsl:template match="tei:signed">
        <p class="signature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!--Personen klickbar machen.-->
    <xsl:template match="tei:persName">
        <span class="person">
        <xsl:attribute name="data-ref">
            <xsl:value-of select="substring-after(@ref, '#')"/>
        </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Organisationen klickbar machen.-->
    <xsl:template match="tei:orgName">
        <span class="organisation">
            <xsl:attribute name="data-ref">
                <xsl:value-of select="substring-after(@ref, '#')"/>
                <xsl:apply-templates/>
            </xsl:attribute>
        </span>
    </xsl:template>
    
    <!-- Hervorhebungen anzeigen.-->
    <xsl:template match="tei:hi">
        <span>
            <xsl:attribute name="class">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--Stempel oder Archivnummern anzeigen.-->
    <xsl:template match="tei:fw">
        <span class="fw">
           <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <!-- Unleserliche Stellen. -->
    <xsl:template match="tei:gap">
        <span class="gap">[...]</span>
    </xsl:template>
    
    <!-- Supplied, wenn Baron nicht ausgeschrieben ist. -->
    <xsl:template match="tei:supplied">
        <span class="supplied">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- Seg anzeigen. -->
    <xsl:template match="tei:seg">
        <span class="seg">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>