::FU.requireString <- function( ... )
{
	::FU.requireTypeArray("string", vargv);
}

::FU.requireInt <- function( ... )
{
	::FU.requireTypeArray("integer", vargv);
}

::FU.requireArray <- function( ... )
{
	::FU.requireTypeArray("array", vargv);
}

::FU.requireFloat <- function( ... )
{
	::FU.requireTypeArray("float", vargv);
}

::FU.requireBool <- function( ... )
{
	::FU.requireTypeArray("bool", vargv);
}

::FU.requireTable <- function( ... )
{
	::FU.requireTypeArray("table", vargv);
}

::FU.requireInstance <- function( ... )
{
	::FU.requireTypeArray("instance", vargv);
}

::FU.requireInstanceOf <- function( _class, ... )
{
	foreach (value in vargv)
	{
		if (typeof value != "instance" || !(value instanceof _class))
		{
			::logError(value + " must be an instance of the class: " + _class);
			throw ::FU.Exception.InvalidType(value);
		}
	}
}

::FU.requireFunction <- function( ... )
{
	::FU.requireTypeArray("function", vargv);
}

::FU.requireType <- function( _type, ... )
{
	::FU.requireTypeArray(_type, vargv);
}

// Private
::FU.requireTypeArray <- function( _type, _values )
{
	foreach (value in _values)
	{
		if (typeof value != _type)
		{
			::logError(value + " must have the type: " + _type);
			throw ::FU.Exception.InvalidType(value);
		}
	}
}

::FU.requireOneFromTypes <- function( _typeArray, ... )
{
	foreach (value in vargv)
	{
		if (_typeArray.find(typeof value) == null)
		{
			::logError(value + " must have one of the types: " + _typeArray.reduce(@(a, b) format("%s, %s", a, b)));
			throw ::FU.Exception.InvalidType(value);
		}
	}
}

::FU.requireAnyTypeExcept <- function( _typeArray, ... )
{
	foreach (value in vargv)
	{
		if (_typeArray.find(typeof value) != null)
		{
			::logError(value + " must NOT have one of the types: " + _typeArray.reduce(@(a, b) format("%s, %s", a, b)));
			throw ::FU.Exception.InvalidType(value);
		}
	}
}
