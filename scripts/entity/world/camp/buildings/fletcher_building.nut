this.fletcher_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Items = [],
		AmmoAdded = 0,
		NumBros = 0,
		Craft = 0
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Fletcher;
		this.m.ModName = "Fletching";
		this.m.ModMod = 10.0;
		this.m.BaseCraft = 1.0;
		this.m.Slot = "fletch";
		this.m.Name = "Fletcher";
		this.m.Description = "Make some ammo";
		this.m.BannerImage = "ui/buttons/banner_fletch.png";
		this.m.CanEnter = false;
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_fletcher_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_fletcher_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_fletcher_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_fletcher_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_fletcher_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [];
	}

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*";
		}
		return this.m.Name +  " *Not Upgraded*";
	}

	function getDescription()
	{
		local desc = "";
		desc += "Arrows, bolts, little rocks (and Big Rocks!). The ammunition of war. ";
		desc += "Keep the company stocks full between battles by assigning some members of the company to the task of making ammo. ";
		desc += "Ammunition fabrication only occurs while encamped. The more people assigned, the more ammo crafted. ";
		desc += "\n\n";
		desc += "The Fletching tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent has a 15% increase in production speed. ";
		desc += "Additionally, there's a chance that ammunition of the disposable throwing kind will be crafted.";
		return desc;
	}

	function getModifierToolip()
	{
		local mod = this.getModifiers();
		local ret = [
			{
				id = 5,
				type = "text",
				icon = "ui/buttons/asset_ammo_up.png",
				text = "Produces [color=%positive%]" + mod.Craft / 2.0 + "[/color] units of ammo per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] / 2.0 + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function isHidden()
	{

		if (::Legends.Settings.skipCamp())
		{
			return false;
		}

		return !this.World.Flags.get("HasLegendCampFletching");
	}

	function getUpgraded()
	{
		return this.Stash.hasItem(::Legends.Camp.Tent.Fletcher);
	}

	function getLevel()
	{
		local pro = "dude";
		if (this.getUpgraded())
		{
			pro = "tent";
		}

		local sub = "empty";

		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function init()
	{
		this.m.AmmoAdded = 0;
		this.m.Items = [];
		local mod = this.getModifiers();
		this.m.NumBros = mod.Assigned;
		this.m.Craft = mod.Craft;
	}

	function getResults()
	{
		local res = [];
		local id = 50;
		if (this.m.AmmoAdded > 0)
		{
			res.push({
		 		id = id,
		 		icon = "ui/buttons/asset_ammo_up.png",
		 		text = "You created " + this.Math.floor(this.m.AmmoAdded) + " units of ammo"
			});
			++id;
		}
		foreach (b in this.m.Items)
		{
			res.push({
		 		id = id,
		 		icon = "ui/items/" + b.getIcon(),
		 		text = "You gained " + b.getName()
			});
			++id;
		}
		return res;
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function update()
	{
		if (this.m.NumBros == 0)
		{
			return null
		}

		if (this.World.Assets.getAmmo() + this.m.AmmoAdded >= this.World.Assets.getMaxAmmo())
		{
			return "Fletched ... " + this.Math.floor(this.m.AmmoAdded) + " ammo";
		}

		local points = this.Math.floor(this.m.Craft * this.m.Camp.getElapsedHours());
		this.m.AmmoAdded = this.Math.min(this.World.Assets.getMaxAmmo(), (points / 2.0));
		return "Fletched ... " + this.Math.floor(this.m.AmmoAdded) + " ammo";
	}

	function completed()
	{
		if (this.m.NumBros == 0)
		{
			return;
		}

		local item = null;
		if (this.m.AmmoAdded > 0)
		{
			this.World.Assets.addAmmo(this.Math.floor(this.m.AmmoAdded));
		}

		if (!this.getUpgraded())
		{
			return;
		}

		if (this.Stash.getNumberOfEmptySlots() == 0)
		{
			return;
		}

		local secondary = [
			"scripts/items/weapons/throwing_spear",
			"scripts/items/weapons/javelin"
		];

		//this can be upgrade system
		if (this.Math.rand(1, 100) <= this.m.Camp.getElapsedHours())
		{
			local item = this.new(secondary[this.Math.rand(0, secondary.len()-1)]);
			this.m.Items.push(item);
			this.Stash.add(item);
		}

	}


	function onClicked( _campScreen )
	{
		_campScreen.showFletcherDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}
});
