::mods_hookExactClass("items/armor/armor", function(o) {
	o.onRepair <- function ( _a)
	{
		this.setArmor(_a);
		return 0;
	}

	o.getIconOverlay = function ()
	{
		return this.m.Upgrade != null ? [this.m.Upgrade.getOverlayIcon()] : [""];
	}

	o.getIconLargeOverlay = function ()
	{
		return this.m.Upgrade != null ? [this.m.Upgrade.getOverlayIconLarge()] : [""];
	}

	o.getValue = function ()
	{
		return this.Math.floor(this.m.Value * ((1.0 * this.m.Condition) / (1.0 * this.m.ConditionMax)) + (this.m.Upgrade != null ? this.m.Upgrade.getValue() : 0));
	}

	o.removeUpgrade <- function  ( _slot )
	{
		if (this.m.Upgrade == null)
		{
			return null
		}
		local item = this.m.Upgrade;
		this.setUpgrade(null);
		return item;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local result = getTooltip();

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
		}

		return result;
	}

	o.isDroppedAsLoot = function ()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		if (this.isNamed())
		{
			return true;
		}

		local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getContainer() != null && this.getContainer().getActor() != null && !this.getContainer().getActor().isNull() && this.isKindOf(this.getContainer().getActor().get(), "player");
		local isLucky = !this.Tactical.State.isScenarioMode() && !isPlayer && this.World.Assets.getOrigin().isDroppedAsLoot(this);
		local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && this.World.Assets.m.IsBlacksmithed;

		if (this.m.Condition > 10 && isPlayer || this.m.Condition > 30 && this.m.Condition / this.m.ConditionMax >= 0.25 || isLucky || isBlacksmithed)
		{
			return true;
		}

		return false;
	}

	o.upgradeIsBlocked <- function (_slot)
	{
		return true;
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}
});
