<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:key name="persons" match="tei:person" use="@xml:id"/>
    
    <!-- HILFSTEMPLATES-->
    <!-- KI Hilfe für die Formatierung des Datums. -->
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:choose>
            <xsl:when test="string-length($date) = 4 and $date = number($date)">
                <xsl:value-of select="$date"/>
            </xsl:when>
            <xsl:when test="string-length($date) >= 10">
                <xsl:variable name="year" select="substring($date, 1, 4)"/>
                <xsl:variable name="month" select="substring($date, 6, 2)"/>
                <xsl:variable name="day" select="substring($date, 9, 2)"/>
                <xsl:value-of select="concat($day, '.', $month, '.', $year)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$date"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Template für den Hauptnamen (mit nameLink). -->
    <xsl:template match="tei:persName[not(@type)]">
        <xsl:for-each select="tei:roleName | tei:forename | tei:nameLink | tei:surname | tei:addName">
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Template für jede einzelne Person in der Liste. -->
    <xsl:template match="tei:person">
        <li>
            <h2>
                <xsl:apply-templates select="tei:persName[not(@type)]"/>
            </h2>
            
            <!--Check ob die idno vorhanden ist und wenn ja Link anzeigen zum Wikidataeintrag.-->
            <xsl:if test="tei:idno[@type='wd']">
                <p class="wikidata">
                    <a href="https://www.wikidata.org/wiki/{tei:idno[@type='wd']}">Wikidata</a>
                </p>
            </xsl:if>
            
            <!--KI HIlfe für die richtige Anordnung von birth/death und dem neu sortierten Datum. -->
            <p class="lebensdaten">
                <xsl:choose>
                    <xsl:when test="tei:birth and tei:death">
                        <xsl:text>* </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="tei:birth/@when"/>
                        </xsl:call-template>
                        <xsl:text>  † </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="tei:death/@when"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="tei:birth and not(tei:death)">
                        <xsl:text>* </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="tei:birth/@when"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="not(tei:birth) and tei:death">
                        <xsl:text>† </xsl:text>
                        <xsl:call-template name="formatDate">
                            <xsl:with-param name="date" select="tei:death/@when"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </p>
            
            <xsl:if test="tei:occupation or tei:note">
                <p class="beschreibung">
                    <xsl:if test="tei:occupation">
                        <xsl:value-of select="tei:occupation"/>
                    </xsl:if>
                    <xsl:if test="tei:occupation and tei:note and not(contains(tei:note, 'Nicht in den Testamenten'))">
                        <xsl:text> – </xsl:text>
                    </xsl:if>
                    <xsl:if test="tei:note and not(contains(tei:note, 'Nicht in den Testamenten'))">
                        <xsl:value-of select="tei:note"/>
                    </xsl:if>
                </p>
            </xsl:if>
            
            <!-- Alle Namensvarianten der Person auflisten. -->
            <xsl:if test="tei:persName[@type='variant']">
                <p class="varianten-label">Namensvarianten:</p>
                <ul class="varianten">
                    <xsl:for-each select="tei:persName[@type='variant']">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
            
            <xsl:if test="tei:note[contains(., 'Nicht in den Testamenten')]">
                <p class="genealogie">
                    <xsl:value-of select="tei:note[contains(., 'Nicht in den Testamenten')]"/>
                </p>
            </xsl:if>
        </li>
    </xsl:template>
    
    <!-- HAUPTTEMPLATES -->  
    <xsl:template match="/">
        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <title>Personenverzeichnis</title>
                <link rel="stylesheet" href="stylesheet_wagner_verzeichnisse.css"/>
            </head>
            <body>
                <!-- 1. Personenverzeichnis -->
                <header>
                    <h1>Personenverzeichnis</h1>
                </header>
                
                <!-- Navigation -->
                <nav class="nav-bar">
                    <div class="nav-container">
                        <a href="../index.html" class="nav-button">Startseite</a>
                        <a href="%C3%9Cbereinkunft_1873.xsl" class="nav-button">Übereinkunft 1873</a>
                        <a href="Protokoll_1873.xsl" class="nav-button">Protokoll 1873</a>
                        <a href="Promemoria_1876.html" class="nav-button">Promemoria 1876</a> 
                        <a href="Letzter_Wille_1888.xsl" class="nav-button">Letzter Wille 1888</a>
                        <a href="Letzter_Wille_1913.xsl" class="nav-button">Lezter Wille 1913</a>                 
                    </div>
                </nav>
                
                <ul class="personenverzeichnis">
                    <xsl:apply-templates select="//tei:person">
                        <xsl:sort select="tei:persName[not(@type)]/tei:surname" data-type="text" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
                
                <!-- 2. Beziehungen -->
                <h2>Beziehungen</h2>
                
                <!--KI Hilfe für die korrekte Vebrindung und Darstellung der familiären Beziehung der Familie Wagner.-->
                 <!-- Generation 1: Eltern -->
                <h3>Generation 1 – Eltern von Otto Wagner</h3>
                <ul class="beziehungen gen1">
                    <xsl:for-each select="//tei:relation[@name='parentOf' and @passive='#pe_wagner']">
                        <xsl:variable name="parent" select="key('persons', substring-after(@active, '#'))"/>
                        <li><xsl:value-of select="$parent/tei:persName[not(@type)]"/></li>
                    </xsl:for-each>
                </ul>
                
                <!-- Generation 2: Otto Wagner & Geschwister -->
                <h3>Generation 2 – Otto Wagner &amp; Geschwister</h3>
                <ul class="beziehungen gen2">
                    <li><strong>Otto Wagner</strong></li>
                    <xsl:for-each select="//tei:relation[@name='siblingOf']">
                        <xsl:variable name="siblingId">
                            <xsl:choose>
                                <xsl:when test="@active='#pe_wagner'"><xsl:value-of select="substring-after(@passive, '#')"/></xsl:when>
                                <xsl:when test="@passive='#pe_wagner'"><xsl:value-of select="substring-after(@active, '#')"/></xsl:when>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:if test="$siblingId != ''">
                            <xsl:variable name="sibling" select="key('persons', $siblingId)"/>
                            <li>Bruder: <xsl:value-of select="$sibling/tei:persName[not(@type)]"/></li>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:for-each select="//tei:relation[@name='spouseOf' and contains(@mutual, 'pe_wagner')]">
                        <xsl:variable name="spouseId">
                            <xsl:variable name="first" select="substring-before(@mutual, ' ')"/>
                            <xsl:variable name="second" select="substring-after(@mutual, ' ')"/>
                            <xsl:choose>
                                <xsl:when test="contains($first, 'wagner')"><xsl:value-of select="substring-after($second, '#')"/></xsl:when>
                                <xsl:otherwise><xsl:value-of select="substring-after($first, '#')"/></xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="spouse" select="key('persons', $spouseId)"/>
                        <li>⚭ <xsl:value-of select="$spouse/tei:persName[not(@type)]"/></li>
                    </xsl:for-each>
                </ul>
                
                <!-- Generation 3: Kinder von Otto Wagner -->
                <h3>Generation 3 – Kinder von Otto Wagner</h3>
                <ul class="beziehungen gen3">
                    <li><strong>Kinder mit Sophia Paupie:</strong>
                        <ul>
                            <xsl:for-each select="//tei:relation[@name='parentOf' and @active='#pe_paupie']">
                                <xsl:variable name="child" select="key('persons', substring-after(@passive, '#'))"/>
                                <li><xsl:value-of select="$child/tei:persName[not(@type)]"/></li>
                            </xsl:for-each>
                        </ul>
                    </li>
                    <li><strong>Kinder mit Josefine Domhart:</strong>
                        <ul>
                            <xsl:for-each select="//tei:relation[@name='parentOf' and @active='#pe_domhart']">
                                <xsl:variable name="child" select="key('persons', substring-after(@passive, '#'))"/>
                                <li><xsl:value-of select="$child/tei:persName[not(@type)]"/></li>
                            </xsl:for-each>
                        </ul>
                    </li>
                    <li><strong>Kinder mit Louise Wagner:</strong>
                        <ul>
                            <xsl:for-each select="//tei:relation[@name='parentOf' and @active='#pe_lou_wagner']">
                                <xsl:variable name="child" select="key('persons', substring-after(@passive, '#'))"/>
                                <li><xsl:value-of select="$child/tei:persName[not(@type)]"/></li>
                            </xsl:for-each>
                        </ul>
                    </li>
                </ul>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>