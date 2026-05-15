<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:sfs="http://schema.slothsoft.net/farah/sitemap" xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:svg="http://www.w3.org/2000/svg" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="/*">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title data-dict="">home/title</title>
				<meta name="viewport" content="width=device-width, initial-scale=1" />
				<meta name="author" content="Daniel Schulz" />
			</head>
			<body>
				<div class="page">
					<header data-dict="">home/header</header>
					<main data-dict="">home/main</main>
					<footer data-dict="">home/footer</footer>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>