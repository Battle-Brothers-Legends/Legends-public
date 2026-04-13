::mods_hookExactClass("skills/actives/reload_handgonne_skill", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = true;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		onAfterUpdate(_properties);
		this.m.ActionPointCost = 9;
		if (_properties.IsSpecializedInCrossbows)
			this.m.ActionPointCost -= 3; 
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendSpecialistInventor))
			this.m.ActionPointCost -= 1;
	}

	local isUsable = o.isUsable;
	o.isUsable = function()
	{
		return isUsable() && !this.getItem().isLoaded();
	}
	
	o.onUse = function( _user, _targetTile )
	{
		this.consumeAmmo();
		this.getItem().setLoaded(true);
		return true;
	}

	o.onUpdate <- function(_properties)
	{
		this.m.IsHidden = this.getItem().isLoaded();
	}
});
