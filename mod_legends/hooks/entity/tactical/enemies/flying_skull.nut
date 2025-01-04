::mods_hookExactClass("entity/tactical/enemies/flying_skull", function(o) 
{
	o.m.IsExploded <- false;
	o.m.HasKilledPlayer <- false;

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
	}

	o.onActorKilled <- function ( _actor, _tile, _skill ) //Fixes suicide exploit
	{
		if (!this.m.HasKilledPlayer)
		{
			this.m.HasKilledPlayer = _actor.getFaction() == this.Const.Faction.Player;
		}

		this.actor.onActorKilled( _actor, _tile, _skill );
	}

	o.onAfterDeath <- function ( _tile ) //Fixes suicide exploit
	{
		if (this.m.HasKilledPlayer && this.Tactical.Entities.getHostilesNum() != 0)
		{
			this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerDestroyed);
		}
	}
});