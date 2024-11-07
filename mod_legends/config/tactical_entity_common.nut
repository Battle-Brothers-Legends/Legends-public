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
	if (_entity.getSkills().hasSkill("racial.alp") || ::MSU.isKindOf(_entity, "alp_shadow"))
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
		if (!_entity.getSkills().hasSkill("effects.legend_consecrated_effect"))
		{
			local effect = this.new("scripts/skills/effects/legend_consecrated_effect");
			if (_killer != null && _killer.getFaction() == this.Const.Faction.Player)
			{
				effect.setActor(_killer);
			}
			_entity.getSkills().add(this.new("scripts/skills/effects/legend_consecrated_effect"));
		}
		return;
	}
	else if (faction == this.Const.Faction.Player || faction == this.Const.Faction.Civilian || faction == this.Const.Faction.NobleHouse)
	{
		if (!_entity.getSkills().hasSkill("effects.legend_sanctified_effect"))
		{
			_entity.getSkills().add(this.new("scripts/skills/effects/legend_sanctified_effect"));
		}
	}
};	
