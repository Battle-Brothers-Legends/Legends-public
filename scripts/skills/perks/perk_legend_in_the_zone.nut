this.perk_legend_in_the_zone <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		MaxStacks = 25
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendInTheZone);
		this.m.Description = "%name% utilizes %their% armor\'s blend of protection and mobility to deal increased damage and gain increased accuracy when foes miss attacks against %them%.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getBonus();
		local actor = this.getContainer().getActor();

		if (bonus > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "+[color=%positive%]" + bonus + "%[/color] Melee Skill"
			});

			if (!actor.isPlacedOnMap() || ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)
			{
				bonus *= 2;
			}

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "+[color=%positive%]" + bonus + "%[/color] Melee Damage"
			});
		}

		if (!actor.isPlacedOnMap())
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The Melee Damage bonus will be [color=%negative%]halved[/color] when not engaged in melee"
			});
		}
		else if (::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true) == 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Melee Damage bonus [color=%negative%]halved[/color] due to not being engaged in melee"
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		return this.m.Stacks * 0.5;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
		{
			this.m.Stacks = 0;

			local armorFat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1;

			if (actor.getInitiative() >= 2*armorFat)
			{
				this.m.Stacks = this.Math.min(this.m.MaxStacks, this.Math.max(0, armorFat - 15));
			}
		}

		if (this.m.Stacks > 0)
		{
			local bonus = this.getBonus();
			_properties.MeleeSkillMult *= 1 + bonus * 0.01;

			if (!actor.isPlacedOnMap() || ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len() > 0)
			{
				bonus *= 2;
			}

			_properties.MeleeDamageMult *= 1 + bonus * 0.01;
		}
	}

	function onMissed( _attacker, _skill )
	{
		if (_attacker != null && _skill != null && _skill.isAttack() && !_skill.isRanged())
		{
			this.m.Stacks = this.Math.min(this.m.MaxStacks, this.m.Stacks + 1);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _skill != null && _skill.isAttack())
		{
			this.m.Stacks -= 2;
		}
	}
});
