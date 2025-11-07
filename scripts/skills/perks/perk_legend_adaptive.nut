this.perk_legend_adaptive <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAdaptive);
	}

	function onAdded()
	{
		if (!this.m.IsNew || this.m.IsForPerkTooltip) return; // m.IsForPerkTooltip will be true if the instance of this perk is just a dummy being used to generate unactivated perk tooltip hints

		this.m.IsNew = false;
		local possibleTrees = this.getPossibleTrees();
		this.chooseAndAddTree(possibleTrees);

	}

	// When the Perk is yet to be activated, show in the Tooltip which Perk Group will be awarded
	function getUnactivatedPerkTooltipHints()
	{
		local possibleTrees = this.getPossibleTrees();
		local descText = "";
		local possibleTreesText = "";

		if (typeof possibleTrees != "array" || possibleTrees.len()<=1)
		{
			local name = typeof possibleTrees != "array" ? possibleTrees.Name : possibleTrees[0].Name;
			descText = "Activating this Perk will grant the following Perk Group:\n";
			possibleTreesText = "[color=#0b0084]" + name + "[/color]";
		}
		else
		{
			descText = "Activating this Perk will randomly grant one of the following Perk Groups:\n";
			possibleTreesText = "[color=#0b0084]";
			for (local i = 0; i < possibleTrees.len() - 2; i++)
			{
				 possibleTreesText += possibleTrees[i].Name + ", ";
			}
			possibleTreesText += possibleTrees[possibleTrees.len()-2].Name + ", or ";
			possibleTreesText += possibleTrees[possibleTrees.len()-1].Name + "[/color]";
		}

		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/tooltips/positive.png",
				text = descText + possibleTreesText
			}
		];

		return ret;
	}

	// Return either a single Tree or an array of Trees that may be added by this perk
	// Order of priority: from mainhand item, from offhand item, random
	function getPossibleTrees()
	{
		local item = null;
		local itemtype = null;
		local newTree = null; // newTree may be a single Tree or an array of Trees
		local actor = this.getContainer().getActor();


		// First, try to give a new Tree based on the equipped mainhand item
		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
		{
			item = actor.getMainhandItem();
			if (item.isItemType(this.Const.Items.ItemType.Weapon))
				newTree = this.getWeaponPerkTree(item);

			newTree = this.getOnlyNonExistingTrees(newTree); // filter out Trees this character already has
			if (newTree != null && newTree.len() > 0)
				return newTree;
		}
		// Next, try to give a new Tree based on the equipped offhand item
		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
		{
			item = actor.getOffhandItem();
			if (item.isItemType(this.Const.Items.ItemType.Shield))
				newTree = this.getShieldPerkTree(item);
			else
				newTree = this.getMiscPerkTree(item);

			newTree = this.getOnlyNonExistingTrees(newTree); // filter out Trees this character already has
			if (newTree != null && newTree.len() > 0)
				return newTree;
		}

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null && actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			// Attempt to give Unarmed if no weapons are equipped
			newTree = this.getOnlyNonExistingTrees(this.Const.Perks.FistsTree);
			if (newTree != null && newTree.len() > 0)
				return newTree;
		}

		newTree = getArmorPerkTree();
		if (newTree != null && newTree.len() > 0)
			return newTree;

		// If none of the equipped items (or unarmed or armors) granted any Trees, then consider the following Trees
		if (newTree == null || newTree.len() < 1)
		{
			newTree = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.TrainedTree
			];
		}

		newTree = this.getOnlyNonExistingTrees(newTree); // filter out Trees this character already has

		// Give PhilosophyMagicTree if there are still no possible Trees
		if (newTree == null || newTree.len() < 1)
			newTree = this.Const.Perks.PhilosophyMagicTree.Tree;

		return newTree;
	}

	// Helper function that returns only Trees that this character does not already have
	// _newTree: either a single Tree or an array of Trees
	function getOnlyNonExistingTrees( _newTree )
	{
		if ( _newTree == null || (typeof _newTree == "array" && _newTree.len()<1))
			return [];

		local actor = this.getContainer().getActor();

		// If there's only one possible Tree then just check that
		if ( typeof _newTree != "array")
			return actor.getBackground().hasPerkGroup(_newTree) ? null : _newTree;

		// Otherwise, remove every Tree that this character already has from the array
		local ret = [];

		foreach(tree in _newTree)
		{
			if(!actor.getBackground().hasPerkGroup(tree))
			{
				ret.append(tree);
			}
		}

		return ret
	}

	// Give the character the new Tree.
	// If _newTree is an array, randomly choose a Tree from the array
	// _newTree: either a single Tree or an array of Trees
	function chooseAndAddTree( _newTree )
	{
		local actor = this.getContainer().getActor();

		// If there's only possible Tree then just add it
		if (typeof _newTree != "array")
		{
			actor.getBackground().addPerkGroup(_newTree.Tree)
		}
		// Otherwise, randomly select one from the array
		else
		{
			if(_newTree.len() > 0)
			{
				local randomIndex = this.Math.rand(0, _newTree.len()-1);
				local randomTree = _newTree[randomIndex];
				actor.getBackground().addPerkGroup(randomTree.Tree);
			}
			else
			{
				this.logWarning("Adaptive Perk had no Tree to add");
			}
		}
	}

	function getShieldPerkTree( _item )
	{
		return this.Const.Perks.ShieldTree;
	}

	function getMiscPerkTree(_item)
	{
		switch(_item.getID())
		{
			//Faith
			case "weapon.holy_water":
				return this.Const.Perks.FaithClassTree;

			//Juggler
			case "weapon.daze_bomb":
				return this.Const.Perks.JugglerClassTree;

			//Repair
			case "weapon.fire_bomb":
				return this.Const.Perks.RepairClassTree;

			//Net
			case "tool.throwing_net":
				return this.Const.Perks.BeastClassTree;

			//Healer
			case "weapon.acid_flask":
				return this.Const.Perks.HealerClassTree;
		}

		return null;
	}

	function getWeaponPerkTree( _item )
	{
		switch(true) {
		//Banner
			case _item.getID() == "weapon.player_banner":
				return this.Const.Perks.InspirationalTree;
	    //Shovel
	        case _item.getID() == "weapon.legend_shovel" || _item.getID() == "weapon.legend_named_shovel":
	            return this.Const.Perks.ShovelClassTree;

	    //Sickle
	        case _item.getID() == "weapon.sickle" || _item.getID() == "weapon.goblin_notched_blade" || _item.getID() == "weapon.legend_named_sickle":
	            return this.Const.Perks.SickleClassTree;

	    //Wood Axe
	        case _item.getID() == "weapon.woodcutters_axe" || _item.getID() == "weapon.legend_saw":
	            return this.Const.Perks.WoodaxeClassTree;

	    //Blacksmith
	        case _item.getID() == "weapon.legend_hammer" || _item.getID() == "weapon.legend_named_blacksmith_hammer":
	            return this.Const.Perks.HammerClassTree;

	    //Pickaxe
	        case _item.getID() == "weapon.pickaxe" || _item.getID() == "weapon.heavy_mining_pick":
	            return this.Const.Perks.PickaxeClassTree;

	    //Butcher
	        case _item.getID() == "weapon.butchers_cleaver" || _item.getID() == "weapon.legend_named_butchers_cleaver":
	            return this.Const.Perks.ButcherClassTree;

	    //Ninetails
	        case _item.getID() == "weapon.legend_cat_o_nine_tails":
	            return this.Const.Perks.NinetailsClassTree;

	    //Knife
	        case _item.getID() == "weapon.knife" || _item.getID() == "weapon.legend_shiv":
	            return this.Const.Perks.KnifeClassTree;

	    //Inventor
	        case _item.isWeaponType(this.Const.Items.WeaponType.Firearm):
	            return this.Const.Perks.InventorClassTree;

	    //Bodyguard
	        case _item.getID() == "weapon.legend_longsword" || _item.getID() == "weapon.longsword":
	            return this.Const.Perks.LongswordClassTree;

	    //Slings
	        case _item.getID() == "weapon.legend_dilapitated_sling":
	            return this.Const.Perks.SlingClassTree;

	    //Staves
	        case _item.getID() == "weapon.legend_staff":
	            return this.Const.Perks.StaffClassTree;

	    //Inquisition
	        case _item.getID() == "weapon.legend_wooden_stake":
	            return this.Const.Perks.InquisitionClassTree;

	    //Club
	        case _item.getID() == "weapon.wooden_stick":
	            return this.Const.Perks.ClubClassTree;

	    //Pitchfork
	        case _item.isItemType(this.Const.Items.ItemType.Pitchfork):
	            return this.Const.Perks.PitchforkClassTree;

	    //Shortbow
	        case _item.isItemType(this.Const.Items.ItemType.Shortbow):
	            return this.Const.Perks.ShortbowClassTree;

	    //Militia
	        case _item.getID() == "weapon.militia_spear" || _item.getID() == "weapon.legend_wooden_spear" || _item.getID() == "weapon.ancient_spear":
	            return this.Const.Perks.MilitiaClassTree;
		// WeaponTypes
			default:
				local ret = []; // Push all applicable WeaponTypes into array (supports Hybrid weapons)
				local weaponToPerkMap = {
					Axe = this.Const.Perks.AxeTree,
					Bow = this.Const.Perks.BowTree,
					Cleaver = this.Const.Perks.CleaverTree,
					Crossbow = this.Const.Perks.CrossbowTree,
					Dagger = this.Const.Perks.DaggerTree,
					Firearm = this.Const.Perks.CrossbowTree,
					Flail = this.Const.Perks.FlailTree,
					Hammer = this.Const.Perks.HammerTree,
					Mace = this.Const.Perks.MaceTree,
					Polearm = this.Const.Perks.PolearmTree,
					Sling = this.Const.Perks.SlingTree,
					Spear = this.Const.Perks.SpearTree,
					Sword = this.Const.Perks.SwordTree,
					Throwing = this.Const.Perks.ThrowingTree
				}
				foreach (weapon, tree in weaponToPerkMap)
				{
					if (_item.isWeaponType(this.Const.Items.WeaponType[weapon])) ret.push(tree);
				}
				return ret;
		}

		return null;
	}

	function getArmorPerkTree()
	{
		local armor_weight = 0;
		local newTree;
		local actor = this.getContainer().getActor();
		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
		{
			armor_weight += actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head).getStaminaModifier()
		}

		if (actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
		{
			armor_weight += actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getStaminaModifier()
		}

		if (armor_weight == 0)
		{
			newTree = this.getOnlyNonExistingTrees(this.Const.Perks.ClothArmorTree);
			if (newTree != null && newTree.len()>0) return newTree;
		}

		if (armor_weight >= -15 && armor_weight <= -1)
		{
			// Attempt to give light armor tree if in range or naked
			newTree = this.getOnlyNonExistingTrees(this.Const.Perks.LightArmorTree);
			if (newTree != null && newTree.len()>0) return newTree;
		}

		if (armor_weight >= -35 && armor_weight < -15)
		{
			// Attempt to give medium armor tree
			newTree = this.getOnlyNonExistingTrees(this.Const.Perks.MediumArmorTree);
			if (newTree != null && newTree.len()>0) return newTree;
		}

		if (armor_weight < -35)
		{
			// Attempt to give heavy armor tree
			newTree = this.getOnlyNonExistingTrees(this.Const.Perks.HeavyArmorTree);
			if (newTree != null && newTree.len()>0) return newTree;
		}
	}

	function onUpdateLevel()
	{
		local actor = this.getContainer().getActor();
		if (actor.m.Level == 15)
		{
			actor.m.PerkPoints += 1;
		}
	}

});
