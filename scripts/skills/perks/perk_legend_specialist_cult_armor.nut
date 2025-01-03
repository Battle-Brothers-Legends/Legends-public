this.perk_legend_specialist_cult_armor <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecCultArmor);
		this.m.Description = "This character is gaining increased Maximum Damage because of adjacent opponents.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getDamageBonus() == 0 && this.getResolveBonus() == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		if (!("getActor" in this.getContainer())) {
			// todo something about it? idk what, but tooltip on crafting screen goes here - chopeks
			return ret;
		}
		local damageBonus = this.getDamageBonus();
		if (damageBonus != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + (damageBonus * 100) + "%[/color] of equipped weapon's Maximum Damage as additional Maximum Damage"
			});
		}

		local resolveBonus = this.getResolveBonus();
		if (resolveBonus != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + resolveBonus + "[/color] Resolve due to missing health and wearing cultist items"
			});
		}

		return ret;
	}

	function getDamageBonus()
	{
		local actor = this.getContainer().getActor();
		return !actor.isPlacedOnMap() ? 0 : ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1).len() * 0.05;
	}

	function getResolveBonus()
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local cultItems = [];
		if (item != null)
		{
			if (item.isItemType(this.Const.Items.ItemType.Cultist)) {
				cultItems.push(item);
			}

			foreach (upgrade in item.m.Upgrades)
			{
				if (upgrade != null && upgrade.isItemType(this.Const.Items.ItemType.Cultist)) cultItems.push(upgrade);
			}
		}

		if (cultItems.len() > 0)
		{
			return this.Math.floor((actor.getHitpointsMax() - actor.getHitpoints()) * 0.75);
		}

		return 0;
	}

	function onAfterUpdate( _properties )
	{
		_properties.Bravery += this.getResolveBonus();

		local damageBonus = this.getDamageBonus();
		if (damageBonus != 0)
		{
			local item = this.getContainer().getActor().getMainhandItem();
			if (item != null)
			{
				_properties.DamageRegularMax += item.m.RegularDamageMax * damageBonus;
			}
		}
	}

});
