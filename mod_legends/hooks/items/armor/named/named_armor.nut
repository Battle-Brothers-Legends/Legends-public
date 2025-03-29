::mods_hookExactClass("items/armor/named/named_armor", function(o) {
	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}
});