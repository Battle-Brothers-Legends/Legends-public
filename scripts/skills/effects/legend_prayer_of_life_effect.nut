this.legend_prayer_of_life_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Heal = 0,
		LastRoundApplied = 0,
		TurnsLeft = 1
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrayerOfLife);
		this.m.Description = "This character has had their vitality restored by a holy chant";
		this.m.Icon = "ui/perks/prayer_green.png";
		this.m.Overlay = "prayer_green";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been blessed by a prayer of hope and will heal [color=%positive%]" + this.m.Heal + "[/color] hitpoints over [color=%positive%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function setHeal(_v)
	{
		this.m.Heal = _v;
	}

	function applyHealing()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon(this.m.Overlay, actor.getTile());
			local toHeal = this.Math.min(10, this.m.Heal);
			if (actor.getHitpoints() < actor.getHitpointsMax())
			{
				actor.setHitpoints(this.Math.max(0, actor.getHitpoints() + toHeal));
			}
			else
			{
				this.removeSelf();
			}

			this.m.Heal -= toHeal;
			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.ceil(this.m.Heal / 10);
		this.applyHealing();
	}

	function onUpdate( _properties )
	{
	}

	function onTurnEnd()
	{
		this.applyHealing();
	}

	function onWaitTurn()
	{
		this.applyHealing();
	}
});
