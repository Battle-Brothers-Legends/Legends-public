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

::Const.Tactical.Common.onApplyFirefield <- function(_tile, _entity)
{
	this.Tactical.spawnIconEffect("fire_circle", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
	local sounds = [
			"sounds/combat/fire_01.wav",
			"sounds/combat/fire_02.wav",
			"sounds/combat/fire_03.wav",
			"sounds/combat/fire_04.wav",
			"sounds/combat/fire_05.wav",
			"sounds/combat/fire_06.wav"
		];

	this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());
	local hitInfo = clone this.Const.Tactical.HitInfo;
	hitInfo.DamageRegular = this.Math.rand(10, 20);
	hitInfo.DamageDirect = 1.0;
	hitInfo.BodyPart = this.Const.BodyPart.Body;
	hitInfo.BodyDamageMult = 1.0;
	hitInfo.FatalityChanceMult = 0.0;
	_tile.getEntity().onDamageReceived(_entity, null, hitInfo);
};

::Const.Tactical.Common.onApplyDemonShadows <- function(_tile, _entity)
{
	if (_entity.getSkills().hasTrait(::Legends.Trait.RacialAlp) || ::MSU.isKindOf(_entity, "legend_alp_shadow"))
	{
		return;
	}
	this.onApplyFirefield(_tile, _entity);
};

::Const.Tactical.Common.onApplyHolyFlame <- function(_tile, _entity, _killer = null)
{
	local sounds = [
		"sounds/combat/fire_01.wav",
		"sounds/combat/fire_02.wav",
		"sounds/combat/fire_03.wav",
		"sounds/combat/fire_04.wav",
		"sounds/combat/fire_05.wav",
		"sounds/combat/fire_06.wav"
	];

	this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());

	if (_entity.isNonCombatant() )
	{
		return;
	}

	local faction = _entity.getFaction();

	if ((_entity.getFlags().has("undead") && !_entity.getFlags().has("ghoul")) || _entity.getFlags().has("cultist"))
	{
		if (!_entity.getSkills().hasEffect(::Legends.Effect.LegendConsecratedEffect))
		{
			::Legends.Effects.grant(_entity, ::Legends.Effect.LegendConsecratedEffect, function(_effect) {
				if (_killer != null && _killer.getFaction() == this.Const.Faction.Player)
					_effect.setActor(_killer);
			}.bindenv(this));
		}
		return;
	}
	else if (faction == this.Const.Faction.Player || faction == this.Const.Faction.Civilian || faction == this.Const.Faction.NobleHouse)
	{
		if (!_entity.getSkills().hasEffect(::Legends.Effect.LegendSanctifiedEffect))
		{
			::Legends.Effects.grant(_entity, ::Legends.Effect.LegendSanctifiedEffect);
		}
	}
};

::Const.Tactical.Common.getFireDamageMultiplier <- function (_entity) {
	if (::Legends.S.oneOf(_entity.getType(), ::Const.EntityType.Schrat, ::Const.EntityType.LegendGreenwoodSchrat, ::Const.EntityType.SchratSmall, ::Const.EntityType.LegendGreenwoodSchratSmall))
		return 3.0;

	if (_entity.getSkills().hasSkill("racial.skeleton"))
		return 0.33;

	if (_entity.getSkills().hasSkill("items.firearms_resistance") || _entity.getSkills().hasSkill("racial.serpent"))
		return 0.66;
	return 1.0;
}

local originalOnApplyFire = ::Const.Tactical.Common.onApplyFire;
::Const.Tactical.Common.onApplyFire = function (_tile, _entity) {
	local __original = _entity.onDamageReceived;

	_entity.onDamageReceived = function ( _attacker, _skill, _hitInfo ) {
		local damage = ::Math.rand(15, 30);
		_hitInfo.DamageRegular = damage * ::Const.Tactical.Common.getFireDamageMultiplier(this);
		_hitInfo.DamageArmor = damage;
		return __original(_attacker, _skill, _hitInfo);
	};

	originalOnApplyFire(_tile, _entity);

	if (::Legends.S.isEntityNullOrDead(_entity))
		return;

	_entity.onDamageReceived = __original;
};


::Const.Tactical.Common.onApplyFireRune <- function (_tile, _entity) {
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
	hitInfo.DamageRegular = damage * ::Const.Tactical.Common.getFireDamageMultiplier(_entity);
	hitInfo.DamageArmor = damage;
	hitInfo.DamageDirect = 0.1;
	hitInfo.BodyPart = ::Const.BodyPart.Body;
	hitInfo.BodyDamageMult = 1.0;
	hitInfo.FatalityChanceMult = 0.0;
	hitInfo.Injuries = ::Const.Injury.Burning;
	hitInfo.IsPlayingArmorSound = false;
	_entity.onDamageReceived(_entity, null, hitInfo);

	if ((!_entity.isAlive() || _entity.isDying()) && !_entity.isPlayerControlled() && (_tile.Properties.Effect == null || _tile.Properties.Effect.IsByPlayer)) {
		::updateAchievement("BurnThemAll", 1, 1);
	}
}
