this.camp_painter_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {},
	function create()
	{
		this.m.ID = "CampPainterDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function queryRosterInformation()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			local background = b.getBackground();
			local bodyarmorbase = b.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local bodyarmor = null;
			local bodyarmorfinal = {};
			if (bodyarmorbase != null && ::MSU.isKindOf(bodyarmorbase, "legend_armor"))
			{
				bodyarmor = {
					Cloth = bodyarmorbase,
					Chain = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Chain),
					Plate = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Plate),
					Tabard = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard),
					Cloak = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Cloak)
				};
				foreach (key, value in bodyarmor)
				{
					if (value != null)
					{
						bodyarmorfinal[key] <- {
							Link = this.IO.scriptFilenameByHash(value.ClassNameHash),
							ID = value.m.ID,
							Value = this.Math.max(50, value.m.Value * 0.025),
							Variant = (value.m.Variants.find(value.m.Variant) != null) ? (value.m.Variants.find(value.m.Variant) + 1) : 1,
							Variants = this.Math.max(value.m.Variants.len(), 1),
							Icon = value.m.Icon,
							IconLarge = (value == bodyarmorbase) ? value.m.IconLarge : value.m.OverlayIconLarge
						};
					}
					else
					{bodyarmorfinal[key] <- null;}
				}
			}
			else
			{
				bodyarmorfinal = {
					Cloth = null,
					Chain = null,
					Plate = null,
					Tabard = null,
					Cloak = null
				};
			}
			local helmetbase = b.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local helmet = null;
			local helmetfinal = {};
			if (helmetbase != null && ::MSU.isKindOf(helmetbase, "legend_helmet"))
			{
				helmet = {
					Hood = helmetbase,
					Helm = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Helm),
					Top = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Top),
					Vanity = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity),
					ExtraVanity = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.ExtraVanity)
				};
				foreach (key, value in helmet)
				{
					if (value != null)
					{
						helmetfinal[key] <- {
							Link = this.IO.scriptFilenameByHash(value.ClassNameHash),
							ID = value.m.ID,
							Value = this.Math.max(50, value.m.Value * 0.025),
							Variant = (value.m.Variants.find(value.m.Variant) != null) ? (value.m.Variants.find(value.m.Variant) + 1) : 1,
							Variants = this.Math.max(value.m.Variants.len(), 1),
							Icon = value.m.Icon,
							IconLarge = value.m.IconLarge
						};
					}
					else
					{helmetfinal[key] <- null;}
				}
			}
			else
			{
				helmetfinal = {
					Hood = null,
					Helm = null,
					Top = null,
					Vanity = null,
					ExtraVanity = null
				};
			}

			local shield = {};
			if (b.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
			{
				local shielditem = b.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
				shield.Shield <- {
					Link = this.IO.scriptFilenameByHash(shielditem.ClassNameHash),
					ID = shielditem.m.ID,
					Value = this.Math.max(50, shielditem.m.Value * 0.025),
					Variant = (shielditem.m.Variants.find(shielditem.m.Variant) != null) ? (shielditem.m.Variants.find(shielditem.m.Variant) + 1) : 1,
					Variants = this.Math.max(shielditem.m.Variants.len(), 1),
					Icon = shielditem.m.IconLarge,
					IconLarge = shielditem.m.IconLarge
				};
				if (shielditem.m.ID == "shield.faction_kite_shield" || shielditem.m.ID == "shield.faction_heater_shield")
				{shield.Shield.Variants = 20;
				shield.Shield.Variant = shielditem.m.Faction * 2 - (2 - shielditem.m.Variant);}
			}
			else
			{shield.Shield <- null;}

			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				BodyArmor = bodyarmorfinal,
				Helmet = helmetfinal,
				Shield = shield
			};
			roster.push(e);
		}

		return {
			Title = "Painting Tent",
			SubTitle = "Customize the appearance of your armor",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function SendPics( _result )
	{
		local item = this.new(_result.Link);
		if (item.m.ID == "shield.faction_kite_shield" || item.m.ID == "shield.faction_heater_shield")
		{
			item.m.Faction = this.Math.ceil(_result.Variant / 2.0);
			item.m.Variant = item.m.Variants[1 - _result.Variant % 2];
		}
		else
		{
			item.m.Variant = item.m.Variants[_result.Variant - 1];
		}
		item.updateVariant();
		local isbodyarmorupgrade = false;
		local itemdelegate = item[item.SuperName];
		while (itemdelegate != null)
		{
			if (itemdelegate.ClassName == "legend_armor_upgrade"){isbodyarmorupgrade = true; break;}
			else if ("SuperName" in itemdelegate)
			{itemdelegate = itemdelegate[itemdelegate.SuperName];}
			else
			{break;}
		}
		if (item.isItemType(this.Const.Items.ItemType.Shield))
		{
			return {
				Icon = item.m.IconLarge,
				IconLarge = item.m.IconLarge
			};
		}
		else
		{
			return {
				Icon = item.m.Icon,
				IconLarge = isbodyarmorupgrade ? item.m.OverlayIconLarge : item.m.IconLarge
			};
		}
	}

	function onChangeAppearance( _result )
	{
		local result = null;
		local brothers = this.World.getPlayerRoster().getAll();
		foreach( b in brothers )
		{
			if (b.getID() == _result.ID)
			{
				local bodyarmorbase = b.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
				local bodyarmor = null;
				if (bodyarmorbase != null)
				{
					bodyarmor = {
						Cloth = bodyarmorbase,
						Chain = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Chain),
						Plate = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Plate),
						Tabard = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Tabbard),
						Cloak = bodyarmorbase.getUpgrade(this.Const.Items.ArmorUpgrades.Cloak)
					};
					foreach(key, value in bodyarmor)
					{
						if (value != null && _result.BodyArmor[key] != null)
						{
							if (value.m.ID == _result.BodyArmor[key].ID)
							{
								value.m.Variant = value.m.Variants[_result.BodyArmor[key].Variant - 1];
								value.updateVariant();
							}
						}
					}
					bodyarmorbase.updateAppearance();
				}
				local helmetbase = b.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
				local helmet = null;
				if (helmetbase != null)
				{
					helmet = {
						Hood = helmetbase,
						Helm = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Helm),
						Top = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Top),
						Vanity = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.Vanity),
						ExtraVanity = helmetbase.getUpgrade(this.Const.Items.HelmetUpgrades.ExtraVanity)
					};
					foreach(key, value in helmet)
					{
						if (value != null && _result.Helmet[key] != null)
						{
							if (value.m.ID == _result.Helmet[key].ID)
							{
								value.m.Variant = value.m.Variants[_result.Helmet[key].Variant - 1];
								value.updateVariant();
							}
						}
					}
					helmetbase.updateAppearance();
				}

				local shield = b.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
				if (shield != null)
				{
					if (_result.Shield.Shield != null)
					{
						if (shield.m.ID == _result.Shield.Shield.ID)
						{
							if (shield.m.ID == "shield.faction_kite_shield" || shield.m.ID == "shield.faction_heater_shield")
							{
								shield.m.Faction = this.Math.ceil(_result.Shield.Shield.Variant / 2.0);
								shield.m.Variant = shield.m.Variants[1 - _result.Shield.Shield.Variant % 2];
							}
							else
							{
								shield.m.Variant = shield.m.Variants[_result.Shield.Shield.Variant - 1];
							}
							shield.updateVariant();
							shield.updateAppearance();
						}
					}
				}

				this.World.Assets.addMoney(-_result.Cost);
				result = this.queryRosterInformation();
				break;
			}
		}

		return result;
	}

});

