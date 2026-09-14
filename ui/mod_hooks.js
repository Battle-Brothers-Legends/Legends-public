"use strict";
var onConnection = MainMenuScreen.prototype.onConnection;
MainMenuScreen.prototype.onConnection = function(handle)
{
  onConnection.bind(this)(handle);

  SQ.call(this.mSQHandle, "getRegisteredCSSHooks", null, function(a) {
	for(var i=0; i<a.length; i++)
	{
	  var link = document.createElement("link");
	  link.rel = "stylesheet";
	  link.type = "text/css";
	  link.href = a[i];
	  document.body.appendChild(link);
	}
  }.bind(this));

  SQ.call(this.mSQHandle, "getRegisteredJSHooks", null, function(a) {
	for(var i=0; i<a.length; i++)
	{
	  var js = document.createElement("script");
	  js.src = a[i];
	  document.body.appendChild(js);
	}
  }.bind(this));
}
