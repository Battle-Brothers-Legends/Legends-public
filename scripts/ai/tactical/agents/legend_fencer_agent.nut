this.legend_fencer_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.MilitaryMelee;
		this.m.Properties.TargetPriorityHitchanceMult = 0.4;
		this.m.Properties.TargetPriorityHitpointsMult = 0.2;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.4;
		this.m.Properties.TargetPriorityFleeingMult = 0.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 0.9;
		this.m.Properties.OverallFormationMult = 0.1;
		this.m.Properties.EngageFlankingMult = 5.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 2.5;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 2.0;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wake_up_ally"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_indomitable"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_splitshield"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_crush_armor"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_lash"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_shieldwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_riposte"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
	}

	function onUpdate()
	{
		this.setEngageRangeBasedOnWeapon();
		local item = this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.isAoE())
		{
			this.m.Properties.EngageTargetMultipleOpponentsMult = 0.75;
		}
		else
		{
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
		}

		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Protect] = 0.0;

		if (this.m.KnownAllies.len() >= 10 && this.getActor().getCurrentProperties().TargetAttractionMult <= 1.0)
		{
			item = this.m.Actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
			{
				local myTile = this.getActor().getTile();
				local priorityAlliesInRange = 0;
				local protectors = 0;

				foreach( a in this.m.KnownAllies )
				{
					if (a.getID() == this.getActor().getID())
					{
						continue;
					}

					if (a.getCurrentProperties().TargetAttractionMult <= 1.0 && a.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Protect] >= 1.0)
					{
						protectors = ++protectors;
					}
					else if (a.getCurrentProperties().TargetAttractionMult > 1.0)
					{
						local d = a.getTile().getDistanceTo(myTile);

						if (d <= 2)
						{
							priorityAlliesInRange = ++priorityAlliesInRange;
						}
					}
				}

				if (priorityAlliesInRange > 0 && protectors <= this.m.KnownAllies.len() / 18)
				{
					this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Protect] = 1.0;
				}
			}
		}
	}

});

