this.camp_building <- {
	m = {
		Camp = null,
		ID = "",
		Slot = "",
		Name = "",
		Description = "",
		BannerImage = "",
		Level = 0,
		UIImage = null,
		UIImageNight = null,
		UIImageFull = null,
		UIImageNightFull = null,
		Tooltip = null,
		TooltipIcon = "",
		TerrainLabel = "",
		Sounds = [
			{
				File = "ambience/camp/camp_rest_campfire.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_laugh_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_laugh_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_laugh_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		SoundsAtNight = [
			{
				File = "ambience/camp/camp_rest_campfire.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_general_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_laugh_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_laugh_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_laugh_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_snore_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_snore_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_rest_snore_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_gatherer_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}

		],
		CanEnter = true,
		HasPopup = false,
		InCommanderTent = true,
		Camping = true,
		Escorting = false
		ModName = "",
		ModMod = 1.0,
		BaseCraft = 0.0,
		Conversion = 1.0
	},
	function create()
	{
	}

	function destroy()
	{
	}

	function init()
	{
	}

	function completed()
	{
	}

	function Camping()
	{
		return this.m.Camping;
	}

	function Escorting()
	{
		return this.m.Escorting;
	}

	function getUpdateText()
	{
		return null;
	}

	function update ()
	{
		return this.getUpdateText();
	}

	function updateTick (_hours)
	{
	}

	function hasPopup()
	{
		return this.m.HasPopup;
	}

	function canEnter()
	{
		return this.m.CanEnter;
	}

	function getID()
	{
		return this.m.ID;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getSlot()
	{
		return this.m.Slot;
	}

	function getResults()
	{
		return [];
	}

	function isHidden()
	{
		return false;
	}

	function getLevel()
	{
		return "empty";
	}

	function getUIImage( _terrain )
	{
		local terrainlabel = _terrain;
		if (this.m.TerrainLabel != "")
		{
			terrainlabel = this.m.TerrainLabel
		}
		else if (_terrain < 10)
		{
			terrainlabel = "0" + _terrain;
		}
		local day = this.World.getTime().IsDaytime ? "day" : "night";
		return "ui/settlements/" + terrainlabel + "_" + this.getSlot() + "_" + this.getLevel() + "_" + day;
	}

	function getTooltipID()
	{
		return this.m.ID;
	}

	function getTitle()
	{
		return this.m.Name;
	}

	function getTooltip()
	{
		local res = [
			{
				id = 1,
				type = "title",
				text = this.getTitle()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		local mod = this.getModifierToolip();
		foreach (i in mod)
		{
			res.push(i);
		}
		return res;
	}

	function getModifierToolip()
	{
		return [];
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getTooltipIcon()
	{
		return this.m.TooltipIcon;
	}

	function getNumberAssigned()
	{
		local count = 0;
		local roster = this.World.getPlayerRoster().getAll();
		foreach( b in roster )
		{
			if (b.getCampAssignment() != this.m.ID)
			{
				continue
			}
			++count;
		}
		return count;
	}

	function getBanner()
	{
		return this.m.BannerImage;
	}

	function getResourceImage()
	{
		return "";
	}

	function getResourceCount()
	{
		return 0;
	}

	function inCommanderTent()
	{
		return this.m.InCommanderTent && !this.isHidden();
	}

	function pushUIMenuStack()
	{
		this.World.State.getMenuStack().push(function ()
		{
			this.World.State.getCampScreen().showMainDialog();
		}, function ()
		{
			return !this.World.State.getCampScreen().isAnimating();
		});
	}

	function assignBro( _bro )
	{
		_bro.setCampAssignment(this.m.ID);
	}

	function setCamp ( _camp )
	{
		this.m.Camp = this.WeakTableRef(_camp);
	}

	function onClicked( _campScreen )
	{
		this.World.State.getMenuStack().push(function ()
		{
			this.World.State.getCampScreen().showMainDialog();
			this.World.State.getCampScreen().refresh();
		}, function ()
		{
			return !this.World.State.getCampScreen().isAnimating();
		});
	}

	function onBroLeave ( _bro )
	{
	}

	function onBroEnter ( _bro )
	{
		return !_bro.isStabled()
	}

	function onSerialize( _out )
	{
	}

	function onDeserialize( _in )
	{
	}

	function sortModifiers( _f1, _f2 )
	{
		if (_f1[0] > _f2[0])
		{
			return -1;
		}
		else if (_f1[0] < _f2[0])
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	function getModifiers()
	{
		local ret =
		{
			Consumption = 1.0 / this.m.Conversion,
			Craft = 0.0, // total Craft value of all characters assigned to the tent
			Assigned = 0, // number of characters assigned to the tent
			Modifiers = [] // each element is [Craft value contributed by the character (including bonuses), Name of character, Background of character]
		}
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue
			}
			// Each character assigned will contribute the tent's BaseCraft plus any bonuses from their modifiers
			// If the character does not have the relevant skill, they will contribute only the BaseCraft value
			// If the character is skilled, they will contribute the BaseCraft value + the bonuses from their modifiers. The bonuses are further multiplied by the tent's ModMod value
			// A higher ModMod value means that skilled characters will have a more significant impact on the output
			local mod = this.m.BaseCraft + this.m.BaseCraft * bro.getBackground().getModifiers()[this.m.ModName] * this.m.ModMod;
			++ret.Assigned;
			ret.Modifiers.push([mod, bro.getNameOnly(), bro.getBackground().getNameOnly()]);
		}

		ret.Modifiers.sort(this.sortModifiers);
		for (local i = 0; i < ret.Modifiers.len(); i = ++i)
		{
			ret.Modifiers[i][0] = ret.Modifiers[i][0] * this.Math.pow(i + 1, -0.5); // each additional character grants diminishing returns
			if (this.getUpgraded())
			{
				ret.Modifiers[i][0] *= 1.15; // an upgraded tent grants a 15% bonus to each character's Craft contribution
			}
			ret.Craft += ret.Modifiers[i][0];
		}
		return ret;
	}

	function getInfo()
	{
		return null;
	}

	function onSortByModifier( _a, _b )
	{
		if (_a.Modifier > _b.Modifier)
		{
			return -1;
		}
		else if (_a.Modifier < _b.Modifier)
		{
			return 1;
		}

		return 0;
	}

	function getSortedRoster()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			if (!this.onBroEnter(b))
			{
				continue;
			}
			local bro = this.UIDataHelper.convertEntityToUIData(b, null);
			local tent = this.World.Camp.getBuildingByID( b.getCampAssignment() );
			bro.bannerImage <- tent.getBanner();
			bro.IsSelected <- b.getCampAssignment() == this.m.ID;
			local modifier = 0;
			if (this.m.ModName != "")
			{
				modifier = b.getBackground().getModifiers()[this.m.ModName];
			}
			bro.Modifier <- modifier;
			roster.push(bro);
		}

		roster.sort(this.onSortByModifier);
		return roster
	}

	function onPopupButtonClicked( _data )
	{

	}

	function queryConfigureSettings()
	{
		return {};
	}
}
