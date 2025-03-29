::mods_hookExactClass("skills/actives/throw_dirt_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Throws dirt to distract the enemy. Reduces inititive and damage output of the target by 35% for one turn. Can only be used once per battle.";
		this.m.IconDisabled = "skills/active_215_sw.png";
		this.m.IsUsingHitchance = true;
	}

	o.isUsable <- function ()
	{
		if (this.getContainer().hasEffect(::Legends.Effect.LegendThrewSandEffect))
		{
			return false;
		}

		return this.skill.isUsable();
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		::Legends.Effects.grant(_user, ::Legends.Effect.LegendThrewSandEffect);
		onUse( _user, _targetTile );
	}
});
