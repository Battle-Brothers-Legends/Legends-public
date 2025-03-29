this.legend_harvest_tree_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendHarvestTree);
		this.m.Description = "Cut down any tree with a chance of harvesting it.";
		this.m.KilledString = "Chopped up";
		this.m.Icon = "skills/active_25.png";
		this.m.IconDisabled = "skills/active_25_sw.png";
		this.m.Overlay = "active_25";
		this.m.SoundOnUse = [
			"sounds/combat/chop_01.wav",
			"sounds/combat/chop_02.wav",
			"sounds/combat/chop_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
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
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 30;
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
				text = "Chop down any tree. The first strike will leave a pile of sticks. The second strike will clear the sticks. Causes significant wear and tear"
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

		if (!actor.getSkills().hasPerk(::Legends.Perk.LegendSpecialistWoodsman))
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

		if (_targetTile.getEntity().isTree() || _targetTile.getEntity().isSticks())
		{
			return true;
		}

		return false;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local item = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local condition = item.getCondition();
		local damage = this.Math.rand(4,8);
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
		item.setCondition(condition - damage);
	}

});

