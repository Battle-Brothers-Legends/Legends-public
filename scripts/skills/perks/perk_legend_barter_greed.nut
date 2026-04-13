this.perk_legend_barter_greed <- this.inherit("scripts/skills/skill", {
	m = {
		SoftCap = 160000,			// Bonus gained from Crowns above this value is penalized
		SoftCapPenalty = 0.20,		// Multiplier for Bonus gained from Crowns above SoftCap

		// Every 10000 Crowns // Says multiplier, but rather just adds flat rate.
		OffensiveMult = 1.0,
		DefensiveMult = 1.0,
		ResolveMult = 1.5,
		InitiativeMult = 1.5
	},

	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBarterGreed);
		this.m.Icon = "ui/perks/BarterT1.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
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
				text = "[color=%positive%]+" + this.calculateBonus(this.m.OffensiveMult) + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + this.calculateBonus(this.m.OffensiveMult) + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.calculateBonus(this.m.DefensiveMult) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + this.calculateBonus(this.m.DefensiveMult) + "[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.calculateBonus(this.m.ResolveMult) + "[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + this.calculateBonus(this.m.InitiativeMult) + "[/color] Initiative"
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
		_properties.Initiative += this.calculateBonus(this.m.ResolveMult);
	}

	function calculateBonus(_multiplier) //+14 @ 10K
	{
		return this.calculateSoftCappedBonus(_multiplier, this.World.Assets.getMoney());
	}

	function calculateSoftCappedBonus(_multiplier, _crowns)
	{
		local unCappedBonus = this.calculateGenericBonus(_multiplier, ::Math.min(_crowns, this.m.SoftCap)); // soft cap is hard cap cause some idiot made 18 mil gold
		// local cappedBonus = this.calculateGenericBonus(_multiplier, _crowns - this.m.SoftCap);
		// return unCappedBonus + ::Math.floor(cappedBonus * this.m.SoftCapPenalty);
		return unCappedBonus;
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
