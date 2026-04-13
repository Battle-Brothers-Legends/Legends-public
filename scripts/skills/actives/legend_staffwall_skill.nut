this.legend_staffwall_skill <- this.inherit("scripts/skills/skill", {
	m = {
		BaseAttackName = "Thrust"
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendStaffwall);
		this.m.Icon = "skills/active_23.png";
		this.m.IconDisabled = "skills/active_23_sw.png";
		this.m.Overlay = "active_23";
		this.m.SoundOnUse = [
			"sounds/combat/spearwall_01.wav",
			"sounds/combat/spearwall_02.wav",
			"sounds/combat/spearwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getDescription()
	{
		return "Prepare to immediately attack any opponent that attempts to move into melee range and, on a hit, prevent that opponent from closing in. Targets hit will receive half the damage of a normal " + this.m.BaseAttackName + " attack. Can not be used while already engaged in melee.";
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
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && !this.getContainer().hasEffect(::Legends.Effect.LegendStaffwall);
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInSpears )
		{
			this.m.FatigueCostMult *= 0.75;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		::Legends.Effects.grant(this, ::Legends.Effect.LegendStaffwall);

		if (!_user.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Spearwall");
		}

		return true;
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendStaffwall);
	}

});

