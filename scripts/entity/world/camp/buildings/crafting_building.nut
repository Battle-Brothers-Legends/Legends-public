this.crafting_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		ItemsCrafted = [],
		Queue = [],
		CurrentProgress = 0,
		CurrentCraft = null,
		NumBros = 0,
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Crafting;
		this.m.ModName = "Crafting";
		this.m.BaseCraft = 10.0;
		this.m.Slot = "craft";
		this.m.Name = "Craft";
		this.m.Description = "Craft items";
		this.m.BannerImage = "ui/buttons/banner_craft.png";
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_taxidermist_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/camp/camp_taxidermist_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_taxidermist_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
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
		desc += "Come here to craft potions, trophies and other useful items. Recipes added to the crafting queue will be worked on by anyone ";
		desc += "assigned to this tent. Crafting only occurs while encamped. Progress is saved, so items do not have to be crafted in ";
		desc += "a single session. The more people assigned to the tent, the quicker items will be crafted.";
		desc += "\n\n";
		desc += "The crafting tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent has a 15% increase in crafting speed.";
		return desc;
	}

	function getModifierToolip()
	{
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Queue.len() + "[/color] items in the crafting queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRequiredTime() + "[/color] hours to craft all items."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total crafting modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function isHidden()
	{
		if ( !this.Const.DLC.Unhold)
		{
			return true;
		}

		if (::Legends.Mod.ModSettings.getSetting("SkipCamp").getValue())
		{
			return false;
		}

		return !this.World.Flags.get("HasLegendCampCrafting");
	}

	function getUpgraded()
	{
		return this.Stash.hasItem("tent.craft_tent");
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
		this.onInit();
		this.m.ItemsCrafted = [];
		this.m.CurrentProgress = 0;
		local mod = this.getModifiers();
		this.m.NumBros = mod.Assigned;
	}

	function onInit()
	{
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (this.m.Queue[i] == null)
			{
				continue;
			}
			if (this.m.Queue[i].Blueprint == null)
			{
				continue;
			}
			q.push(this.m.Queue[i]);
		}
		this.m.Queue = q;
	}

	function getResults()
	{
		local res = [];
		local id = 20;
		foreach (b in this.m.ItemsCrafted)
		{
			res.push({
		 		id = id,
		 		icon = "ui/items/" + b.getIcon(),
		 		text = "Crafting completed: " + b.getName()
			});
			++id;
		}
		return res;
	}

	function getUpdateText()
	{
		if (this.m.Queue.len() <= 0)
		{
			return null;
		}

		if (this.m.NumBros == 0)
		{
			return "No one assigned to craft";
		}

		local craftableQueue = this.getCraftableQueue();

		local numToCraft = craftableQueue.len() + this.m.ItemsCrafted.len();
		local crafted = this.m.ItemsCrafted.len();

		local progress = this.Math.floor(100 * this.m.CurrentProgress);

		if (craftableQueue.len() == 0) return "Crafted ..." + crafted + " / " + crafted;

		return "Crafted ... " + crafted + "/" + numToCraft + " ... " + progress + "% of " + this.m.CurrentCraft;
	}

	function getCraftableQueue()
	{
		local itemsMap = this.World.Assets.getStash().getNumItemsMap(true);

		local craftable = [];
		for (local i = 0; i < this.m.Queue.len(); ++i)
		{
			local r = this.m.Queue[i];
			if(r == null) continue;

			local currentCosts = {};
			local canCraft = true;

			foreach(c in r.Blueprint.m.PreviewComponents)
			{
				if (c.Instance.getID() in itemsMap && c.Num <= itemsMap[c.Instance.getID()] )
				{
					currentCosts[c.Instance.getID()] <- c.Num;
				}
				else
				{
					canCraft = false;
					break;
				}
			}

			if (!canCraft) continue;

			foreach (id, num in currentCosts) itemsMap[id] -= num;

			craftable.push(i);
			if (r.Forever) i--;
		}
		return craftable;
	}

	function update ()
	{
		local modifiers = this.getModifiers();

		for (local i = 0; i < this.m.Queue.len(); ++i)
		{
			local r = this.m.Queue[i];
			if (r == null)
			{
				continue;
			}

			if (r.Blueprint == null)
			{
				continue;
			}

			if (!r.Blueprint.isCraftable())
			{
				continue;
			}

			local needed = r.Blueprint.getCostForCraft() - r.Points;

			if (modifiers.Craft < needed)
			{
				needed = modifiers.Craft;
			}
			r.Points += needed;
			modifiers.Craft -= needed;

			if (r.Points >= r.Blueprint.getCostForCraft())
			{
				r.Blueprint.craft();
				this.m.ItemsCrafted.push(r.Blueprint);
				if (r.Forever)
				{
					r.Points = 0;
					i -= 1;
				}
				else this.m.Queue[i] = null;

				this.World.Statistics.getFlags().increment("ItemsCrafted");
			}

			if (modifiers.Craft <= 0)
			{
				this.m.CurrentProgress = r.Points / r.Blueprint.getCostForCraft();
				this.m.CurrentCraft = r.Blueprint.getName();
				break
			}
		}

		return this.getUpdateText();
	}

	function getQueue()
	{
		local ret = [];
		foreach( b in this.m.Queue )
		{
			if (b == null)
			{
				continue;
			}
			local r = b.Blueprint.getUIData();
			r.Percentage <- (b.Points / (b.Blueprint.getCostForCraft() * 1.0)) * 100;
			r.Forever <- b.Forever;
			ret.push(r);
		}
		return ret;
	}

	function getResourceImage()
	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()
	{
		return this.getRequiredTime();
	}

	function getRequiredTime()
	{
		local points = 0;
		if (this.m.Queue == null)
		{
			return 0;
		}

		foreach (i in this.getCraftableQueue())
		{
			local r = this.m.Queue[i];
			if (r == null)
			{
				continue;
			}

			points += (r.Blueprint.getCostForCraft() - r.Points);
		}
		local modifiers = this.getModifiers();
		if (modifiers.Craft <= 0)
		{
			return 0;
		}
		return this.Math.ceil(points / modifiers.Craft);
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function onAdd ( _blueprintID )
	{
		local blueprint = this.World.Crafting.getBlueprint(_blueprintID);
		this.m.Queue.push({
			Points = 0.0,
			Blueprint = blueprint,
			Forever = false
		});
		if (blueprint.getSounds().len() != 0)
		{
			this.Sound.play(blueprint.getSounds()[this.Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}
	}

	function onCraftForever (_blueprintID)
	{
		foreach(i in this.m.Queue)
		{
			if(i.Blueprint.getID() == _blueprintID && i.Forever) return false;
		}
		this.onAdd(_blueprintID);
		local table = this.m.Queue[this.m.Queue.len()-1];
		table.Forever = true;
		return true;
	}

	function onRemove ( _idx )
	{
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (i == _idx)
			{
				continue;
			}
			q.push(this.m.Queue[i]);
		}
		this.m.Queue = q;
	}

	function onSwap ( _source, _target)
	{
		local item = this.m.Queue[_source];
		this.m.Queue[_source] = this.m.Queue[_target];
		this.m.Queue[_target] = item;
		if (item.Blueprint.getSounds().len() != 0)
		{
			this.Sound.play(item.Blueprint.getSounds()[this.Math.rand(0, item.Blueprint.getSounds().len() - 1)], 1.0);
		}
	}

	function onClicked( _campScreen )
	{
		_campScreen.showCraftingDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.onInit(); //clear out null queue items
		this.camp_building.onSerialize(_out);
		_out.writeU16(this.m.Queue.len());
		foreach( b in this.m.Queue )
		{
			_out.writeString(b.Blueprint.getID());
			_out.writeF32(b.Points);
			_out.writeBool(b.Forever);
		}
	}

	function onDeserialize( _in )
	{
		this.m.Queue = [];
		this.camp_building.onDeserialize(_in);
		local num = _in.readU16();
		for( local i = 0; i < num; i = ++i )
		{
			this.m.Queue.push({
				Blueprint =  this.World.Crafting.getBlueprint(_in.readString()),
				Points = _in.readF32(),
				Forever = _in.readBool()
			});
		}
	}

});
