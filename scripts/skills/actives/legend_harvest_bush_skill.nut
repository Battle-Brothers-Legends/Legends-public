this.legend_harvest_bush_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHarvestBush);
		this.m.Description = "Cut down any bush with a chance of harvesting it.";
		this.m.KilledString = "Chopped up";
		this.m.Icon = "skills/active_01.png";
		this.m.IconDisabled = "skills/active_01_sw.png";
		this.m.Overlay = "active_01";
		this.m.SoundOnUse = [
			"sounds/combat/slash_01.wav",
			"sounds/combat/slash_02.wav",
			"sounds/combat/slash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/slash_hit_01.wav",
			"sounds/combat/slash_hit_02.wav",
			"sounds/combat/slash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Chop down any bush with a 50% percent chance to harvest fruit"
			}
		]);
		return ret;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return true;
		}

		if (!actor.getSkills().hasPerk(::Legends.Perk.LegendSpecialistHerbalist))
		{
			return true;
		}

		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (_targetTile.getEntity() == null)
		{
			return false;
		}

		if (_targetTile.getEntity().isBush())
		{
			return true;
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile)
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local item = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local condition = item.getCondition();
		local damage = this.Math.rand(4,8);
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		return this.attackEntity(_user, _targetTile.getEntity());
		item.setCondition(condition - damage);
	}

});

