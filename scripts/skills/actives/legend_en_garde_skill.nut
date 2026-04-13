this.legend_en_garde_skill <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 75
	},
	function setStunChance( _c )
	{
		this.m.StunChance = _c;
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendEnGarde);
		this.m.Description = "Block your enemy\'s weapons in a way that leaves them open to counter attack. Applies the Vulnerable effect to an enemy, lowering their melee and ranged defenses by 10.";
		this.m.Icon = "skills/en_garde_square.png";
		this.m.IconDisabled = "skills/en_garde_square_bw.png";
		this.m.Overlay = "en_garde_square";
		this.m.SoundOnUse = [
			"sounds/combat/stab_01.wav",
			"sounds/combat/stab_02.wav",
			"sounds/combat/stab_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/weapon_break_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted - 1;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 50;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "On successful Parry, inflicts [color=%negative%]Vulnerable[/color] ([color=%damage%]-10[/color] melee and ranged defense)"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]100%[/color] chance to Parry on a hit thanks to Dagger Mastery. Enemies who are immune to being disarmed cannot be Parried"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=%positive%]" + this.m.StunChance + "%[/color] chance to Parry on a hit due to not having Dagger Mastery. Enemies who are immune to being disarmed cannot be Parried"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInDaggers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectStab);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if ((_user.getCurrentProperties().IsSpecializedInDaggers || this.Math.rand(1, 100) <= this.m.StunChance) && !target.getCurrentProperties().IsImmuneToDisarm && !target.getSkills().hasEffect(::Legends.Effect.LegendParried))
			{
				::Legends.Effects.grant(target, ::Legends.Effect.LegendParried);

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has parried " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}
			}
		}

		return success;
	}

});

