this.legend_haftstrike <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsUsed = 0	
	},
	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHaftstrike);
		this.m.Description = "A swift strike with the weapon\'s haft. Not particularly effective, but offers versatility on heavy weapons. Becomes easier to use after successful hits from other skills in the same turn.";
		this.m.KilledString = "Bashed";
		this.m.Icon = "skills/active_haftstrike.png";
		this.m.IconDisabled = "skills/active_haftstrike_bw.png";
		this.m.Overlay = "active_haftstrike";
		this.m.SoundOnUse = [
			"sounds/combat/thrust_01.wav",
			"sounds/combat/thrust_02.wav",
			"sounds/combat/thrust_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/thrust_hit_01.wav",
			"sounds/combat/thrust_hit_02.wav",
			"sounds/combat/thrust_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntAndPiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntAndPiercingHead;
		this.m.HitChanceBonus = 0;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 12;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip() {
		return this.getDefaultTooltip();
	}

	function onTargetHit (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill != this)
			this.m.SkillsUsed += 1;
	}

	function onTurnStart() {
		this.m.SkillsUsed = 0;
	}

	function onCombatStarted() {
		this.m.SkillsUsed = 0;
	}

	function onCombatFinished() {
		this.m.SkillsUsed = 0;
	}

	function onAfterUpdate( _properties ) {
		local cost = this.m.ActionPointCost - this.m.SkillsUsed;
		this.m.ActionPointCost = this.Math.max(cost, 0);
	}

	function onUse( _user, _targetTile ) {
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		this.m.SkillsUsed = 0;
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		if (_skill == this)
			_properties.DamageTotalMult *= 0.4;
	}
});

