::mods_hookExactClass("items/legend_helmets/helm/legend_helmet_skin_helm", function(o) {

	o.getTooltip <- function ()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Regenerates itself by [color=%positive%]90[/color] points of durability each turn."
		});
		return result;
	}

	o.onArmorTooltip <- function (_result)
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Regenerates itself by [color=%positive%]90[/color] points of durability each turn."
		});
	}

	o.onCombatFinished <- function()
	{
		local helmet = this.getContainer().getItemAtSlot(this.Const.ItemSlot.Head);
		helmet.setArmor(helmet.getArmorMax());
		this.getContainer().updateAppearance();
	}


	o.onTurnStart <- function()
	{
		local helmet = this.getContainer().getItemAtSlot(this.Const.ItemSlot.Head);
		local armorRepaired = this.Math.min(helmet.getArmorMax() - helmet.getArmor(), 90.0);
		if (armorRepaired < 0)
			return;
		helmet.setArmor(helmet.getArmor() + armorRepaired);
		this.getContainer().getActor().setDirty(true);
		this.getContainer().updateAppearance();
	}
});
