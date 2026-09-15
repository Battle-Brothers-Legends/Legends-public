::mods_hookExactClass("contracts/contracts/tutorial_contract", function(o)
{
	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "StartingBattle")
			{
				s.onAIDeployment = function ()
				{
					local e;
					::Const.Movement.AnnounceDiscoveredEntities = false;
					e = ::Tactical.spawnEntity("scripts/entity/tactical/humans/bounty_hunter", 16, 16 - 16 / 2);
					e.setFaction(::Const.Faction.PlayerAnimals);
					e.setName("One-Eye");
					e.getSprite("socket").setBrush("bust_base_player");
					e.assignRandomEquipment();
					::Legends.Perks.remove(e, ::Legends.Perk.Overwhelm);
					::Legends.Perks.remove(e, ::Legends.Perk.Nimble);
					::Legends.Perks.remove(e, ::Legends.Perk.Dodge);
					e.getItems().getItemAtSlot(::Const.ItemSlot.Body).setArmor(0);

					if (e.getItems().getItemAtSlot(::Const.ItemSlot.Head) != null)
					{
						e.getItems().getItemAtSlot(::Const.ItemSlot.Head).removeSelf();
					}

					if (e.getItems().getItemAtSlot(::Const.ItemSlot.Offhand) != null)
					{
						e.getItems().getItemAtSlot(::Const.ItemSlot.Offhand).removeSelf();
					}

					e.getBaseProperties().Hitpoints = 5;
					e.getBaseProperties().MeleeSkill = -200;
					e.getBaseProperties().RangedSkill = 0;
					e.getBaseProperties().MeleeDefense = -200;
					e.getBaseProperties().Initiative = 200;
					e.getSkills().update();
					e.setHitpoints(5);
					e = ::Tactical.spawnEntity("scripts/entity/tactical/humans/bounty_hunter", 15, 18 - 15 / 2);
					e.setFaction(::Const.Faction.PlayerAnimals);
					e.setName("Captain Bernhard");
					e.getSprite("socket").setBrush("bust_base_player");
					::Legends.Perks.remove(e, ::Legends.Perk.Overwhelm);
					::Legends.Perks.remove(e, ::Legends.Perk.Nimble);
					::Legends.Perks.remove(e, ::Legends.Perk.Dodge);
					local armor = ::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.mail_hauberk, 32],
					]);
					armor.setArmor(0);
					e.getItems().equip(armor);
					e.getItems().equip(this.new("scripts/items/weapons/arming_sword"));
					e.getBaseProperties().Hitpoints = 9;
					e.getBaseProperties().MeleeSkill = -200;
					e.getBaseProperties().RangedSkill = 0;
					e.getBaseProperties().MeleeDefense = -200;
					e.getBaseProperties().DamageTotalMult = 0.100000001;
					e.getBaseProperties().Initiative = 250;
					e.getSkills().update();
					e.setHitpoints(5);
					e = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug", 18, 17 - 18 / 2);
					e.setFaction(::Const.Faction.Enemy);
					e.getAIAgent().getProperties().OverallDefensivenessMult = 0.0;
					e.getAIAgent().getProperties().BehaviorMult[::Const.AI.Behavior.ID.Retreat] = 0.0;
					e.assignRandomEquipment();
					e.getBaseProperties().Initiative = 300;
					::Legends.Perks.remove(e, ::Legends.Perk.Overwhelm);
					::Legends.Perks.remove(e, ::Legends.Perk.Nimble);
					::Legends.Perks.remove(e, ::Legends.Perk.Dodge);
					e.getSkills().update();
					e = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_thug", 17, 18 - 17 / 2);
					e.setFaction(::Const.Faction.Enemy);
					e.getAIAgent().getProperties().OverallDefensivenessMult = 0.0;
					e.getAIAgent().getProperties().BehaviorMult[::Const.AI.Behavior.ID.Retreat] = 0.0;
					e.assignRandomEquipment();
					e.getBaseProperties().Initiative = 200;
					::Legends.Perks.remove(e, ::Legends.Perk.Overwhelm);
					::Legends.Perks.remove(e, ::Legends.Perk.Nimble);
					::Legends.Perks.remove(e, ::Legends.Perk.Dodge);
					e.getSkills().update();
					e = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_bandit_raider_low", 19, 17 - 19 / 2);
					e.setFaction(::Const.Faction.Enemy);
					e.setName(this.Flags.get("BossName"));
					e.getAIAgent().getProperties().OverallDefensivenessMult = 0.0;
					e.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat_always"));
					local items = e.getItems();
					items.equip(::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.patched_mail_shirt],
					]));
					items.equip(this.new("scripts/items/weapons/hunting_bow"));
					this.Flags.set("BossHead", e.getSprite("head").getBrush().Name);
					this.Flags.set("BossBeard", e.getSprite("beard").HasBrush ? e.getSprite("beard").getBrush().Name : "");
					this.Flags.set("BossBeardTop", e.getSprite("beard_top").HasBrush ? e.getSprite("beard_top").getBrush().Name : "");
					this.Flags.set("BossHair", e.getSprite("hair").HasBrush ? e.getSprite("hair").getBrush().Name : "");
					e.getBaseProperties().Hitpoints = 300;
					::Legends.Perks.remove(e, ::Legends.Perk.Overwhelm);
					::Legends.Perks.remove(e, ::Legends.Perk.Nimble);
					::Legends.Perks.remove(e, ::Legends.Perk.Dodge);
					e.getSkills().update();
					e.setHitpoints(180);
					e.setMoraleState(::Const.MoraleState.Wavering);
					::Const.Movement.AnnounceDiscoveredEntities = true;
				}
			}
			if (s.ID == "Finale")
			{
				s.onDeployment = function ()
				{
					::Tactical.getTileSquare(21, 17).removeObject();
					local e = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/bandit_raider_low", 21, 17 - 21 / 2);
					e.setFaction(::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getID());
					e.setName(this.Flags.get("BossName"));
					e.m.IsGeneratingKillName = false;
					e.getAIAgent().getProperties().BehaviorMult[::Const.AI.Behavior.ID.Retreat] = 0.0;
					e.getFlags().add("IsFinalBoss", true);
					local items = e.getItems();
					items.equip(::Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.patched_mail_shirt],
					]));
					items.equip(this.new("scripts/items/weapons/falchion"));
					local shield = this.new("scripts/items/shields/wooden_shield");
					shield.setVariant(4);
					items.equip(shield);
					e.getSprite("head").setBrush(this.Flags.get("BossHead"));
					e.getSprite("beard").setBrush(this.Flags.get("BossBeard"));
					e.getSprite("beard_top").setBrush(this.Flags.get("BossBeardTop"));
					e.getSprite("hair").setBrush(this.Flags.get("BossHair"));
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
			if (s.ID == "Finale")
			{

			}
		}
	}
});
