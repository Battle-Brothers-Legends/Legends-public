this.legend_manhunter_ranged_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = "agent.legend_manhunter_ranged";
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 1.0;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.0;
		this.m.Properties.IsRangedUnit = true;
		this.m.Properties.TargetPriorityHitchanceMult = 0.6;
		this.m.Properties.TargetPriorityHitpointsMult = 0.2;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.2;
		this.m.Properties.TargetPriorityFleeingMult = 0.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.5;
		this.m.Properties.OverallDefensivenessMult = 1.1;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.OverallHideMult = 0.75;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.35;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.5;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_reload"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_bow"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_handgonne"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_deathblow"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
	}

	function onUpdate()
	{
		this.setRangedAtDayOnly();
		this.setEngageRangeBasedOnWeapon();

		local hasUsableRangedWeaponInBag = false;
		local itemsInBag = this.m.Actor.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);

		if (itemsInBag.len() > 0)
		{
			local rangedWeapons = [];

			foreach( it in itemsInBag )
			{
				if (it.isItemType(this.Const.Items.ItemType.RangedWeapon)
					&& !(this.isThrowingWeapon(it))
					&& (it.getAmmoMax() == 0 || it.getAmmo() > 0))
				{
					rangedWeapons.push(it);
				}
			}

			if (rangedWeapons.len() > 0)
			{
				hasUsableRangedWeaponInBag = true;
			}
		}

		local item = this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (hasUsableRangedWeaponInBag)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.SwitchToRanged] = 1.0;
		}

		if (this.isThrowingWeapon(item) || !hasUsableRangedWeaponInBag)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.SwitchToRanged] = 1.0;
		}
	}

	function isThrowingWeapon(item)
	{
		return (item != null
				&& item.isItemType(this.Const.Items.ItemType.RangedWeapon)
				&& item.getRangeMax() <= 4
				&& item.getID() != "weapon.handgonne"
				&& item.getID() != "weapon.named_handgonne");
	}

});

