this.legend_cheer_on_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendCheerOn);
		this.m.Description = "Give it your all! Put your support behind an ally, granting them two Actions Points. Targets can only be inspired once per turn and you must be adjacent.";
		this.m.Icon = "skills/cheered_on_square.png";
		this.m.IconDisabled = "skills/cheered_on_square_bw.png";
		this.m.Overlay = "perk_28_active";
		this.m.SoundOnUse = [
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
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
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
				icon = "ui/icons/action_points.png",
				text = "Grants the target 2 additional Action Points for their next turn."
			}
		];
		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getMainhandItem();
		if (mainhand == null || !this.skill.isUsable())
		{
			return false;
		}

		if (mainhand.isWeaponType(this.Const.Items.WeaponType.Musical) || mainhand.getID() == "weapon.player_banner")
		{
			return true;
		}

		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}

		if (_targetTile.getEntity().getSkills().hasEffect(::Legends.Effect.LegendCheeredOn))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		::Legends.Effects.grant(target, ::Legends.Effect.LegendCheeredOn);
		return true;
	}

});

