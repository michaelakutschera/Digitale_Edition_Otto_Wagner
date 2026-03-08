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
                <title>Ortesverzeichnis</title>
                <link rel="stylesheet" href="../css/style.css"/>
            </head>
            
            <body>
                
                <h1>Ortsverzeichnis</h1>
                
                <ul class="Ortsverzeichnis">
                    
                    <xsl:apply-templates select="//tei:place">
                        <xsl:sort select="tei:placeName" order="ascending"/>
                    </xsl:apply-templates>
                </ul>
            </body>
        </html>
        </xsl:template>
    
    <xsl:template match="tei:place">
        <li>
            <span>
                <xsl:value-of select="tei:placeName"/>
            </span>
            
            <br/>
            
            <xsl:value-of select="tei:note[@type='desc']"/>
        </li>
        
    </xsl:template>
    
</xsl:stylesheet>