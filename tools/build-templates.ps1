# Genera las plantillas DOCX de plugins/cv/assets/templates/.
# Uso (PowerShell 5.1 o pwsh):  ./tools/build-templates.ps1
#
# Las plantillas no llevan contenido: solo definen estilos, viñetas y pagina.
# El skill `tune` agrega parrafos usando los estilos CV* (ver
# plugins/cv/reference/template-styles.md). Ambas variantes comparten los mismos
# IDs de estilo, asi que el skill no necesita saber cual plantilla se eligio.
#
# Nota: el script es ASCII a proposito (PS 5.1 lee .ps1 sin BOM como ANSI).

Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$outDir = Join-Path $root 'plugins/cv/assets/templates'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$NS = 'xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"'
$bullet = [string][char]0x2022

# --- Definicion de variantes -------------------------------------------------
# Colores en hex sin '#'. Tamanos en half-points (20 = 10 pt).
$variants = @{
  'ats-clean' = @{
    nameSize = 40; nameColor = '000000'; titleSize = 24; titleColor = '333333'
    contactSize = 20; sectionSize = 22; sectionColor = '000000'; ruleColor = '808080'
    ruleSize = 6; metaColor = '444444'
  }
  'visual' = @{
    nameSize = 52; nameColor = '1F4E79'; titleSize = 26; titleColor = '2E75B6'
    contactSize = 20; sectionSize = 24; sectionColor = '1F4E79'; ruleColor = '2E75B6'
    ruleSize = 12; metaColor = '2E75B6'
  }
}

function Style($id, $ppr, $rpr, $extra = '') {
  # ID y nombre iguales: python-docx busca estilos por nombre.
  "<w:style w:type=`"paragraph`" w:customStyle=`"1`" w:styleId=`"$id`"><w:name w:val=`"$id`"/><w:basedOn w:val=`"Normal`"/><w:qFormat/>$extra<w:pPr>$ppr</w:pPr><w:rPr>$rpr</w:rPr></w:style>"
}

