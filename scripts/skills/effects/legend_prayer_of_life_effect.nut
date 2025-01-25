this.legend_prayer_of_life_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Resolve = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrayerOfLife);
		this.m.Description = "This character has had their vitality restored by a holy chant.";
		this.m.Icon = "ui/perks/prayer_green.png";
		this.m.Overlay = "prayer_green";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getBonus()
	{
		// local actor = this.getContainer().getActor();
		local resolve = this.m.Resolve;
		local bonus = this.Math.floor(resolve * 0.20);

		return bonus;
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = "Was healed for [color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Hitpoints"
			}
		];
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local bonus = this.getBonus();
		this.spawnIcon(this.m.Overlay, actor.getTile());
		if (actor.getHitpoints() < actor.getHitpointsMax())
		{
			actor.setHitpoints(this.Math.max(0, actor.getHitpoints() + bonus));
		}

	}

});

