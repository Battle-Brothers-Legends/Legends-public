this.legend_safeguard_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendSafeguard);
		this.m.Description = "Use your shield to protect an ally, leaving yourself exposed.";
		this.m.Icon = "skills/fortify_square.png";
		this.m.IconDisabled = "skills/fortify_square_bw.png";
		this.m.Overlay = "active_32";
		this.m.SoundOnUse = [
			"sounds/combat/stab_01.wav",
			"sounds/combat/stab_02.wav",
			"sounds/combat/stab_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/weapon_break_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies Safeguard to someone, and will take the next hit instead of them"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces your own defenses by [color=%negative%]-10[/color]"
		});
		return ret;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.LegendFortify))
		{
			return false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.LegendSafeguarding))
		{
			return false;
		}
		if (this.getContainer().hasEffect(::Legends.Effect.Shieldwall))
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return;
		}

		local target = _targetTile.getEntity();
		::Legends.Effects.grant(target, ::Legends.Effect.LegendSafeguarded, function(_effect) {
			_effect.setProtector(this.getContainer().getActor());
			_effect.activate();
		}.bindenv(this));

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " is safeguarding " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}
		::Legends.Effects.grant(this, ::Legends.Effect.LegendSafeguarding, function(_effect) {
			_effect.setWard(target);
			_effect.activate();
		}.bindenv(this));
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

		if (_targetTile.getEntity().getSkills().hasEffect(::Legends.Effect.LegendSafeguarded))
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = (_properties.IsSpecializedInShields || _properties.IsProficientWithShieldSkills) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onRemoved()
	{
		::Legends.Effects.remove(this, ::Legends.Effect.LegendSafeguarding);
	}
});

