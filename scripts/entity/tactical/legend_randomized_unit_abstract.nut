this.legend_randomized_unit_abstract <- this.inherit("scripts/entity/tactical/human", {
	// Most of the m table is filled out inthe config file z_randomized_perk_tiers
	// Outfits  		| [chance to roll, outfit] | outfits are defined in the outfits.nut config file
	// ClassPerkList  	| Virtually always empty, this is for magic
	// DefensePerkList 	| Defensive perk list | e.g. ClothArmorTree
	// TraitsPerkList  	| Traits lists, generally very filled out | e.g. FitTree
	// WeaponsAndTrees 	| [Weapon Script, Chance to roll weapon perk, chance to roll weapon class perk]
	// Shields          | Chance to roll a shield, assuming no 2hander and assuming no duelist
	// GuaranteedPerks 	| Guaranteed perks for units
	// LegendaryPerks  	| Guaranteed perks on legendary difficulty
	// LevelRange  		| Possible level range
	// EnemyLevel  		| "Level" of the unit, unrelated to the PerkPower, but marks how far up the tree the unit can purchase | this is SET during creation
	// PerkPower  		| How many perks the unit gets to purchase with
	m = {
		Outfits = [],
		ClassPerkList = [],
		DefensePerkList = [],
		TraitsPerkList = [],
		WeaponsAndTrees = [],
		Shields = [],
		GuaranteedPerks = [],
		LegendaryPerks = [],
		LegendaryTraits = [],
		LevelRange = [1, 1],
		EnemyLevel = 1,
		PerkPower = this.Const.PerkPurchasePower.Low
	},

	//TODO:
	// 1. Add in chances for shields alongside the weapon tree?
	// 		Check if the main hand is null after selecting, allows us to purchase and use nets/bucklers/any shield/offhand dagger and then another weapon?
	//		Would also adding in a way to check if the weapon we're trying to add is 2h vs 1h, and purchasing only a 1h
	// 2. Debate making higher tier perks cost more, alongside adding more of a curve (mostly linear currently) for PerkPower growth
	// 		Higher tier units would get much higher power to purchase with, and would spend much more
	// 		We already limit how high units can purchase however, so this might not be necessary
	//

	function onInit()
	{
		this.human.onInit();
		if (::Math.rand(0, 3) == 0) { this.setFemale(); }
		else { this.setMale(); }
		this.setAppearance();
	}


	// Sets the actual m-tables keys to the values, reasoning is listed directly below
	function writeTablesFromParam( _table )
	{
		foreach(k, v in _table)
		{
			this.m[k] = v;
		}
	}

	// - writeTablesFromParam -
	// As an "easy way out" in case a unit does not have its RandomizedCharacterInfo set, we would settle with full default values
	// Because we set the parameters in our m-table to default first, we don't require the developer to set every single variable
	// Admittedly this isn't the most efficient, but it's not breaking the bank with computation time
	// We still log a warning if the type doesn't exist entirely, given that it should, but it allows us to miss things in the config tables in spots we might only care about default values
	// I'm not entirely certain if I need to clone these, but to be safe I do

	// We set the EnemyLevel which sets the experience amount here
	// Non-legendary units currently get a blanket 1 fewer perk
	function create()
	{
		this.human.create();

		local writeTable = clone this.Const.RandomizedCharacterInfo["Default"];
		this.writeTablesFromParam(writeTable);

		if (this.m.Type in this.Const.RandomizedCharacterInfo)
		{
			writeTable = clone this.Const.RandomizedCharacterInfo[this.m.Type];
			this.writeTablesFromParam(writeTable);
		}
		else
		{
			this.logWarning("Entity type didnt exist: " + this.m.Type);
		}

		this.m.EnemyLevel = this.Math.rand( this.m.LevelRange[0], this.m.LevelRange[1] );
		this.m.XP = this.m.EnemyLevel * 35;
		if (!("Assets" in this.World) || (this.World.Assets != null && this.World.Assets.getCombatDifficulty() != this.Const.Difficulty.Legendary))
		{
			this.m.PerkPower -= 1;
		}
	}


	// Modifies the actual stats when possible (not all trees have an attributes tag, but weapon trees and trait trees do)
	function modifyAttributes( _attributes )
	{
		local b = this.m.BaseProperties;
		b.Hitpoints += this.Math.rand(_attributes.Hitpoints[0], _attributes.Hitpoints[1]);
		b.Bravery += this.Math.rand(_attributes.Bravery[0], _attributes.Bravery[1]);
		b.Stamina += this.Math.rand(_attributes.Stamina[0], _attributes.Stamina[1]);
		b.MeleeSkill += this.Math.rand(_attributes.MeleeSkill[0], _attributes.MeleeSkill[1]);
		b.RangedSkill += this.Math.rand(_attributes.RangedSkill[0], _attributes.RangedSkill[1]);
		b.MeleeDefense += this.Math.rand(_attributes.MeleeDefense[0], _attributes.MeleeDefense[1]);
		b.RangedDefense += this.Math.rand(_attributes.RangedDefense[0], _attributes.RangedDefense[1]);
		b.Initiative += this.Math.rand(_attributes.Initiative[0], _attributes.Initiative[1]);
	}

	// _purchaseLimit	| How many perks a unit can actually purchase, the total cost it could purchase
	// _tree			| This is the actual tree to purchase from, we pipe in a tree from any of this.Const.[NameOfATree].Tree
	// _cap 			| The actual cap on the perk tree, this is changed by the units level. A level 1 unit could buy from the first row, a level 10 unit could buy from the max row
	// 							there are up to 7 rows in any given tree, or 0-6, so we cap it at 6
	function pickPerkFromTree( _purchaseLimit, _tree, _cap = 6)
	{
		// Sets the cap to either 6 (maximum of the player tree) | OR | sets the cap to the tree's length, assuming it's missing the last row (some trees randomly are)
		if ( _cap > 6 ) { _cap = 6; }
		if ( _cap > _tree.len() ) { _cap = _tree.len() - 1; }

		// We purchase as much as we can from any given tree that got piped in, i.e. we go deeper into a tree of perks than we do wide
		// We check the perkdef's numeric id, and ask the PerkDefObject tree (array?) to give us the actual perk's tree
		// We then create the script and add it, assuming the perk isn't already there
		// Possible options would be to set this.m.PerkPower-- to this.m.PerkPower -= i, thus making the cost for later tier perks higher (and similarly updating _purchaseLimit--)
		for (local i = 0; i <= _cap; i++)
		{
			local row = _tree[i];
			if ( row.len() != 0 && _purchaseLimit >= row.len() && this.m.PerkPower >= row.len() ) {
				foreach (perkDefNum in row) //Purchases every perk in the row, if there are multiple
				{
					local fullDef = clone this.Const.Perks.PerkDefObjects[perkDefNum];
					local toAdd = this.new(fullDef.Script);
					if (!this.m.Skills.hasSkill(toAdd.getID()))
					{
						this.m.Skills.add(toAdd);
						_purchaseLimit--;
						this.m.PerkPower--;
					}
				}
			}
		}
	}

	// _purchaseLimit, _table, _cap see ::pickPerkFromTree()
	// _malus | decides if we attatch the RandomizedMalus assuming there is no attributes modifier
	// 				this is currently only true for WeaponClassTrees, where there is a flat malus attatched to the units stats to offset the free stats from the perk
	// helper function to check what trees want to modify the unit attributes, and selects perks from any sent in
	function pickPerk(_purchaseLimit, _table, _cap = 6, _malus = false)
	{
		if ("Attributes" in _table)
		{
			local attr = _table["Attributes"];
			this.modifyAttributes(attr);
		}
		else if (_malus)
		{
			this.modifyAttributes(this.Const.RandomizedMalus);
		}

		local tabl = _table["Tree"];
		this.pickPerkFromTree(_purchaseLimit, tabl, _cap);
	}

	// Adds all guaranteed perks
	// Adds all legendary guaranteed perks
	// Selects a random defense tree + runs the perk buying functions on that				| these do not have attributes attatched to their tree
	// Selects random traits lists + runs the buying functions until we run out of power 	| these do have attributes
	function assignPerks()
	{

		foreach (perk in this.m.GuaranteedPerks)
			::Legends.Perks.grant(this, perk);

		if(::Legends.isLegendaryDifficulty())
		{
			foreach (perk in this.m.LegendaryPerks)
				::Legends.Perks.grant(this, perk);
			foreach (trait in this.m.LegendaryTraits)
				::Legends.Traits.grant(this, trait);
		}

		local idx = this.Math.rand(0, this.m.DefensePerkList.len() - 1);
		this.pickPerk(this.m.PerkPower, this.m.DefensePerkList[idx], this.m.EnemyLevel - 1 );

		while (this.m.PerkPower > 0 && this.m.TraitsPerkList.len() != 0)
		{
			local idx = this.Math.rand(0, this.m.TraitsPerkList.len() - 1);
			local selectedTree = this.m.TraitsPerkList.remove(idx);
			this.pickPerk(this.m.PerkPower, selectedTree, this.m.EnemyLevel - 1 );
		}
	}

	// Picks and equips our units outfit
	function assignOutfit()
	{
		foreach( item in this.Const.World.Common.pickOutfit(this.m.Outfits) )
		{
			this.m.Items.equip(item);
		}
	}

	// Picks a random weapon from our tree
	// Equips weapon + gets what got equipped, for selecting the weapon's related perk trees
	// The WeaponsAndTrees array contents are listed above, here we roll on those chances and apply applicable maluses, attributes, and perktrees
	// Adds everything from (technically our index 3) guaranteed Legendary Perks if the enemy rolls that weapon (this should be a table at this point perhaps)
	function assignWeapon()
	{
		local selection = this.Const.GetWeaponAndTree(this.m.WeaponsAndTrees);
		local weaponScriptAndChances = selection[0];
		this.m.Items.equip( this.new( "scripts/items/weapons/" + weaponScriptAndChances[0] ) );
		local weapon = this.getMainhandItem();
		local weaponID = this.getMainhandItem().getID();

		if (selection.len() > 1 && ::Legends.isLegendaryDifficulty()) {
			foreach (perk in selection[1])
				::Legends.Perks.grant(this, perk);
		}

		local weaponPerkTree = this.Const.GetWeaponPerkTree(weapon);
		weaponPerkTree = weaponPerkTree[this.Math.rand(0, weaponPerkTree.len() - 1)];
		if (weaponPerkTree != null && weaponScriptAndChances.len() >= 2 && this.Math.rand(1, 100) <= weaponScriptAndChances[1])
		{
			this.pickPerk( this.m.PerkPower,  weaponPerkTree, this.m.EnemyLevel - 1);
		}

		local weaponClassTree = this.Const.GetWeaponClassTree(weapon);
		if (weaponClassTree != null && weaponScriptAndChances.len() >= 3 && this.Math.rand(1, 100) <= weaponScriptAndChances[2])
		{
			this.pickPerk( this.m.PerkPower,  weaponClassTree, this.m.EnemyLevel - 1, true);
		}
	}

	function assignShield()
	{
		if (this.m.Shields.len() == 0) { return; }
		if (this.getMainhandItem().isItemType(this.Const.Items.ItemType.TwoHanded)) { return; }

		local candidates = [];
		local totalWeight = 0;

		foreach (shield in this.m.Shields)
		{
			if (shield[0] == 0)
			{
				continue;
			}
			candidates.push(shield);
			totalWeight += shield[0];
		}

		local r = this.Math.rand(0, totalWeight);
		foreach (shield in candidates)
		{
			r = r - shield[0];
			if (r > 0)
			{
				continue;
			}
			if (shield[1] == "") //Randomly chose "no shield"
			{
				return;
			}
			this.m.Items.equip(this.new("scripts/items/shields/" + shield[1]));
			return;
		}

	}

	// Assigns ammo if we have a bow or xbow or gun
	// Will not give any ammo if it's not a ranged weapon (this is primarily for the spear-gun thing that's a firearm but not a rangedweapon, but helps for modded items maybe)
	function assignAmmo()
	{
		local weapon = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (weapon == null) { return; }
		if ( !(weapon.isItemType(this.Const.Items.ItemType.RangedWeapon)) ) { return; }


		if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
		{
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (weapon.isWeaponType(this.Const.Items.WeaponType.Firearm))
		{
			this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));
		}
	}

	// Function generally doesn't need to be overridden in child files
	// Only times you'll need to override would be to do things like a weapon-specific perk, i.e. peasants | OR | when adding items to bag/offhand
	// assignWeapon() also assigns weapon-related perks, these are purchased first before any other perks
	// assignShield() gives us a shield based on the array (assuming it rolls it), and won't try if we have duelist or a 2hander
	// assignOutfit() does not assign any armor related perks
	// assignPerks() finishes spending the units PerkPower
	function assignRandomEquipment()
	{
		this.assignWeapon();
		this.assignOutfit();
		this.assignPerks();
		this.assignShield();
		this.assignAmmo();
	}


	// Can override setfemale/male if we want southern units etc. Enemy defaults are setMale anyways
	// Defaulting to 1 in 4 chance of female
    function setFemale()
    {
        this.setGender(1);
    }

    function setMale()
    {
		this.setGender(0);
    }
});
