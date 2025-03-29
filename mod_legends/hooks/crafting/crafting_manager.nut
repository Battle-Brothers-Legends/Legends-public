::mods_hookNewObject("crafting/crafting_manager", function(o)
{
	o.getQualifiedBlueprintsForUI = function (_filter = this.Const.Items.ItemFilter.All)
	{
		local ret = [];

		foreach( b in this.m.Blueprints )
		{
			if ((b.getItemType() & _filter) == 0)
			{
				continue;
			}

			if (b.isQualified())
			{
				ret.push(b.getUIData());
			}
		}

		ret.sort(this.onSortBlueprints);
		return ret;
	}

	o.getQualifiedEnchanterBlueprintsForUI <- function ()
	{
		local ret = [];

		foreach( b in this.m.Blueprints )
		{
			if (b.isQualifiedEnchant())
			{
				ret.push(b.getUIData());
			}
		}

		ret.sort(this.onSortBlueprints);
		return ret;
	}

	o.deleteAllBlueprints <- function ()
	{
		foreach ( bp in this.m.Blueprints )
		{
			bp = null;
		}
		this.m.Blueprints = [];
	}

	o.resetAllBlueprints <- function ()
	{
		this.deleteAllBlueprints();
		this.create();
	}

	o.clear = function ()
	{
		foreach( b in this.m.Blueprints )
		{
			b.reset();
		}
	}

	o.onSortBlueprints = function ( _b1, _b2 )
	{
		if (_b1.IsCraftable && !_b2.IsCraftable)
		{
			return -1;
		}
		else if (!_b1.IsCraftable && _b2.IsCraftable)
		{
			return 1;
		}
		else if (_b1.Type > _b2.Type)
		{
			return 1;
		}
		else if (_b1.Type < _b2.Type)
		{
			return -1;
		}
		else if (_b1.Name > _b2.Name)
		{
			return 1;
		}
		else if (_b1.Name < _b2.Name)
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}
});
