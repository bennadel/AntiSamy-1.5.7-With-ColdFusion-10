
<!--- Setup our untrusted HTML content. --->
<cfsavecontent variable="unsafeHtml">
	
	<p>
		Check out
		<a href="https://www.bennadel.com" onmousedown="alert( 'XSS!' )">my site</a>.
	</p>

	<marquee loop="-1" width="100%">
		I am very trustable! You can totes trust me!
	</marquee>

	<p>
		<strong>Thanks for stopping by!</strong> <em>You Rock!</em>
		<blink>Woot!</blink>
	</p>

</cfsavecontent>

<!--- ------------------------------------------------------------------------------ --->
<!--- ------------------------------------------------------------------------------ --->

<cfscript>

	// Create our AntiSamy instance.
	// --
	// NOTE: We would probably cache this in the Application scope. Or, more likely,
	// inside a proxy Component that handles all of the intricate interaction details
	// for us so that we don't have know about all the junk below.
	antisamy = application.antisamyJavaLoader.create( "org.owasp.validator.html.AntiSamy" ).init();

	// Create our security policy from the given XML file. This policy determines what
	// tags and attributes will be allowed in the sanitized HTML; and, about how AntiSamy
	// will treat invalid tags that it comes across.
	// --
	// NOTE: We would probably cache this so that we don't have re-read it every time.
	// --
	// Read More: https://www.wavemaker.com/learn/app-development/app-security/xss-antisamy-policy-configuration/
	policy = application.antisamyJavaLoader.switchThreadContextClassLoader(
		getInstance__inProperContext,
		{
			PolicyClass: application.antisamyJavaLoader.create( "org.owasp.validator.html.Policy" ),
			policyFilePath: expandPath( "./demo-policy.xml" )
		}
	);

	// Scan the untrusted HTML. The results will contain both error messages and the
	// sanitized HTML output.
	result = antisamy.scan( javaCast( "string", unsafeHtml ), policy );

	writeOutput( encodeForHtml( result.getCleanHTML() ));
	writeOutput( "<hr />" );
	writeDump( result.getErrorMessages() );

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	/**
	* I am intended to be INVOKED BY THE JAVALOADER. I run the getInstance() method in a
	* context that forces the classes to be loaded from the AntiSamy JavaLoader. This
	* gets around issues in which Java classes try to load dependencies from the wrong
	* Class Loader.
	* 
	* NOTE: While in this method, you cannot access the core ColdFusion classes. As such,
	* this method should do AS LITTLE AS POSSIBLE such that it can return to the normal
	* execution context as fast as possible.
	* 
	* @PolicyClass I am the Policy class provided by AntiSamy.
	* @policyFilePath I am the path to our security policy XML file.
	* @output false
	*/
	public any function getInstance__inProperContext(
		required any PolicyClass,
		required string policyFilePath
		) {

		return( PolicyClass.getInstance( javaCast( "string", policyFilePath ) ) );

	}

</cfscript>
