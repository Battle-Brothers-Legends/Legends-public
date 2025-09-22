this.legend_flourish_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendFlourish);
		this.m.Description = "Prepare to show your enemies a dazzling display of swordmanship. Increase fatigue costs by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] and [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] of the difference between you and your target\'s current initiative as armor penetration. Lasts until the start of your next turn.";
		this.m.Icon = "skills/perk_41_active.png";
		this.m.IconDisabled = "skills/perk_41_active_sw.png";
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

	function isUsable()
	{
		local effect = ::Legends.Effects.get(this, ::Legends.Effect.LegendFlourish);

		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && effect == null;
	}

	function onUse( _user, _targetTile )
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendFlourish);
		return true;
	}

});

