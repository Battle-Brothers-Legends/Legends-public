local function verifyCompareInputs (_version1, _version2 )
{
	::FU.requireOneFromTypes(["string", "table", "instance"], _version1, _version2);
	if (typeof _version1 == "instance") ::FU.requireInstanceOf(::FU.Class.Mod, _version1);
	if (typeof _version2 == "instance") ::FU.requireInstanceOf(::FU.Class.Mod, _version2);
}

::FU.SemVer <- {
	// Slightly modified semver regex (https://semver.org/#is-there-a-suggested-regular-expression-regex-to-check-a-semver-string)
	Regex = regexp("^((?:(?:0|[1-9]\\d*)\\.){2}(?:0|[1-9]\\d*))(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$"),

	function isSemVer( _string )
	{
		if (typeof _string != "string") return false;
		return this.Regex.capture(_string) != null;
	}

	function getTable( _version )
	{
		local version = ::FU.SemVer.Regex.capture(_version);
		if (version == null)
		{
			::logError(::FU.Error.NotSemanticVersion(_version));
			throw ::FU.Exception.InvalidValue(_version);
		}
		return {
			Version = split(::FU.regexMatch(version, _version, 1), ".").map(@(_v) _v.tointeger()),
			PreRelease = ::FU.regexMatch(version, _version, 2) == null ? null : split(::FU.regexMatch(version, _version, 2), "."),
			Metadata = ::FU.regexMatch(version, _version, 3) == null ? null : split(::FU.regexMatch(version, _version, 3), ".")
		};
	}

	function formatVanillaVersion( _vanillaVersion )
	{
		local versionArray = split(_vanillaVersion, ".");
		local preRelease = versionArray.pop();
		return versionArray.reduce(@(_a, _b) _a + "." + _b) + "-" + preRelease;
	}

	function compare( _version1, _version2 )
	{
		for (local i = 0; i < 3; ++i)
		{
			if (_version1.Version[i] > _version2.Version[i]) return 1;
			else if (_version1.Version[i] < _version2.Version[i]) return -1;
		}

		if (_version1.PreRelease == null || _version2.PreRelease == null)
		{
			if (_version1.PreRelease == null && _version2.PreRelease != null) return 1;
			else if (_version1.PreRelease != null && _version2.PreRelease == null) return -1;
			return 0;
		}

		for (local i = 0; i < ::Math.min(_version2.PreRelease.len(), _version1.PreRelease.len()); ++i)
		{
			local isInt1 = ::FU.String.isInteger(_version1.PreRelease[i]);
			local isInt2 = ::FU.String.isInteger(_version2.PreRelease[i]);

			if (isInt1 || isInt2)
			{
				if (isInt1 && isInt2)
				{
					local int1 = _version1.PreRelease[i].tointeger();
					local int2 = _version2.PreRelease[i].tointeger();
					if (int1 < int2) return -1;
					else if (int1 > int2) return 1;
				}
				else
				{
					if (isInt1) return -1;
					else return 1;
				}
			}
			else
			{
				if (_version1.PreRelease[i] > _version2.PreRelease[i]) return 1;
				else if (_version1.PreRelease[i] < _version2.PreRelease[i]) return -1;
			}
		}

		if (_version1.PreRelease.len() > _version2.PreRelease.len()) return 1;
		else if (_version1.PreRelease.len() < _version2.PreRelease.len()) return -1;
		return 0;
	}

	function getShortVersionString( _version )
	{
		return _version.Version.reduce(@(_a, _b) _a + "." + _b);
	}

	function getVersionString( _version )
	{
		local ret = this.getShortVersionString(_version);

		if (_version.PreRelease != null)
		{
			ret += "-" + _version.PreRelease.reduce(@(_a, _b) _a + "." + _b);
		}

		if (_version.Metadata != null)
		{
			ret += "+" + _version.Metadata.reduce(@(_a, _b) _a + "." + _b);
		}

		return ret;
	}

	function compareVersionWithOperator( _version1, _operator, _version2 )
	{
		verifyCompareInputs(_version1, _version2);
		if (typeof _version1 == "string") _version1 = this.getTable(_version1);
		if (typeof _version2 == "string") _version2 = this.getTable(_version2);
		return ::FU.Utils.operatorCompare(this.compare(_version1, _version2), _operator)
	}

	function compareMajorVersionWithOperator( _version1, _operator, _version2 )
	{
		verifyCompareInputs(_version1, _version2);
		if (typeof _version1 == "string") _version1 = this.getTable(_version1);
		if (typeof _version2 == "string") _version2 = this.getTable(_version2);
		return ::FU.Utils.operatorCompare( _version1.Version[0] <=> _version2.Version[0], _operator);
	}

	function compareMinorVersionWithOperator( _version1, _operator, _version2 )
	{
		verifyCompareInputs(_version1, _version2);
		if (typeof _version1 == "string") _version1 = this.getTable(_version1);
		if (typeof _version2 == "string") _version2 = this.getTable(_version2);

		local majorCompare = _version1.Version[0] <=> _version2.Version[0];
		if (majorCompare != 0) return ::FU.Utils.operatorCompare(majorCompare, _operator)

		return ::FU.Utils.operatorCompare(_version1.Version[1] <=> _version2.Version[1], _operator);
	}
}
