::mods_hookBaseClass("crafting/blueprint", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o.m.PreviewSkills <- [];
	o.m.BlueprintType <- "Crafting";
	o.m.Type <- this.Const.Items.ItemType.None;
	o.m.CraftMultiplier <- 1.0;

	o.getItemType <- function ()
	{
		return this.m.Type;
	}

	o.getCostForCraft <- function  () {
		local modifier = 1.0;

    	foreach (reqGroup in this.m.PreviewSkills) {
			foreach (skillInstance in reqGroup.Instances) {
				local skillID = skillInstance.getID(); // switcheroo for enchanting - we require vala but assist with enchanters assistant
				if(skillID == ::Legends.Backgrounds.getID(::Legends.Background.LegendVala)) {
					skillID = ::Legends.Professions.getID(::Legends.Profession.LegendEnchantersAssistant);
				}
				
				local professionDef = ::Const.Professions.findById(skillID);
				if(professionDef != null) {
					local effect = ::World.Assets.m.ProfessionEffect[professionDef.Const];
					if (effect > 0) {
						modifier /= effect;
					}
				}
       		}
    	}
		return this.getCost() * this.m.CraftMultiplier * modifier;
	}

	o.getIcon = function ()
	{
		if (::Legends.S.oneOf(this.m.PreviewCraftable.getIcon(), "layers/named_icon_glow.png", "layers/legendary_icon_glow.png"))
			return this.m.PreviewCraftable.m.Icon;
		return this.m.PreviewCraftable.getIcon();
	}

	o.getTooltipForComponent = function ( _idx )
	{
		if (_idx > this.m.PreviewComponents.len() - 1)
		{
			this.logError("Out of bound error on blueprint :: " + this.m.ID);
			return null;
		}

		return this.m.PreviewComponents[_idx].Instance.getTooltip();
	}

	o.getTooltipForSkill <- function ( _idx )
	{
		foreach( c in this.m.PreviewSkills )
		{
			foreach( s in c.Instances )
			{
				if (s.getID() == _idx)
				{
					local tooltip = s.getTooltip();
					if(tooltip[0].text.find("Background:") != null)
						tooltip.push({
							id = 2,
							type = "description",
							text = "Requires a " + tooltip[0].text.slice(tooltip[0].text.find("Background:") + 12) + " to craft."
						});
					return tooltip;
				}
			}
		}

		return null;
	}

	o.init = function ( _comps )
	{
		foreach( i in _comps )
		{
			local c = this.new(i.Script);
			local pc = {
				Name = i.Script,
				Num = i.Num,
				Instance = c
			};

			if ("LegendsArmor" in i)
			{
				pc.LegendsArmor <- i.LegendsArmor;
			}

			this.m.PreviewComponents.push(pc);
		}
	}

	o.initSkills <- function (_skills) {
		foreach (skill in _skills) {
			this.m.PreviewSkills.push({
				Instances = [skill]
			});
		}
	}

	o.initSkillsOneOf <- function (_skills) {
		this.m.PreviewSkills.push({
			Instances = _skills
		});
	}


	o.requirementsMet <- function ( _ids )
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			foreach( id in _ids )
			{
				if (bro.getSkills().hasSkill(id))
				{
					return true;
				}
			}
		}

		return false;
	}

	o.isPartlyCraftable <- function ()
	{
		local itemsMap = this.World.Assets.getStash().getNumItemsMap(true);

		foreach( c in this.m.PreviewSkills )
		{
			local ids = [];

			foreach( s in c.Instances )
			{
				ids.push(s.getID());
			}

			if (!this.requirementsMet(ids))
			{
				return false;
			}
		}

		foreach( c in this.m.PreviewComponents )
		{
			local num = 0;

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			if (num >= c.Num)
			{
				return true;
			}
		}

		return false;
	}

	o.isCraftable = function ()
	{
		local itemsMap = this.World.Assets.getStash().getNumItemsMap(true);

		foreach( c in this.m.PreviewComponents )
		{
			local num = 0;

			if (c.Instance.getID() in itemsMap)
			{
				num = itemsMap[c.Instance.getID()];
			}

			if (num < c.Num)
			{
				return false;
			}
		}

		foreach( c in this.m.PreviewSkills )
		{
			local ids = [];

			foreach( s in c.Instances )
			{
				ids.push(s.getID());
			}

			if (!this.requirementsMet(ids))
			{
				return false;
			}
		}

		return true;
	}

	o.isQualified = function ()	{
		if (this.m.TimesCrafted >= 1) {
			return true;
		}

		if (::Legends.Mod.ModSettings.getSetting("ShowBlueprintsWhen").getValue() == "Always") return true;
		if (::Legends.Mod.ModSettings.getSetting("ShowBlueprintsWhen").getValue() == "One Ingredient Available") return this.isPartlyCraftable();

		return this.isCraftable();
	}

	o.getUIData = function ()
	{
		if (this.m.PreviewCraftable.m.ID == "shield.heater_shield" || this.m.PreviewCraftable.m.ID == "shield.kite_shield" || this.m.PreviewCraftable.m.ID == "shield.legend_tower_shield")
		{
			this.m.PreviewCraftable.onPaintInCompanyColors();
		}
		else if (this.m.PreviewCraftable.m.ID == "shield.faction_kite_shield" || this.m.PreviewCraftable.m.ID == "shield.heater_kite_shield")
		{
			this.m.PreviewCraftable.setFaction(1);
		}
		local ret = {
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			ImagePath = this.getIcon(),
			LargeImagePath = this.getIconLarge() != null ? this.getIconLarge() : this.getIcon(),
			IconOverlay = this.m.PreviewCraftable.getIconOverlay(),
			Ingredients = this.getIngredients(),
			Cost = this.getCost(),
			IsCraftable = this.isCraftable(),
			Type = this.getItemType()
		};
		if ("Variants" in this.m && this.m.Variants > 0)
		{
			ret.Variants <- this.m.Variants;
			ret.ItemPath <- this.IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash); //this.m.PreviewCraftable;
		}
		else
		{
			ret.Variants <- 0;
			ret.ItemPath <- 0;
		}
		ret.isAmountShown <- this.m.PreviewCraftable.isAmountShown();
		if(this.m.PreviewCraftable.isAmountShown()) ret.Amount <- this.m.PreviewCraftable.getAmountString();
		return ret;
	}

	o.getIngredients = function () {
		local ret = [];
		local itemsMap = {};

		foreach (item in ::World.Assets.getStash().getItems()) {
			if (item == null) {
				continue;
			}

			if (!(item.getID() in itemsMap)) {
				itemsMap[item.getID()] <- 0;
			}
			if ("Uses" in item.m) {
				itemsMap[item.getID()] = itemsMap[item.getID()] + item.m.Uses;
			} else {
				itemsMap[item.getID()] = itemsMap[item.getID()] + 1;
			}
		}

		foreach (c in this.m.PreviewSkills) {
			local groupIDs = [];
			foreach (s in c.Instances) {
				groupIDs.push(s.getID());
			}
			foreach( s in c.Instances )	{
				ret.push({
					InstanceID = s.getID(),
					ImagePath = s.getIconColored(),
					IsMissing = !this.requirementsMet(groupIDs),
					IsSkill = 1
				});
			}
		}

		foreach (i, c in this.m.PreviewComponents) {
			local num = 0;

			if (c.Instance == null) {
				local name = "";

				if (c.Name != null) {
					name = c.Name;
				}

				this.logInfo("ERROR, blueprint instance is null. item name = " + name);
				continue;
			}

			if (c.Instance.getID() in itemsMap) {
				num = itemsMap[c.Instance.getID()];
			}

			ret.push({
				InstanceID = i,
				ImagePath = c.Instance.getIcon(),
				IsMissing = c.Num > num,
				Num = c.Num,
				InvTotal = num,
				IsSkill = 0
			});
		}

		return ret;
	}

	o.craft = function () {
		if (!this.isQualified()) {
			return;
		}

		this.updateAchievement("IMadeThis", 1, 1);
		local stash = ::World.Assets.getStash();

		foreach (c in this.m.PreviewComponents) {
			for (local j = 0; j < c.Num; j++) {
				local item = stash.getItemByID(c.Instance.getID());

				if (::World.Assets.m.ProfessionEffect.LegendThrifty <= 0 || item.getMagicNumber() > ::World.Assets.m.ProfessionEffect.LegendThrifty * 100) {
					if ("Uses" in item.m && item.m.Uses > 1) {
						item.m.Uses -= 1;
					} else {
						stash.remove(item);
					}
				} else {
					item.setMagicNumber(this.Math.rand(1, 100));
				}
			}
		}

		++this.m.TimesCrafted;

		if (::Legends.S.oneOf(this.m.Type, ::Const.Items.ItemType.Ammo, ::Const.Items.ItemType.Armor, ::Const.Items.ItemType.Helmet, ::Const.Items.ItemType.Shield, ::Const.Items.ItemType.Weapon)) {
			::World.Assets.addBusinessReputation(::World.Assets.m.ProfessionEffect.LegendPersonalSeal * this.m.Cost * 0.01);
		}
	
		this.onCraft(stash);
	}

	o.onEnchant <- function (_upgraded) {}
});
