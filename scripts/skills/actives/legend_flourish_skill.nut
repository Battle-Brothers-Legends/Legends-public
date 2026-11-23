this.legend_flourish_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFlourish);
		this.m.Description = "Prepare to show your enemies a dazzling display of swordsmanship.";
		this.m.Icon = "ui/perks/perk_41_active.png";
		this.m.IconDisabled = "ui/perks/perk_41_active_sw.png";
		this.m.Overlay = "perk_41_active";
		this.m.SoundOnUse = [
			"sounds/combat/legend_parried_01.wav",
			"sounds/combat/legend_parried_08.wav",
			"sounds/combat/legend_parried_07.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 5;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Increases fatigue use of all attack skills by [color=%positive%]75%[/color]"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Increases Action Point cost of all attack skills by [color=%positive%]1[/color]"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Chance on each attack to ignore armor completely, the chance is [color=%positive%]50%[/color] of the Initiative difference between you and the target as long as you are faster"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "As long as you are faster than the target, any attack that inflicts at least [color=%positive%]1[/color] point of damage to Hitpoints triggers a morale check for the opponent with a penalty equal to [color=%negative%]20%[/color] of the Initiative difference between you and the target"
			}
		];
	}

	function isUsable()
	{
		local effect = ::Legends.Effects.get(this, ::Legends.Effect.LegendFlourish);

		return !this.Tactical.isActive() || this.skill.isUsable() && effect == null;
	}

	function onUse( _user, _targetTile )
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendFlourish);
		return true;
	}

});

