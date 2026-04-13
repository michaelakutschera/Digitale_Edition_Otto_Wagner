Digitale Edition Otto Wagner

Diese Edition verfolgt das Ziel, drei unterschiedliche Dokumententypen in Bezug auf Otto Wagners Karriere und Leben digital zugänglich zu machen. 
Die Edition erlaubt das Umschalten zwischen dem originalen und dem normalisierten Text. Layoutmerkmale wie Unterstreichungen werden in der TEI ausgezeichnet, aber nicht im HTML-Text dargestellt, da sie im parallelen PDF-Faksimile sichtbar sind.

Otto Wagners Testamente (1888/1913): 

• Welche biografischen, familiären oder beruflichen Entwicklungen spiegeln sich in den Änderungen wider?

• Welche Personen werden genannt und welche verschwinden?

• Gibt es strukturelle oder sprachliche Modernisierungen?

Quelle: Wienbibliothek
1.	Mein letzter Wille 1888: https://www.digital.wienbibliothek.at/wbrobv/content/titleinfo/2040067

2.	Mein letzter Wille 1913: https://www.digital.wienbibliothek.at/wbrobv/content/titleinfo/2040074

Otto Wagners berufliche Situation von 1873 bis 1876:

• Welche beruflichen Erfolge, Projekte und Positionen lassen sich aus Protokoll, Übereinkunft und Promemoria rekonstruieren?

• Welche seiner geplanten oder realisierten Bauwerke existieren heute noch?

• Welche Projekte wurden nicht umgesetzt und warum?

Quellen: Wienbibliothek

1.	Übereinkunft 1873: https://www.digital.wienbibliothek.at/wbrobv/content/titleinfo/2040039

2.	Protokoll 1873: https://www.digital.wienbibliothek.at/wbrobv/content/titleinfo/2040046

3.	Promemoria 1876: https://www.digital.wienbibliothek.at/wbrobv/content/titleinfo/2040092

Datenmodell: 
• Verwendet werden teiHeader mit einer fileDesc, publicationStmt, sourceDesc. Außerdem die Zuordnung der pdf-Seiten zu einer spezifischen xml:id mit dem Tag facsimile. 

• div zur Gliederung der Dokumente mit verschiedenen types.

• pb für die Seitenumbrüche

• fw zur Markierung von Archivstempeln und Signaturen. 

• choice, orig, reg, abbr und expan zur Darstellung der damaligen und heutigen Schreibweise und den Wechsel zwischen den beiden auf der Webseite.

• signed zur Markierung der Unterschriften in allen Dokumenten. 

Für die Dateien personen.xml, orte.xml, organisationen.xml und events.xml werden folgende Regeln genutzt:

Personen: pe_Nachname: pe_wagner, pe_rainer, pe_foerster etc.
pe_AnfangsbuchsabenVorname_Nachname: pe_sus_wagner, pe_eme_wagner etc.

Orte: pl_Stadt: pl_wien, pl_berlin, pl_baden
pl_Akronym: pl_hk (Erzherzogliche Hofkanzlei), pl_pe (Palais Epstein)

Organisationen:
org_Akronym: org_bab (Bauakademie Berlin)

Events: ev_Akronym_Jahr: ev_wa_1873 (Weltausstellung 1873)

Es erfolgte außerdem eine Verlinkung, wenn vorhanden, von Personen, Orten, Organisationen etc. zu Wikidata.
