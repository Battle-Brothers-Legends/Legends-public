this.perk_legend_barter_greed <- this.inherit("scripts/skills/skill", {
	m = {
		SoftCap = 80000,			// Bonus gained from Crowns above this value is penalized
		SoftCapPenalty = 0.20,		// Multiplier for Bonus gained from Crowns above SoftCap

		// Every 10000 Crowns // Says multiplier, but rather just adds flat rate.
		OffensiveMult = 1.5,
		DefensiveMult = 1.5,
		ResolveMult = 2.0
	},

	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendBarterGreed);
		this.m.Icon = "ui/perks/BarterT1.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "This character is keen to guard the horde of gold the company has accumulated — and intends to protect it with their life.";
	}

	function getTooltip()
	{
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateBonus(this.m.OffensiveMult) + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateBonus(this.m.OffensiveMult) + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateBonus(this.m.DefensiveMult) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateBonus(this.m.DefensiveMult) + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.calculateBonus(this.m.ResolveMult) + "[/color] Resolve"
			}
		];
	}
	function onUpdate( _properties ) //used 10k coin as a baseline
	{
		_properties.MeleeSkill += this.calculateBonus(this.m.OffensiveMult);
		_properties.RangedSkill += this.calculateBonus(this.m.OffensiveMult);
		_properties.MeleeDefense += this.calculateBonus(this.m.DefensiveMult);
		_properties.RangedDefense += this.calculateBonus(this.m.DefensiveMult);
		_properties.Bravery += this.calculateBonus(this.m.ResolveMult);
	}

	function calculateBonus(_multiplier) //+14 @ 10K
	{
		return this.calculateSoftCappedBonus(_multiplier, this.World.Assets.getMoney());
	}

	function calculateSoftCappedBonus(_multiplier, _crowns)
	{
		local unCappedBonus = this.calculateGenericBonus(_multiplier, ::Math.min(_crowns, this.m.SoftCap));
		local cappedBonus = this.calculateGenericBonus(_multiplier, _crowns - this.m.SoftCap);
		return unCappedBonus + ::Math.floor(cappedBonus * this.m.SoftCapPenalty);
	}

	function calculateGenericBonus(_multiplier, _crowns)
	{
		return ::Math.max(::Math.floor(_crowns / 10000.0 * _multiplier), 0);
	}

	function onAdded()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
		this.World.State.getPlayer().calculateWageModifier();
	}

	function onRemoved()
	{
		if (this.World.State.getPlayer() == null)
		{
			return;
		}

		this.World.State.getPlayer().calculateBarterMult();
		this.World.State.getPlayer().calculateWageModifier();
	}


});
