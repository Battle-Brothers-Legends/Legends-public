this.legend_magic_stun_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMagicStun);
		this.m.Description = "Unleash a brilliant flash of white light aimed directly at the eyes of your target in an attempt to blind and incapacitate.";
		this.m.KilledString = "Stunned";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/cudgel", 3);
		this.m.SoundOnHit = ::Legends.S.setSounds("sounds/combat/cudgel_hit", 4);
		this.m.SoundVolume = 1.25;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.DirectDamageMult = 0;
		this.m.IsUsingHitchance = false;
	}

	function getHitchance( _targetEntity ){
		return 100;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local fatigueDamage = (p.FatigueDealtPerHitMult + 3) * this.Const.Combat.FatigueReceivedPerHit;
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts [color=%damage%]" + fatigueDamage + "[/color] extra fatigue"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to stun on a hit"
			}
		];
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);		

		if (!::Legends.S.isEntityNullOrDead(target)) {
			local p = _user.getCurrentProperties();
        	local fatigueDamage = (p.FatigueDealtPerHitMult + 3.0) * this.Const.Combat.FatigueReceivedPerHit;
        	target.setFatigue(this.Math.min(target.getFatigueMax(), target.getFatigue() + fatigueDamage));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + " struck a blow that leaves " + this.Const.UI.getColorizedEntityName(target) + " stunned.");
			}
			
			::Legends.Effects.grant(target, ::Legends.Effect.Stunned);
		}

	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.FatigueDealtPerHitMult += 3.0;
		}
	}

});
