this.legend_RSW_blazing <- this.inherit("scripts/skills/skill", {
	m = {
		TargetTile = null,
	},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswBlazing);
		this.m.Description = "Rune Sigil: Blazing";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed ( _skill, _targetEntity, _properties ) {
		if (_skill.getItem() != null && _skill.getItem().getID() == this.getID() && _targetEntity != null)
			this.m.TargetTile = _targetEntity.getTile();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor ) {
		if ( _skill == null || _skill.m.IsWeaponSkill == false )
			return;

		if (!_skill.isAttack())
			return;

		if (_skill.getItem() == null)
			return;

		if (_skill.getItem().getID() != this.getItem().getID())
			return;

		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		local p = {
			Type = "fire",
			Tooltip = "Fire rages here, melting armor and flesh alike",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = this.getContainer().getActor().isPlayerControlled(),
			Timeout = ::Time.getRound() + this.getItem().getRuneBonus2(),
			Damage = this.getItem().getRuneBonus1(),
			Callback = ::Const.Tactical.Common.onApplyFireRune,
			Applicable = @(_a) true
		};

		local tile = this.m.TargetTile != null ? this.m.TargetTile : _target.getTile();
		if (tile == null)
			return;

		if (
			tile.Subtype != ::Const.Tactical.TerrainSubtype.Snow &&
			tile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow &&
			tile.Type != ::Const.Tactical.TerrainType.ShallowWater &&
			tile.Type != ::Const.Tactical.TerrainType.DeepWater)
		{
			if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire") {
				tile.Properties.Effect.Timeout = ::Time.getRound() + this.getItem().getRuneBonus2();
				tile.Properties.Effect.Damage = this.getItem().getRuneBonus1();
			} else {
				if (tile.Properties.Effect != null) {
					::Tactical.Entities.removeTileEffect(tile);
				}

				tile.Properties.Effect = clone p;
				local particles = [];

				for (local i = 0; i < this.Const.Tactical.FireParticles.len(); i++) {
					particles.push(::Tactical.spawnParticleEffect(true,
						::Const.Tactical.FireParticles[i].Brushes,
						tile,
						::Const.Tactical.FireParticles[i].Delay,
						::Const.Tactical.FireParticles[i].Quantity,
						::Const.Tactical.FireParticles[i].LifeTimeQuantity,
						::Const.Tactical.FireParticles[i].SpawnRate,
						::Const.Tactical.FireParticles[i].Stages
					));
				}

				::Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
				tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
				tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);
			}
		}

		if (tile.IsOccupiedByActor) {
			::Const.Tactical.Common.onApplyFireRune(tile, tile.getEntity());
		}
	}
});
