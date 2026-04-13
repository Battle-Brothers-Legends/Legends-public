this.legend_withering_aura_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendWitheringAura); //should provide debuffs if not a necromancer or a puppet
		this.m.Name = "Withering Aura";
		this.m.Icon = "ui/perks/rust56_circle.png"; //placeholder for now
		this.m.Description = "This character is under the effect of a dark aura. They are slow, sluggish and have difficulty fighting. However, the numbness has yielded beneficial side effects...";
		this.m.Excluded = [];
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		local isAfflicted = this.getContainer().getActor().getFlags().has("human"); //alternate is PlayerZombie or PlayerSkeleton - resourced from player.nut

		if (isAfflicted)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+25%[/color] less damage received"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=%positive%]+10%[/color] Health"
			});
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%negative%]-10%[/color] Resolve"
			});
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-5%[/color] Melee Skill"
			});
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-5%[/color] Ranged Skill"
			});
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-10%[/color] Melee Defense"
			});
			ret.push({
				id = 16,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-10%[/color] Ranged Defense"
			});
			ret.push({
				id = 17,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-5%[/color] Initiative"
			});
		}

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("eye_rings"))
		{
			actor.getSprite("eye_rings").Visible = true;
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("eye_rings"))
		{
			actor.getSprite("eye_rings").Visible = false;
		}
	}

	function onUpdate( _properties )
	{
		// added the variable down here again since it was causing errors - James
		local isAfflicted = this.getContainer().getActor().getFlags().has("human"); //alternate is PlayerZombie or PlayerSkeleton - resourced from player.nut.
		if (isAfflicted)
		{
			_properties.DamageReceivedRegularMult *= 0.75;
			_properties.HitpointsMult *= 1.1;
			_properties.BraveryMult *= 0.9;
			_properties.MeleeSkillMult *= 0.9;
			_properties.RangedSkillMult *= 0.9;
			_properties.MeleeDefenseMult *= 0.9;
			_properties.RangedDefenseMult *= 0.9;
			_properties.InitiativeMult *= 0.95;
		}
	}

});

