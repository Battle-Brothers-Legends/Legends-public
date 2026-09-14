::mods_hookExactClass("skills/actives/reload_bolt", function ( o )
{	
	o.m.FreeReload <- false;
	o.m.FreeReloadAPCost <- 0;
	o.m.FreeReloadFatCost <- 10;
	o.m.RegularAPCost <- 4;
	o.m.RegularFatCost <- 20;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = true;
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
		this.m.FreeReload = false;
		return true;
	}

	o.onUpdate <- function(_properties)
	{
		this.m.IsHidden = this.getItem().isLoaded();
	}


	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function(_properties)
	{
		onAfterUpdate(_properties);
		this.m.ActionPointCost = this.m.FreeReload ? this.m.FreeReloadAPCost : this.m.RegularAPCost;
		this.m.FatigueCost = this.m.FreeReload ? this.m.FreeReloadFatCost : this.m.RegularFatCost;
		local actor = this.getContainer().getActor();
		if (actor != null && actor.isAlive()) {
			actor.setDirty(true); 
		}
	}

	o.onTargetHit <- function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == null)
			return;

		if (_skill.getID() != ::Legends.Actives.getID(::Legends.Active.ShootBolt) && _skill.getID() != ::Legends.Actives.getID(::Legends.Active.ShootStake) && _skill.getID() != ::Legends.Actives.getID(::Legends.Active.LegendPiercingBolt))
			return;

		if (!::Legends.Perks.has(this.getContainer(), ::Legends.Perk.LegendBarrage))
			return;

		if (_bodyPart != this.Const.BodyPart.Head)
			return;

		this.m.FreeReload = true;
		this.m.ActionPointCost = this.m.FreeReloadAPCost;
		this.m.FatigueCost = this.m.FreeReloadFatCost;
	}
});
