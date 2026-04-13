this.legend_command_legion_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCommandLegion);
		this.m.Description = "Command a fighter of Centurion rank or lower to do your bidding. Targets can only be inspired once per turn. Does not work on Legates.";
		this.m.Icon = "skills/legend_legion_command_square.png";
		this.m.IconDisabled = "skills/legend_legion_command_square_bw.png";
		this.m.IconMini = "legend_status_effect_legion_command_mini";
		this.m.Overlay = "legend_legion_command_square";
		this.m.SoundOnUse = [ //new sounds would be good
			"sounds/combat/inspire_01.wav",
			"sounds/combat/inspire_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
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
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants the target Grants the target [color=%positive%]+4[/color] additional Action Points for their next turn."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Grants the target an additional [color=%positive%]+50[/color] Initiative for their next turn."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Grants the target an additional [color=%positive%]+10[/color] Melee Skill for their next turn"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "Grants the target an additional [color=%positive%]+5[/color] Melee Defense for their next turn"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Grants the target an additional [color=%positive%]+15[/color] Ranged Skill for their next turn"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Grants the target an additional [color=%positive%]+5[/color] Ranged Defense for their next turn"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Reduces damage received by [color=%positive%]50%[/color] for their next turn"
			}
		];
		return ret;
	}


	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		if (_targetTile.getEntity() == null)
			return false;

		if (!_targetTile.getEntity().getFlags().has("legion_can_command"))
			return false;

		if (_targetTile.getEntity().getSkills().hasEffect(::Legends.Effect.LegendCommanded))
			return false;

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		::Legends.Effects.grant(target, ::Legends.Effect.LegendCommanded);
		return true;
	}

});
