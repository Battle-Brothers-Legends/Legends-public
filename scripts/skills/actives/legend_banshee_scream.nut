this.legend_banshee_scream <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendBansheeScream);
		this.m.Description = "";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/banshee_attack", 4);
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
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
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Banshee Scream");
		}

		local target = _targetTile.getEntity();
		local hit = false;
		hit = hit || target.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		hit = hit || target.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		hit = hit || target.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		hit = hit || target.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		if (!hit) {
			return true;
		}

		//Do some damage!!

		this.spawnIcon("status_effect_81", target.getTile());
		local dmg = ::Math.max(10, 30 - ::Math.floor(target.getCurrentProperties().getBravery() * 0.25));
		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = ::Math.max(10, 30 - ::Math.floor(target.getCurrentProperties().getBravery() * 0.25));
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		target.onDamageReceived(this.getContainer().getActor(), this, hitInfo);

		::Legends.Effects.grant(target, ::Legends.Effect.Horrified);
		if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " is horrified");
		}

		return true;
	}

});

