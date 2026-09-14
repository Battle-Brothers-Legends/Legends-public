::Const.Tactical.Common.removeStances <- function( _actor, _removeValaTrance = false )
{
	::Legends.Effects.remove(_actor, ::Legends.Effect.Shieldwall);
	::Legends.Effects.remove(_actor, ::Legends.Effect.Spearwall);
	::Legends.Effects.remove(_actor, ::Legends.Effect.Riposte);
	::Legends.Effects.remove(_actor, ::Legends.Effect.LegendReturnFavor);

	if (_removeValaTrance) {
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendValaChantDisharmonyEffect);
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendValaChantFuryEffect);
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendValaChantSensesEffect);
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendValaCurrentlyChanting);
		::Legends.Effects.remove(_actor, ::Legends.Effect.LegendValaInTrance);
	}
};

::Const.Tactical.Common.getRandomPlayerNameFemale <- function()
{
	return this.Const.Strings.CharacterNamesFemale[this.Math.rand(0, this.Const.Strings.CharacterNamesFemale.len() - 1)];
};

::Const.Tactical.Common.onApplyHolyFlame <- function (_tile, _entity, _killer = null) {
	local sounds = [
		"sounds/combat/fire_01.wav",
		"sounds/combat/fire_02.wav",
		"sounds/combat/fire_03.wav",
		"sounds/combat/fire_04.wav",
		"sounds/combat/fire_05.wav",
		"sounds/combat/fire_06.wav"
	];

	::Sound.play(sounds[::Math.rand(0, sounds.len() - 1)], ::Const.Sound.Volume.Actor, _entity.getPos());

	if (_entity.isNonCombatant()) {
		return;
	}

	local faction = _entity.getFaction();

	if ((_entity.getFlags().has("undead") && !_entity.getFlags().has("ghoul")) || _entity.getFlags().has("cultist")) {
		if (!_entity.getSkills().hasEffect(::Legends.Effect.LegendConsecratedEffect)) {
			::Legends.Effects.grant(_entity, ::Legends.Effect.LegendConsecratedEffect, function (_effect) {
				if (!::Legends.S.isEntityNullOrDead(_killer) && _killer.getFaction() == ::Const.Faction.Player) {
					_effect.setActor(_killer);
				}
			}.bindenv(this));
		}
		return;
	} else if (faction == ::Const.Faction.Player || faction == ::Const.Faction.Civilian || faction == ::Const.Faction.NobleHouse) {
		if (!_entity.getSkills().hasEffect(::Legends.Effect.LegendSanctifiedEffect)) {
			::Legends.Effects.grant(_entity, ::Legends.Effect.LegendSanctifiedEffect);
		}
	}
};

::Const.Tactical.Common.onApplyShadowMist <- function (_tile, _entity) {
	if (!_entity.getFlags().has("alp") && _entity.getMoraleState == ::Const.MoraleState.Ignore) {
		return;
	}

	if (_entity.getSkills().hasEffect(::Legends.Effect.LegendAlpRealmOfShadow)) {
		return;
	}

	::Sound.play(::MSU.Array.rand(::Legends.S.setSounds("sounds/enemies/dlc2/alp_nightmare", 6)), ::Const.Sound.Volume.Actor, _entity.getPos());

	::Legends.Effects.grant(_entity, ::Legends.Effect.LegendAlpRealmOfShadow);
}

local onApplyMiasma = ::Const.Tactical.Common.onApplyMiasma;
::Const.Tactical.Common.onApplyMiasma = function (_tile, _entity, _killer = null) {
	local onDamageReceived = _entity.onDamageReceived;
	_entity.onDamageReceived = function (_attacker, _skill, _hitInfo) {
		return onDamageReceived(_killer != null ? _killer : _attacker, _skill, _hitInfo);
	};

	onApplyMiasma(_tile, _entity);

	if (::Legends.S.isEntityNullOrDead(_entity)) {
		return;
	}

	_entity.onDamageReceived = onDamageReceived;
}

local onApplyFire = ::Const.Tactical.Common.onApplyFire;
::Const.Tactical.Common.onApplyFire = function (_tile, _entity, _killer = null) {
	local onDamageReceived = _entity.onDamageReceived;
	_entity.onDamageReceived = function ( _attacker, _skill, _hitInfo ) {
		local damage = ::Math.rand(15, 30);
		_hitInfo.DamageRegular = damage * this.getCurrentProperties().DamageReceivedFireMult;
		_hitInfo.DamageArmor = damage;
		return onDamageReceived(_killer != null ? _killer : _attacker, _skill, _hitInfo);
	};

	onApplyFire(_tile, _entity);

	if (::Legends.S.isEntityNullOrDead(_entity))
		return;

	_entity.onDamageReceived = onDamageReceived;
};


::Const.Tactical.Common.onApplyFireRune <- function (_tile, _entity, _killer = null) {
	if (_entity.getCurrentProperties().IsImmuneToFire)
		return;

	local damage = _tile.Properties.Effect.Damage;

	::Tactical.spawnIconEffect("status_effect_116", _tile,
		::Const.Tactical.Settings.SkillIconOffsetX,
		::Const.Tactical.Settings.SkillIconOffsetY,
		::Const.Tactical.Settings.SkillIconScale,
		::Const.Tactical.Settings.SkillIconFadeInDuration,
		::Const.Tactical.Settings.SkillIconStayDuration,
		::Const.Tactical.Settings.SkillIconFadeOutDuration,
		::Const.Tactical.Settings.SkillIconMovement
	);
	local sounds = [
		"sounds/combat/dlc6/status_on_fire_01.wav",
		"sounds/combat/dlc6/status_on_fire_02.wav",
		"sounds/combat/dlc6/status_on_fire_03.wav"
	];
	::Sound.play(sounds[::Math.rand(0, sounds.len() - 1)], ::Const.Sound.Volume.Actor, _entity.getPos());

	local hitInfo = clone ::Const.Tactical.HitInfo;
	hitInfo.DamageRegular = damage * _entity.getCurrentProperties().DamageReceivedFireMult;
	hitInfo.DamageArmor = damage;
	hitInfo.DamageDirect = 0.1;
	hitInfo.BodyPart = ::Const.BodyPart.Body;
	hitInfo.BodyDamageMult = 1.0;
	hitInfo.FatalityChanceMult = 0.0;
	hitInfo.Injuries = ::Const.Injury.Burning;
	hitInfo.IsPlayingArmorSound = false;
	_entity.onDamageReceived(_killer != null ? _killer : _entity, null, hitInfo);

	if ((!_entity.isAlive() || _entity.isDying()) && !_entity.isPlayerControlled() && (_tile.Properties.Effect == null || _tile.Properties.Effect.IsByPlayer)) {
		::updateAchievement("BurnThemAll", 1, 1);
	}
}
