/*
    Main Application Configuration
    Application NAme: It Management
    Company: Nicera Philippines

    Developed By: Kay Singian
    email: kay.singian@nicera.ph | singiankay@gmail.com

 */

component {
    this.name = "it_management";
    this.currentPath = getDirectoryFromPath( getCurrentTemplatePath() );
    this.delim = find("/", this.currentPath) ? "/" : "\";
    this.basePath = listDeleteAt(this.currentPath, listLen(this.currentPath, this.delim), this.delim);
    this.datasource = "itmanagement";
    this.mappings = structNew();
    this.mappings["/com"] = this.basePath & this.delim & "com";
    this.ApplicationTimeout = CreateTimeSpan( 0, 8, 0, 0 );
    this.SessionManagement = true;
    this.SessionTimeout = CreateTimeSpan(0, 8, 0, 0);
    this.serialization.serializeQueryAs = "struct";
    this.serialization.preservecaseforstructkey = true;

    function onApplicationStart() {
        return true;
    }

    // function onSessionStart() {

    // }

    // the target page is passed in for reference, 
    // but you are not required to include it
    // function onRequestStart( string targetPage ) {}

    // function onRequest( string targetPage ) {
    //     include arguments.targetPage;
    // }
    // 
    // function onRequest () {
        // include "com/dataaccess/AssetManagementDAO.cfc";
        // include "com/dataaccess/Datasource.cfc";
        // var objAssetManagement = new AssetManagementDAO().init();

        // // Instantiate the Datasource object.\
        // //var DSAssetManagement = createObject('com.dataaccess.Datasource').init(Datasource=objAssetManagement);
        // var DSAssetManagement = new Datasource().init(Datasource=objAssetManagement);

        // // Store the UserDAO in the Application scope.
        // Application.AssetManagementDAO = DSAssetManagement;
    // }

    // function onRequestEnd() {}

    // function onSessionEnd( struct SessionScope, struct ApplicationScope ) {}

    // function onApplicationEnd( struct ApplicationScope ) {}

    // function onError( any Exception, string EventName ) {}
}