function Build-Styles($v) {
  $s = @()
  # w:lang queda en es-ES como default de la plantilla (idioma base del plugin).
  # tune lo corrige siempre al generar, para que coincida con el idioma real del
  # CV (ver reference/template-styles.md, paso "Idioma del documento", y
  # reference/locales.md) -- si no, Word subraya como error todo el texto.
  $s += '<w:docDefaults><w:rPrDefault><w:rPr><w:rFonts w:ascii="Arial" w:hAnsi="Arial" w:eastAsia="Arial" w:cs="Arial"/><w:sz w:val="20"/><w:szCs w:val="20"/><w:lang w:val="es-ES" w:eastAsia="es-ES" w:bidi="ar-SA"/></w:rPr></w:rPrDefault><w:pPrDefault><w:pPr><w:spacing w:after="0" w:line="259" w:lineRule="auto"/></w:pPr></w:pPrDefault></w:docDefaults>'
  $s += '<w:style w:type="paragraph" w:default="1" w:styleId="Normal"><w:name w:val="Normal"/><w:qFormat/></w:style>'
  $s += Style 'CVNombre' '<w:keepNext/><w:spacing w:after="40"/>' ("<w:b/><w:color w:val=`"$($v.nameColor)`"/><w:sz w:val=`"$($v.nameSize)`"/><w:szCs w:val=`"$($v.nameSize)`"/>")
  $s += Style 'CVTitular' '<w:keepNext/><w:spacing w:after="60"/>' ("<w:color w:val=`"$($v.titleColor)`"/><w:sz w:val=`"$($v.titleSize)`"/><w:szCs w:val=`"$($v.titleSize)`"/>")
  $s += Style 'CVContacto' '<w:spacing w:after="120"/>' ("<w:sz w:val=`"$($v.contactSize)`"/><w:szCs w:val=`"$($v.contactSize)`"/>")
  $s += Style 'CVSeccion' ("<w:keepNext/><w:pBdr><w:bottom w:val=`"single`" w:sz=`"$($v.ruleSize)`" w:space=`"1`" w:color=`"$($v.ruleColor)`"/></w:pBdr><w:spacing w:before=`"220`" w:after=`"100`"/>") ("<w:b/><w:caps/><w:color w:val=`"$($v.sectionColor)`"/><w:sz w:val=`"$($v.sectionSize)`"/><w:szCs w:val=`"$($v.sectionSize)`"/>")
  $s += Style 'CVPuesto' '<w:keepNext/><w:spacing w:before="120" w:after="0"/>' '<w:b/><w:sz w:val="21"/><w:szCs w:val="21"/>'
  $s += Style 'CVMeta' '<w:keepNext/><w:spacing w:after="40"/>' ("<w:i/><w:color w:val=`"$($v.metaColor)`"/><w:sz w:val=`"19`"/><w:szCs w:val=`"19`"/>")
  $s += Style 'CVTexto' '<w:spacing w:after="60"/>' ''
  $s += Style 'CVVineta' '<w:numPr><w:ilvl w:val="0"/><w:numId w:val="1"/></w:numPr><w:spacing w:after="30"/><w:ind w:left="360" w:hanging="240"/>' ''
  "<?xml version=`"1.0`" encoding=`"UTF-8`" standalone=`"yes`"?><w:styles $NS>" + ($s -join '') + '</w:styles>'
}

$numbering = "<?xml version=`"1.0`" encoding=`"UTF-8`" standalone=`"yes`"?><w:numbering $NS><w:abstractNum w:abstractNumId=`"0`"><w:multiLevelType w:val=`"hybridMultilevel`"/><w:lvl w:ilvl=`"0`"><w:start w:val=`"1`"/><w:numFmt w:val=`"bullet`"/><w:lvlText w:val=`"$bullet`"/><w:lvlJc w:val=`"left`"/><w:pPr><w:ind w:left=`"360`" w:hanging=`"240`"/></w:pPr><w:rPr><w:rFonts w:ascii=`"Arial`" w:hAnsi=`"Arial`" w:cs=`"Arial`" w:hint=`"default`"/></w:rPr></w:lvl></w:abstractNum><w:num w:numId=`"1`"><w:abstractNumId w:val=`"0`"/></w:num></w:numbering>"

# Cuerpo vacio; margenes de ~2 cm; A4 (para Letter: w=12240 h=15840).
$document = "<?xml version=`"1.0`" encoding=`"UTF-8`" standalone=`"yes`"?><w:document $NS><w:body><w:sectPr><w:pgSz w:w=`"11906`" w:h=`"16838`"/><w:pgMar w:top=`"1134`" w:right=`"1134`" w:bottom=`"1134`" w:left=`"1134`" w:header=`"708`" w:footer=`"708`" w:gutter=`"0`"/></w:sectPr></w:body></w:document>"

$contentTypes = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/><Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/><Override PartName="/word/numbering.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.numbering+xml"/></Types>'
$rels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/></Relationships>'
$docRels = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/numbering" Target="numbering.xml"/></Relationships>'

foreach ($name in $variants.Keys) {
  $out = Join-Path $outDir "$name.docx"
  $parts = [ordered]@{
    '[Content_Types].xml'          = $contentTypes
    '_rels/.rels'                  = $rels
    'word/document.xml'            = $document
    'word/_rels/document.xml.rels' = $docRels
    'word/styles.xml'              = (Build-Styles $variants[$name])
    'word/numbering.xml'           = $numbering
  }
  foreach ($k in $parts.Keys) { [xml]$null = $parts[$k] }   # falla si algun XML esta mal formado

  # Entradas con '/' explicitas (Compress-Archive en PS 5.1 usa '\', que rompe el formato).
  $fs = [System.IO.File]::Open($out, 'Create')
  $zip = New-Object System.IO.Compression.ZipArchive($fs, 'Create')
  foreach ($k in $parts.Keys) {
    $e = $zip.CreateEntry($k)
    $sw = New-Object System.IO.StreamWriter($e.Open(), (New-Object System.Text.UTF8Encoding($false)))
    $sw.Write($parts[$k]); $sw.Dispose()
  }
  $zip.Dispose(); $fs.Dispose()
  Write-Host "OK  $name.docx"
}
