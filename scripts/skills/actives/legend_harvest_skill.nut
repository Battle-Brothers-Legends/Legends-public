this.legend_harvest_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		],
		TilesLeft = 1
	},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHarvest);
		this.m.Description = "Swinging the weapon in an arc that hits two adjacent tiles in counter-clockwise order. Be careful around your own men unless you want to relieve your payroll!";
		this.m.Icon = "skills/active_06.png";
		this.m.IconDisabled = "skills/active_06_sw.png";
		this.m.Overlay = "active_06";
		this.m.SoundOnUse = [
			"sounds/combat/swing_01.wav",
			"sounds/combat/swing_02.wav",
			"sounds/combat/swing_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/swing_hit_01.wav",
			"sounds/combat/swing_hit_02.wav",
			"sounds/combat/swing_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
	}

	function getTooltip() {
		local ret = this.getDefaultTooltip();
		local dmg = this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5;
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 2 targets"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=%damage%]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "Inflicts [color=%damage%]20%[/color] more damage against bleeding enemies"
		});
		return ret;
	}

	function onAfterUpdate( _properties ) {
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		local success = false;
		local ownTile = _user.getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		success = this.attackEntity(_user, target);

		if (::Legends.S.isEntityNullOrDead(_user))
			return success;
		
		if (success)
			::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);

		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir)) {
			local nextTile = ownTile.getNextTile(nextDir);

			if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && this.Math.abs(nextTile.Level - ownTile.Level) <= 1) {
				target = nextTile.getEntity();
				hp = nextTile.getEntity().getHitpoints();
				success = this.attackEntity(_user, target) || success;

				if (success)
					::Legends.S.applyBleed(target, _user, hp, this.m.SoundsA, this.m.SoundsB);
			}
		}

		return success;
	}

	function onTargetSelected( _targetTile ) {
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		local nextDir = dir - 1 >= 0 ? dir - 1 : this.Const.Direction.COUNT - 1;

		if (ownTile.hasNextTile(nextDir)) {
			local nextTile = ownTile.getNextTile(nextDir);

			if (this.Math.abs(nextTile.Level - ownTile.Level) <= 1) {
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_targetEntity == null)
			return;

		if (_skill == this && ::Legends.Effects.has(_targetEntity, ::Legends.Effect.Bleeding)) {
			_properties.DamageTotalMult *= 1.2;
		}
	}
});

