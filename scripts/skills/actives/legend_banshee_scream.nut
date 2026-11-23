this.legend_banshee_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBansheeScream);
		this.m.Description = "";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/banshee_attack_01.wav",
			"sounds/enemies/banshee_attack_02.wav",
			"sounds/enemies/banshee_attack_03.wav",
			"sounds/enemies/banshee_attack_04.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Banshee Scream");
		}

		local target = _targetTile.getEntity();
		local hit = false;
		hit = hit || target.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		hit = hit || target.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		hit = hit || target.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		hit = hit || target.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
		if (!hit)
		{
			return true
		}

		//Do some damage!!

		this.spawnIcon("status_effect_81", target.getTile());
		local dmg = this.Math.max(10, 30 - this.Math.floor(target.getCurrentProperties().getBravery() * 0.25));
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.max(10, 30 - this.Math.floor(target.getCurrentProperties().getBravery() * 0.25));
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		target.onDamageReceived(this.getContainer().getActor(), this, hitInfo);

		::Legends.Effects.grant(target, ::Legends.Effect.Horrified);
		if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " is horrified");
		}

		return true;
	}

});

