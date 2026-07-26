::mods_hookExactClass("items/shields/shield", function(o) {
	o.m.Variants <- [];
	o.m.IsIndestructible <- false;
	o.m.Block <- 15;
	o.m.RegularDamage <- 10;
	o.m.RegularDamageMax <- 25;

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

		foreach (tooltip in result) {
			if (!tooltip.rawin("id") || !tooltip.rawin("text") || !tooltip.rawin("icon")) {
				continue;
			}

			if (tooltip.id == 7 && tooltip.icon == "ui/icons/fatigue.png") {
				tooltip.text = "Fatigue Weight Penalty [color=%negative%]" + this.m.StaminaModifier + "[/color]"
			}
		}

		if (this.isRuned())
		{
			result.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = this.getRuneSigilTooltip()
			});
			result.push({
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When scrapped, rune will be refunded"
			});
		}

		return result;
	}

	local isDroppedAsLoot = o.isDroppedAsLoot;
	o.isDroppedAsLoot = function ()
	{
		::World.Assets.m.IsBlacksmithed = ::World.Assets.m.ProfessionEffect.LegendMaterialist > 0; // set this to use in the hook cause its not used otherwise no need to reset
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

		if (::Legends.Effects.has(actor, ::Legends.Effect.LegendRssDurability)) {
			if (::Math.rand(0, 100) > this.getRuneBonus2()) {
				applyShieldDamage(_damage, _playHitSound);
			}
		} else {
			applyShieldDamage(_damage, _playHitSound);
		}

		if (this.m.Condition == 0)
		{
			local isPlayer = this.m.LastEquippedByFaction == this.Const.Faction.Player || actor != null && !actor.isNull() && this.isKindOf(actor.get(), "player");
			local isBlacksmithed = isPlayer && !this.Tactical.State.isScenarioMode() && ::World.Assets.m.ProfessionEffect.LegendMaterialist > 0;

			if (!isBlacksmithed && this.isNamed()) // already dropped from vanilla blacksmithed
			{
				this.drop(actor.getTile());
			}
		}
	}

	o.updateRuneSigil <- function () {
		if (this.isRuned()) {
			local rune = ::Legends.Runes.get(this.getRuneVariant());
			// remove extra durability when rune is replaced
			if (rune.Effect == ::Legends.Effect.LegendRssDurability) {
				local extraDurability = this.getFlags().getAsInt(rune.Flag);
				this.m.Condition = ::Math.max(1, this.m.Condition - extraDurability);
				this.m.ConditionMax -= extraDurability;
				this.updateAppearance();
			}
		}
		this.item.updateRuneSigil();
	}

	o.getBlock <- function () {
		return this.m.Block;
	}

	local onUpdateProperties = o.onUpdateProperties;
	o.onUpdateProperties = function (_properties) {
		onUpdateProperties(_properties);
		_properties.Block = this.getBlock();
	}

	o.onDeserialize = function ( _in ) {
		this.item.onDeserialize(_in);
		if (!this.isNamed() && this.isRuned()) {
			local rune = ::Legends.Runes.get(this.getRuneVariant());

			if (rune != null && rune.Effect == ::Legends.Effect.LegendRssDurability) {
				this.m.ConditionMax += this.getFlags().getAsInt(rune.Flag);
			}
		}
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition);

		if (this.isRuned())
		{
			this.item.updateRuneSigil();
		}
	}
});
