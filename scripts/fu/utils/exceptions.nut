local function getInQuotes( _string )
{
	return _string == "" ? _string : " \'" + _string + "\'";
}

::FU.Exception <- {
	KeyNotFound = function( _string ) { return format("Key%s not found", getInQuotes(_string)); },
	NotConnected = function( _string = "" ) { return format("The screen%s does not have a JSHandle (make sure you connect your screens)", getInQuotes(_string)); },
	AlreadyInState = function( _string = "" ) { return format("Trying to show already visible screen%s or hide an invisible one", getInQuotes(_string)); },
	InvalidType = function( _string = "" ) { return format("The variable%s is of the wrong type", getInQuotes(_string)); },
	DuplicateKey = function( _string ) { return format("The key%s is already present", getInQuotes(_string)); },
	InvalidValue = function( _string = "" ) { return format("The value of the variable%s is not acceptable", getInQuotes(_string)); }
};

::FU.Error <- {
	ModNotRegistered = function( _string = "" ) { return format("Register your mod%s with a system before trying to interact with it", getInQuotes(_string)); },
	NotSemanticVersion = function( _string = "" ) { return format("Given version%s is not formatted according to Semantic Versioning guidelines (see https://semver.org/)", getInQuotes(_string)); }
};
