::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_barber_dialog_module", function(o) {

	local queryRosterInformation = o.queryRosterInformation;
	o.queryRosterInformation = function ()
	{
		result = queryRosterInformation();
		result.SubTitle = "Customize the appearance of your mercenaries at the barber";

		return result;
	}

	o.onUpdateAppearance = function ( _data )
	{
		local _entityID = _data[0];
		local _layerID = _data[1];
		local _change = _data[2];
		local temp = this.World.getTemporaryRoster().getAll()[0];
		local color;

		local bro = this.Tactical.getEntityByID(_entityID);
		local isFemale = bro.getGender() == 1;
		local ethnicity = bro.getEthnicity();

		if (temp.getSprite("hair").HasBrush)
		{
			color = temp.getSprite("hair").getBrush().Name;
		}
		else if (temp.getSprite("beard").HasBrush)
		{
			color = temp.getSprite("beard").getBrush().Name;
		}
		else
		{
			color = "brown";
		}

		if (this.String.contains(color, "_black_"))
		{
			color = "black";
		}
		else if (this.String.contains(color, "_blonde_"))
		{
			color = "blonde";
		}
		else if (this.String.contains(color, "_grey_"))
		{
			color = "grey";
		}
		else if (this.String.contains(color, "_red_"))
		{
			color = "red";
		}
		else
		{
			color = "brown";
		}

		if (_layerID == "color")
		{
			local index = 0;

			foreach( i, s in this.Const.HairColors.All )
			{
				if (s == color)
				{
					index = i;
					break;
				}
			}

			index = index + _change;

			if (index >= this.Const.HairColors.All.len())
			{
				index = 0;
			}
			else if (index < 0)
			{
				index = this.Const.HairColors.All.len() - 1;
			}

			color = this.Const.HairColors.All[index];

			if (isFemale)
			{
				this.changeIndexEx(this.Const.Hair.BarberFemale, temp.getSprite("hair"), 0, "hair", color, "");
				this.changeIndexEx(this.Const.Beards.BarberFemale, temp.getSprite("beard"), 0, "beard", color, "");
			}
			else
			{
				this.changeIndexEx(this.Const.Hair.Barber, temp.getSprite("hair"), 0, "hair", color, "");
				this.changeIndexEx(this.Const.Beards.Barber, temp.getSprite("beard"), 0, "beard", color, "");
			}

			if (temp.getSprite("beard").HasBrush && this.doesBrushExist(temp.getSprite("beard").getBrush().Name + "_top"))
			{
				temp.getSprite("beard_top").setBrush(temp.getSprite("beard").getBrush().Name + "_top");
			}
			else
			{
				temp.getSprite("beard_top").resetBrush();
			}
		}
		else if (_layerID == "body")
		{
			if (isFemale)
			{
				if (ethnicity == 1)
				{
					this.changeIndex(this.Const.Bodies.BarberSouthernFemale, temp.getSprite("body"), _change);
					this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), 0, "", "", temp.getSprite("body").getBrush().Name);
				}
				else if (ethnicity == 2)
				{
					this.changeIndex(this.Const.Bodies.AfricanFemale, temp.getSprite("body"), _change);
					this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), 0, "", "", temp.getSprite("body").getBrush().Name);
				}
				else
				{
					this.changeIndex(this.Const.Bodies.BarberNorthernFemale, temp.getSprite("body"), _change);
					this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), 0, "", "", temp.getSprite("body").getBrush().Name);			
				}
				
			}
			else
			{
				if (ethnicity == 1)
				{
					this.changeIndex(this.Const.Bodies.BarberSouthernMale, temp.getSprite("body"), _change);
					this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), 0, "", "", temp.getSprite("body").getBrush().Name);
				}
				else if (ethnicity == 2)
				{
					this.changeIndex(this.Const.Bodies.AfricanMale, temp.getSprite("body"), _change);
					this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), 0, "", "", temp.getSprite("body").getBrush().Name);
				}
				else
				{
					this.changeIndex(this.Const.Bodies.BarberNorthernMale, temp.getSprite("body"), _change);
					this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), 0, "", "", temp.getSprite("body").getBrush().Name);			
				}
			}
		}
		else if (_layerID == "head")
		{
			if (isFemale)
			{
				if (ethnicity == 1)
				{
					this.changeIndex(this.Const.Faces.SouthernFemale, temp.getSprite("head"), _change);
				}
				else if (ethnicity == 2)
				{
					this.changeIndex(this.Const.Faces.AfricanFemale, temp.getSprite("head"), _change);
				}
				else
				{
					this.changeIndex(this.Const.Faces.AllWhiteFemale, temp.getSprite("head"), _change);
				}
			}
			else
			{
				if (ethnicity == 1)
				{
					this.changeIndex(this.Const.Faces.SouthernMale, temp.getSprite("head"), _change);
				}
				else if (ethnicity == 2)
				{
					this.changeIndex(this.Const.Faces.AfricanMale, temp.getSprite("head"), _change);
				}
				else
				{
					this.changeIndex(this.Const.Faces.AllWhiteMale, temp.getSprite("head"), _change);
				}
			}
		}
		else if (_layerID == "hair")
		{
			if (isFemale)
			{
				this.changeIndexEx(this.Const.Hair.BarberFemale, temp.getSprite("hair"), _change, "hair", color, "");
			}
			else
			{
				this.changeIndexEx(this.Const.Hair.Barber, temp.getSprite("hair"), _change, "hair", color, "");
			}
		}
		else if (_layerID == "beard")
		{
			if (isFemale)
			{
				this.changeIndexEx(this.Const.Beards.BarberFemale, temp.getSprite("beard"), _change, "beard", color, "");

				if (temp.getSprite("beard").HasBrush && this.doesBrushExist(temp.getSprite("beard").getBrush().Name + "_top"))
				{
					temp.getSprite("beard_top").setBrush(temp.getSprite("beard").getBrush().Name + "_top");
				}
				else
				{
					temp.getSprite("beard_top").resetBrush();
				}
			}
			else
			{
				this.changeIndexEx(this.Const.Beards.Barber, temp.getSprite("beard"), _change, "beard", color, "");

				if (temp.getSprite("beard").HasBrush && this.doesBrushExist(temp.getSprite("beard").getBrush().Name + "_top"))
				{
					temp.getSprite("beard_top").setBrush(temp.getSprite("beard").getBrush().Name + "_top");
				}
				else
				{
					temp.getSprite("beard_top").resetBrush();
				}
			}
		}
		else if (_layerID == "tattoo")
		{
			this.changeIndexEx(this.Const.Tattoos.All, temp.getSprite("tattoo_body"), _change, "", "", temp.getSprite("body").getBrush().Name);

			if (temp.getSprite("tattoo_body").HasBrush)
			{
				local name = temp.getSprite("tattoo_body").getBrush().Name;
				name = this.String.remove(name, "_" + temp.getSprite("body").getBrush().Name);
				local index = 0;

				foreach( i, s in this.Const.Tattoos.All )
				{
					if (s == name)
					{
						index = i;
						break;
					}
				}

				if (this.doesBrushExist(this.Const.Tattoos.All[index] + "_head"))
				{
					temp.getSprite("tattoo_head").setBrush(this.Const.Tattoos.All[index] + "_head");
				}
				else
				{
					temp.getSprite("tattoo_head").resetBrush();
				}
			}
			else
			{
				temp.getSprite("tattoo_head").resetBrush();
			}
		}

		temp.setDirty(true);
		return temp.getImagePath();
	}
});
