this.legend_safeguard_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		this.m.ID = "actives.legend_safeguard";
		this.m.Name = "Safeguard";
		this.m.Description = "Use your shield to protect an ally, leaving yourself exposed";
		this.m.SoundOnUse = [
			"sounds/combat/stab_01.wav",
			"sounds/combat/stab_02.wav",
			"sounds/combat/stab_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/weapon_break_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
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

	function getTooltip() {
		local ret = this.skill.getDefaultUtilityTooltip();
		local block = this.getContainer().getActor().getCurrentProperties().getBlock();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Applies [color=%effect%]Safeguard[/color] to someone, increasing their Block by [color=%positive%]%_block%[/color]",
			param = [["_block", block]]
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/block.png",
			text = "Reduces your own Block to [color=%negative%]0[/color]"
		});
		return ret;
	}

	function isUsable() {
		if (!this.skill.isUsable()) {
			return false;
		}
		if (::Legends.Effects.has(this, ::Legends.Effect.LegendSafeguarding)) {
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile ) {
		if (!_targetTile.IsOccupiedByActor) {
			return;
		}

		local target = _targetTile.getEntity();
		::Legends.Effects.grant(target, ::Legends.Effect.LegendSafeguarded, function (_skill) {
			_skill.m.Block = this.getContainer().getActor().getCurrentProperties().getBlock();
		}.bindenv(this));

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " is safeguarding " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}

		::Legends.Effects.grant(this, ::Legends.Effect.LegendSafeguarding);
	}

	function onVerifyTarget( _originTile, _targetTile ) {
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) {
			return false;
		}

		if (!this.m.Container.getActor().isAlliedWith(_targetTile.getEntity())) {
			return false;
		}

		if (::Legends.Effects.has(_targetTile.getEntity(), ::Legends.Effect.LegendSafeguarded)) {
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = (_properties.IsSpecializedInShields || _properties.IsProficientWithShieldSkills) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onRemoved() {
		::Legends.Effects.remove(this, ::Legends.Effect.LegendSafeguarding);
	}
});