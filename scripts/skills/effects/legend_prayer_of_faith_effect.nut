this.legend_prayer_of_faith_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Resolve = 0
	},
	function create()
	{
		this.m.ID = "effects.legend_prayer_of_faith";
		this.m.Name = "Prayer of Faith";
		this.m.Description = "This character is being protected by a holy chant.";
		this.m.Icon = "ui/perks/prayer_purple.png";
		this.m.Overlay = "prayer_purple";
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
				text = "Melee and Ranged Defense increased by [color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color]"
			}
		];
	}


	function onAdded()
	{
		local actor = this.getContainer().getActor();
		this.spawnIcon(this.m.Overlay, actor.getTile());
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;

	}

});

