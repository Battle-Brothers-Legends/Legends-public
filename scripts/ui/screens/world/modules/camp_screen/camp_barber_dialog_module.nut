

this.camp_barber_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		Standard = {
			Bodies = [
            	[::Const.Bodies.BarberNorthernMale, ::Const.Bodies.BarberSouthernMale, ::Const.Bodies.AfricanMale],
            	[::Const.Bodies.BarberNorthernFemale, ::Const.Bodies.BarberSouthernFemale, ::Const.Bodies.AfricanFemale]
        	],
        	Faces = [
            	[::Const.Faces.AllWhiteMale, ::Const.Faces.SouthernMale, ::Const.Faces.AfricanMale],
            	[::Const.Faces.AllWhiteFemale, ::Const.Faces.SouthernFemale, ::Const.Faces.AfricanFemale]
        	],
         	Hairs = [ [::Const.Hair.Barber], [::Const.Hair.BarberFemale] ],
         	Beards = [ [::Const.Beards.Barber], [::Const.Beards.BarberFemale] ]
		}
	},

	function create() {
		this.m.ID = "CampBarberDialogModule";
		this.ui_module.create();
	}

	function destroy() {
		this.ui_module.destroy();
	}

	function onLeaveButtonPressed() {
		this.m.Parent.onModuleClosed();
	}

	function queryRosterInformation() {
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach (b in brothers) {
			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription()
			};
			roster.push(e);
		}

		return {
			Title = "Barber",
			SubTitle = "Customize the appearance of your mercenaries at the barber",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function onEntrySelected(_entityID) {
		local roster = this.World.getTemporaryRoster();
		roster.clear();
		local temp = roster.create("scripts/entity/tactical/human");
		temp.copySpritesFrom(this.Tactical.getEntityByID(_entityID), [
			"body",
			"head",
			"beard",
			"hair",
			"tattoo_body",
			"beard_top",
			"tattoo_head"
		]);
		temp.setDirty(true);
		return temp.getImagePath();
	}

	function getSpriteArray(bro, spriteArray, _gender, _ethnicity, sprite = null) {
		local standardArray = this.m.Standard[spriteArray][_gender][this.m.Standard[spriteArray][_gender].len() > 1 ? _ethnicity : 0];

		if (sprite != null && sprite.HasBrush) {
			if (standardArray.find(sprite.getBrush().Name) != null) {
				return standardArray;
			}
		}

		local facesArray = bro.getBackground().m[spriteArray];
		if(facesArray != null && facesArray.len()!=0)
			return facesArray;
		
		return standardArray;
	}

	function onUpdateAppearance(_data) {
		local _entityID = _data[0];
		local _layerID = _data[1];
		local _change = _data[2];
		local temp = this.World.getTemporaryRoster().getAll()[0];
		local color;

		local bro = this.Tactical.getEntityByID(_entityID);
		local gender = bro.getGender();
		local ethnicity = bro.getEthnicity();

		

		if (temp.getFlags().has("BarberColor")) {
			color = temp.getFlags().get("BarberColor");
		} else {
			if (temp.getSprite("hair").HasBrush) {
				color = temp.getSprite("hair").getBrush().Name;
			} else if (temp.getSprite("beard").HasBrush) {
				color = temp.getSprite("beard").getBrush().Name;
			} else {
				color = "brown";
			}

			if (::String.contains(color, "_black_")) {
				color = "black";
			} else if (::String.contains(color, "_blonde_")) {
				color = "blonde";
			} else if (::String.contains(color, "_grey_")) {
				color = "grey";
			} else if (::String.contains(color, "_red_")) {
				color = "red";
			} else {
				color = "brown";
			}

			temp.getFlags().set("BarberColor", color);
		}

		if (_layerID == "color") {
			local index = 0;

			foreach (i, s in ::Const.HairColors.All) {
				if (s == color) {
					index = i;
					break;
				}
			}

			index = index + _change;

			if (index >= ::Const.HairColors.All.len()) {
				index = 0;
			} else if (index < 0) {
				index = ::Const.HairColors.All.len() - 1;
			}

			color = ::Const.HairColors.All[index];

			temp.getFlags().set("BarberColor", color);

			local hairSprite = temp.getSprite("hair");
            local hairArray = this.getSpriteArray(bro, "Hairs", gender, ethnicity);
            this.changeIndexEx(hairArray, hairSprite, 0, "hair", color, "");

            local beardSprite = temp.getSprite("beard");
            local beardArray = this.getSpriteArray(bro, "Beards", gender, ethnicity);
            this.changeIndexEx(beardArray, beardSprite, 0, "beard", color, "");

			if (beardSprite.HasBrush && this.doesBrushExist(beardSprite.getBrush().Name + "_top")) {
				temp.getSprite("beard_top").setBrush(beardSprite.getBrush().Name + "_top");
			} else {
				temp.getSprite("beard_top").resetBrush();
			}
		} else if (_layerID == "body" || _layerID == "head") {
			local sprite = temp.getSprite(_layerID);
            local arr = this.getSpriteArray(bro, _layerID == "body" ? "Bodies" : "Faces", gender, ethnicity, sprite);
            this.changeIndex(arr, sprite, _change);
		} else if (_layerID == "hair" || _layerID == "beard") {
			local sprite = temp.getSprite(_layerID);
            local arr = this.getSpriteArray(bro, _layerID == "hair" ? "Hairs" : "Beards", gender, ethnicity);
            this.changeIndexEx(arr, sprite, _change, _layerID, color, "");

            if (_layerID == "beard") {
                if (sprite.HasBrush && this.doesBrushExist(sprite.getBrush().Name + "_top")) {
                    temp.getSprite("beard_top").setBrush(sprite.getBrush().Name + "_top");
                } else {
                    temp.getSprite("beard_top").resetBrush();
                }
            }
		} else if (_layerID == "tattoo") {
			this.changeIndexEx(::Const.Tattoos.All, temp.getSprite("tattoo_body"), _change, "", "", temp.getSprite("body").getBrush().Name);
		} else if (_layerID == "tattoo_head") {
			this.changeIndexEx(::Const.Tattoos.Head, temp.getSprite("tattoo_head"), _change, "", "", "head");
		}
		temp.setDirty(true);
		return temp.getImagePath();
	}

	function onChangeAppearance(_entityID) {
		local bro = ::Tactical.getEntityByID(_entityID);
		local temp = ::World.getTemporaryRoster().getAll()[0];
		bro.copySpritesFrom(temp, [
			"body",
			"head",
			"beard",
			"hair",
			"tattoo_body",
			"beard_top",
			"tattoo_head",
		]);
		bro.setDirty(true);
		::Sound.play(::Const.Sound.Barber[::Math.rand(0, ::Const.Sound.Barber.len() - 1)], 1.0);
		return bro.getImagePath();
	}

	function changeIndex(_list, _sprite, _change) {
		local currentBrush = _sprite.HasBrush ? _sprite.getBrush().Name : "";
		local index = -1;

		foreach (i, s in _list) {
			if (s == currentBrush) {
				index = i;
				break;
			}
		}

		if (index == -1) {
			index = _change > 0 ? 0 : _list.len() - 1;
		} else {
			index = index + _change;
			if (index >= _list.len()) {
				index = 0;
			} else if (index < 0) {
				index = _list.len() - 1;
			}
		}

		if (_list.len() > 0 && index >= 0 && index < _list.len()) {
			if (_list[index] != "") {
				_sprite.setBrush(_list[index]);
			} else {
				_sprite.resetBrush();
			}
		}
	}

	function changeIndexEx(_list, _sprite, _change, _prefix, _midfix, _suffix) {
		local currentBrush = _sprite.HasBrush ? _sprite.getBrush().Name : "";
		local index = -1;

		local cleanList = [];
		foreach (item in _list) {
			if (cleanList.find(item) == null) {
				cleanList.push(item);
			}
		}

		foreach (i, s in cleanList) {
			if (s == "" && currentBrush == "") {
				// bald
				index = i;
				break;
			}

			if (s == "" || currentBrush == "") {
				continue;
			}

			local isMatch = false;

			local expected1 = _prefix + (_prefix != "" ? "_" : "") + _midfix + (_midfix != "" ? "_"	: "") + s + (_suffix != "" ? "_" : "") + _suffix; // hair_brown_xx
			local expected2 = _prefix + (_prefix != "" ? "_" : "") + s + (_suffix != "" ? "_" : "") + _suffix; // hair shaved

			if (currentBrush == expected1 || currentBrush == expected2) {
				index = i;
				break;
			}

			if (currentBrush == expected1 || currentBrush == expected2) {
				isMatch = true;
			} else if (_change == 0 && (_prefix == "hair" || _prefix == "beard")) {
				// color
				foreach (c in this.Const.HairColors.All) {
					if (currentBrush == _prefix + "_" + c + "_" + s	|| currentBrush == _prefix + "_" + s)
					{
						isMatch = true;
						break;
					}
				}
			}

			if (isMatch) {
				index = i;
				break;
			}
		}

		if (index == -1) {
			index = _change > 0 ? 0 : cleanList.len() - 1;
		} else {
			index = index + _change;
			if (index >= cleanList.len()) {
				index = 0;
			} else if (index < 0) {
				index = cleanList.len() - 1;
			}
		}

		if (cleanList.len() > 0 && index >= 0 && index < cleanList.len()) {
			if (cleanList[index] != "") {
				_sprite.setBrush(_prefix + (_prefix != "" ? "_" : "") + _midfix + (_midfix != "" ? "_" : "") + cleanList[index] + (_suffix != "" ? "_" : "") + _suffix);
			} else {
				_sprite.resetBrush();
			}
		}
	}
});
