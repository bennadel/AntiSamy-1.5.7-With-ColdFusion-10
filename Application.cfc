component
	output = false
	hint = "I provide the application settings and event handlers."
	{

	// Define the application.
	this.name = hash( getCurrentTemplatePath() );
	this.applicationTimeout = createTimeSpan( 0, 0, 10, 0 );
	this.sessionManagement = false;

	// Setup the mappings
	this.directory = getDirectoryFromPath( getCurrentTemplatePath() );
	this.mappings[ "/" ] = this.directory;
	this.mappings[ "/antisamy" ] = ( this.directory & "vendor/antisamy-1.5.7/" );
	this.mappings[ "/javaloader" ] = ( this.directory & "vendor/javaloader-1.2/javaloader/" );
	this.mappings[ "/javaloaderfactory" ] = ( this.directory & "vendor/javaloaderfactory/" );

	// ---
	// PUBLIC METHODS.
	// ---

	/**
	* I initialize the application.
	* 
	* @output false
	*/
	public boolean function onApplicationStart() {

		// In order to prevent memory leaks, we're going to use the JavaLoaderFactory to
		// instantiate our JavaLoader. This will keep the instance cached in the Server
		// scope so that it doesn't have to continually re-create it as we test our
		// application configuration.
		application.javaLoaderFactory = new javaloaderfactory.JavaLoaderFactory();

		// Create a JavaLoader that can access the AntiSamy 1.5.7 JAR files.
		// --
		// CAUTION: The directory has MORE JAR FILES than are actually necessary to run
		// the demo. However, I just downloaded all the non-optional dependencies
		// according to the MAVEN resource pages. I don't actually know enough about Java
		// to know which libraries I can and cannot exclude from the JavaLoader. I have
		// commented-out the ones that were not supplied by the "JAR Download" website.
		application.antisamyJavaLoader = application.javaLoaderFactory.getJavaLoader([
			expandPath( "/antisamy/antisamy-1.5.7.jar" ),
			// expandPath( "/antisamy/avalon-framework-4.1.3.jar" ),
			// expandPath( "/antisamy/avalon-framework-4.1.5.jar" ),
			expandPath( "/antisamy/batik-constants-1.9.1.jar" ),
			expandPath( "/antisamy/batik-css-1.9.1.jar" ),
			expandPath( "/antisamy/batik-i18n-1.9.1.jar" ),
			expandPath( "/antisamy/batik-util-1.9.1.jar" ),
			expandPath( "/antisamy/commons-codec-1.6.jar" ),
			expandPath( "/antisamy/commons-io-1.3.1.jar" ),
			// expandPath( "/antisamy/commons-logging-1.0.4.jar" ),
			expandPath( "/antisamy/commons-logging-1.1.3.jar" ),
			expandPath( "/antisamy/httpclient-4.3.6.jar" ),
			expandPath( "/antisamy/httpcore-4.3.3.jar" ),
			// expandPath( "/antisamy/log4j-1.2.17.jar" ),
			// expandPath( "/antisamy/logkit-1.0.1.jar" ),
			expandPath( "/antisamy/nekohtml-1.9.22.jar" ),
			expandPath( "/antisamy/xercesImpl-2.11.0.jar" ),
			expandPath( "/antisamy/xml-apis-1.4.01.jar" ),
			expandPath( "/antisamy/xml-apis-ext-1.3.04.jar" ),
			// expandPath( "/antisamy/xml-resolver-1.2.jar" ),
			expandPath( "/antisamy/xmlgraphics-commons-2.2.jar" )
		]);

		// Indicate that the application has been initialized successfully.
		return( true );

	}

}
