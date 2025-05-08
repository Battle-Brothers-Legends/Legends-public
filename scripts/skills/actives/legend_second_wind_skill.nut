this.legend_second_wind_skill <- this.inherit("scripts/skills/skill", {
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSecondWind);
		this.m.Description = "\'I\'m not out yet\'. Fully refresh your Fatigue, and grant [color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Fatigue Recovery for 3 turns. Additionally, remove any [color=#731f39]Stun[/color], [color=#731f39]Daze[/color], [color=#731f39]Stagger[/color], [color=#731f39]Baffle[/color], [color=#731f39]Charmed[/color] or [color=#731f39]Sleeping[/color] status. Can only be used once per combat and is only usable if fatigue is 50% or lower and [color=#731f39]Second Wind[/color] has not already been used.";
		this.m.Icon = "skills/SecondWindSkill.png";
		this.m.IconDisabled = "skills/SecondWindSkill_bw.png";
		this.m.Overlay = "perk_54_active";
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Fully refresh Fatigue"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Fatigue Recovery per turn for [color=" + this.Const.UI.Color.PositiveValue + "]3[/color] turns"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Remove [color=#731f39]Stun[/color], [color=#731f39]Daze[/color], [color=#731f39]Stagger[/color], [color=#731f39]Baffle[/color]"
			}
		]);
		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local fatiguePct = this.getContainer().getActor().getFatiguePct() < 0.5;
		return this.skill.isUsable() && actor.getFatiguePct() < 0.5 && !actor.getSkills().hasEffect(::Legends.Effect.LegendSecondWind);
	}

	function onUse( _user, _targetTile )
	{
		::Legends.Effects.grant(_user, ::Legends.Effect.LegendSecondWind);
		_user.getSkills().update();
		return true;
	}
});