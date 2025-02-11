::mods_hookExactClass("skills/items/generic_item", function(o)
{
	o.onUpdate = function ( _properties )
	{
		if (!::MSU.isNull(this.m.Item) && !::MSU.isNull(this.m.Item.getContainer()))
		{
			this.m.Item.onUpdateProperties(_properties);
		}
		else
		{
			this.removeSelf();
		}
	}

	o.onTurnStart = function ()
	{
		if (!::MSU.isNull(this.m.Item) && !::MSU.isNull(this.m.Item.getContainer()))
		{
			this.m.Item.onTurnStart();
		}
		else
		{
			this.removeSelf();
		}
	}

});
