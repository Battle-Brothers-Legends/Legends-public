::mods_hookExactClass("items/shields/shield", function(o) {
	o.m.Variants <- [];
	o.m.IsIndestructible <- false;

	o.getIconOverlay <- function ()
	{
		if (this.isRuned())
		{
			return [
				"layers/glow_runed_icon.png"
			];
		}

		return [
			""
		];
	}

	o.getIconLargeOverlay <- function ()
	{
		if (this.isRuned())
		{
			return [
				"layers/glow_runed_inventory.png"
			];
		}

		return [
			""
		];
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

	local isDroppedAsLoot = o.isDroppedAsLoot;
	o.isDroppedAsLoot = function ()
	{
		if (this.item.isDroppedAsLoot() && this.isNamed())
		{
			return true;
		}

		return isDroppedAsLoot();
	}

	local applyShieldDamage = o.applyShieldDamage;
	o.applyShieldDamage = function ( _damage, _playHitSound = true )
	{
		local actor = this.getContainer().getActor();

		applyShieldDamage ( _damage, _playHitSound = true );

		if (this.m.Condition == 0)
		{
			local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || actor != null && !actor.isNull() && this.isKindOf(actor.get(), "player");
			local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && (this.isNamed() || this.World.Assets.m.IsBlacksmithed);
			if (isBlacksmithed)
			{
				this.drop(actor.getTile());
			}
		}
	}

	o.onDeserialize = function ( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition);

		if (this.isRuned())
		{
			this.updateRuneSigil();
		}
	}
});
