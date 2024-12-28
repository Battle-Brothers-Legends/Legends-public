this.enchanter_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		BaseCraft = 30.0,
		ItemsCrafted = [],
		Queue = [],
		CurrentProgress = 0,
		CurrentCraft = null,
		NumBros = 0
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Enchanter;
		this.m.Slot = "enchant";
		this.m.Name = "Enchanter";
		this.m.Description = "Oooo.. Pretty glowing things..."
		this.m.BannerImage = "ui/buttons/banner_enchant.png"
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_vala_chanting_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_chanting_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
				{
				File = "ambience/camp/camp_vala_chanting_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_chanting_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_singing_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_vala_stones_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
	}

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*"
		}
		return this.m.Name +  " *Not Upgraded*"
	}

	function getDescription()
	{
		local desc = "";
		desc += "Tha Vala emporium of mystical (and maybe even magical) mischief. While encamped, the Vala can retreat into her books and experiments. "
		desc += "Rune requests can be queued up for the Vala to try her hand at. What comes of them, you'll just have to wait and see what she inscribes. "
		desc += "Only the Vala can be assigned to the Enchanting tent. Vala's ability to inscribe runes is determined by learning the correct inscriptions via her perks."
		desc += "\n\n"
		desc += "The Enchanting tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent has a 15% increase in enchanting speed. "
		desc += "Additionally, the upgraded tools and equipment from the cart allows the Vala to produce potentially more powerful Runes."
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
				text = "There are [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Queue.len() + "[/color] rune inscriptions in the queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRequiredTime() + "[/color] hours to inscribe all runes."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total enchanting modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + mod.Craft + "[/color] units per hour."
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
			})
			++id;
		}
		return ret;
	}

	function init()
	{
		this.onInit();
		this.m.ItemsCrafted = [];
		this.m.CurrentProgress = 0;
		this.m.CurrentCraft = null;
		local mod = this.getModifiers()
		this.m.NumBros = mod.Assigned;
	}

	function isHidden()
	{
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getBackground().getModifiers().Enchanting > 0)
			{
				return false
			}
		}
		return true;
	}

	function onInit()
	{
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (this.m.Queue[i] == null)
			{
				continue
			}
			if (this.m.Queue[i].Blueprint == null)
			{
				continue
			}
			q.push(this.m.Queue[i])
		}
		this.m.Queue = q
	}

	function getModifiers()
	{
		local ret =
		{
			Craft = 0.0,
			Assigned = 0,
			Modifiers = []
		}
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue
			}

			local rm = this.m.BaseCraft * bro.getBackground().getModifiers().Enchanting;
			if (bro.getLevel() >= 12)
			{
				rm *= 1.3;
			}
			ret.Craft += rm
			++ret.Assigned
			ret.Modifiers.push([rm, bro.getName(), bro.getBackground().getNameOnly()]);
		}

		if (this.getUpgraded())
		{
			ret.Craft *= 1.15;
		}

		return ret;
	}

	function getResults()
	{
		local res = []
		local id = 20;
		foreach (b in this.m.ItemsCrafted)
		{
			res.push({
		 		id = id,
		 		icon = "ui/items/" + b.getIcon(),
		 		text = "Enchanting completed: " + b.getName()
			})
			++id;
		}
		return res;
	}

	function getUpgraded()
	{
		return this.Stash.hasItem("tent.enchant_tent");
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

	function getUpdateText()
	{
		if (this.m.Queue.len() <= 0)
		{
			return null;
		}

		if (this.m.NumBros == 0)
		{
			return "No one assigned to enchant";
		}

		local crafted = this.m.ItemsCrafted.len();
		local numToCraft = this.m.Queue.len();
		local progress = this.Math.floor(10000 * this.m.CurrentProgress) / 100.0;

		if (crafted == numToCraft) return "Crafted ..." + crafted + " / " + crafted;

		return "Enchanted ... " + crafted + "/" + numToCraft + " ... " + progress + "% of " + this.m.CurrentCraft;
	}

	function update ()
	{
		local modifiers = this.getModifiers();
		foreach (i, r in this.m.Queue)
		{
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

			local needed = r.Blueprint.getCost() - r.Points;

			if (modifiers.Craft < needed)
			{
				needed = modifiers.Craft;
			}
			r.Points += needed;
			modifiers.Craft -= needed;

			if (r.Points >= r.Blueprint.getCost())
			{
				r.Blueprint.enchant(this.getUpgraded());
				this.m.ItemsCrafted.push(r.Blueprint)
				this.m.Queue[i] = null;
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
				continue
			}
			local r = b.Blueprint.getUIData();
			r.Percentage <- (b.Points / (b.Blueprint.getCost() * 1.0)) * 100
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

		foreach (r in this.m.Queue)
		{
			if (r == null)
			{
				continue;
			}

			points += (r.Blueprint.getCost() - r.Points);
		}
		local modifiers = this.getModifiers();
		if (modifiers.Craft <= 0)
		{
			return 0
		}
		return this.Math.ceil(points / modifiers.Craft);
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function onBroEnter ( _bro )
	{
		return _bro.getBackground().getModifiers().Enchanting > 0;
	}


	function onAdd ( _result )
	{
		local blueprint = this.World.Crafting.getBlueprint(_result.ID);
		if (!blueprint.isCraftable())
		{
			return;
		}
		this.m.Queue.push({
			Points = 0.0,
			Blueprint = blueprint
		});
		if (blueprint.getSounds().len() != 0)
		{
			this.Sound.play(blueprint.getSounds()[this.Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}
	}

	function onRemove ( _idx )
	{
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (i == _idx)
			{
				continue
			}
			q.push(this.m.Queue[i])
		}
		this.m.Queue = q
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
		_campScreen.showEnchanterDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.onInit(); //clear out null queue items
		_out.writeU16(this.m.Queue.len());
		foreach( b in this.m.Queue )
		{
			_out.writeString(b.Blueprint.getID());
			_out.writeF32(b.Points)
		}
	}

	function onDeserialize( _in )
	{
		local num = _in.readU16();
		for( local i = 0; i < num; i = ++i )
		{
			this.m.Queue.push({
				Blueprint =  this.World.Crafting.getBlueprint(_in.readString()),
				Points = _in.readF32(),
			})
		}
	}

});