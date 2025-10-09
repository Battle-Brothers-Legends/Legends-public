::mods_hookBaseClass("items/item", function ( o )
{
	while(!("ItemType" in o.m)) o=o[o.SuperName];

	o.m.OldID <- "";
	o.m.MedicinePerDay <- 0;
	o.m.IsToBeRepairedQueue <- 0;
	o.m.IsToBeSalvagedQueue <- 0;
	o.m.IsToBeSalvaged <- false;
	o.m.ResourceValue <- 0;
	o.m.Type <- -1;
	o.m.OriginSettlementID <- 0; // the Settlement ID where the item was originally produced
	o.m.TradeHistorySettlementIDs <- []; // an array of Settlement IDs to track the item's trade history
	o.m.LastTransactionPrice <- null;
	o.m.IsQueryingSellPrice <- 0;
	o.m.IsQueryingBuyPrice <- 0;

	local setSold = o.setSold;
	o.setSold = function (_f) {
		setSold(_f);
		this.m.IsSold = _f;
	}

	local setBought = o.setBought;
	o.setBought = function (_f) {
		setBought(_f);
		this.m.IsBought = _f;
	}

	o.getOldInstanceID <- function ()
	{
		return this.m.OldID;
	}

	o.getIconOverlay = function ()
	{
		return [""];
	}

	o.getIconLargeOverlay = function ()
	{
		return [""];
	}

	o.getType <- function ()
	{
		return this.m.Type;
	}

	o.isDroppedAsLoot = function ()
	{
		return this.m.IsDroppedAsLoot || this.isNamed();
	}

	o.isToBeRepaired = function ()
	{
		return this.m.IsToBeRepaired;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.isToBeRepairedQ <- function ()
	{
		return this.m.IsToBeRepairedQueue;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.isToBeSalvaged <- function ()
	{
		return this.m.IsToBeSalvaged;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.isToBeSalvagedQ <- function ()
	{
		return this.m.IsToBeSalvagedQueue;
		//return this.m.CurrentSlotType != this.Const.ItemSlot.None && this.getCondition() < this.getConditionMax() || this.m.IsToBeRepaired;
	}

	o.setToBeRepaired = function ( _r, _idx = 0 )
	{
		if (_r && this.getRepair() == this.getRepairMax())
		{
			this.m.IsToBeRepairedQueue = 0;
			return false;
		}

		this.m.IsToBeRepaired = _r;
		this.m.IsToBeRepairedQueue = _idx;
		return true;
	}

	o.setToBeSalvaged <- function ( _r, _idx )
	{
		if (_r && this.getRepair() <= 0)
		{
			this.m.IsToBeSalvagedQueue = 0;
			return false;
		}

		this.m.IsToBeSalvaged = _r;
		this.m.IsToBeSalvagedQueue = _idx;
		return true;
	}

	o.canBeSalvaged <- function ()
	{
		return ((this.getItemType() & this.Const.Items.ItemType.Weapon) != 0) || (this.getItemType() & this.Const.Items.ItemFilter.Armor) != 0
	}

	o.getRepair <- function ()
	{
		return this.Math.floor(this.m.Condition);
	}

	o.getRepairMax <- function ()
	{
		return this.Math.floor(this.m.ConditionMax);
	}

	o.getRawValue <- function ()
	{
		return this.m.Value;
	}

	o.setArmor <- function ( _a )
	{
		this.setCondition( _a)
	}

	o.onRepair <- function ( _a)
	{
		this.setArmor(_a);
		return 0;
	}

	o.setTransactionPrice <- function (_price) {
		this.m.LastTransactionPrice = _price;
		if (_price == null) {
			this.m.IsSold = false;
			this.m.IsBought = false;
		}
	}

	o.getBuyPrice = function ()
	{
		local itemID = this.getID();
		if (this.isSold())
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * this.Const.Difficulty.BuyPriceMult[this.World.Assets.getEconomicDifficulty()]));
		}
		else
		{
			return this.Math.ceil(this.getValue() * this.getPriceMult());
		}
	}

	o.getSellPrice = function ()
	{
		local itemID = this.getID();
		if (this.isBought())
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.getSellPriceMult() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
		}
	}

	o.setGarbage <- function ()
	{
		this.m.IsGarbage = true;
	}

	o.onUnequip = function ()
	{
		this.clearSkills();
		if (this.m.Container != null && ("getSkills" in this.getContainer().getActor())) this.getContainer().getActor().getSkills().update();
		maybeUpdateParryingDaggerSkills();
	}

	// Parrying dagger may hide its skills when the main hand weapon is stronger.
	// So when the main hand is unequipped, we check if we have to re-add the skills.
	function maybeUpdateParryingDaggerSkills() {
		// Check we are not a parrying dagger (otherwise this will stack overflow)
		if (isParryingDagger(this)) {
			return;
		}
		local container = getContainer();
		if (container == null || !("getActor" in container)) {
			return;
		}
		local actor = container.getActor();
		if (actor == null || !("getOffhandItem" in actor)) {
			return;
		}
		local offhand = actor.getOffhandItem();
		if (!isParryingDagger(offhand)) {
			return;
		}
		offhand.onUnequip();
		offhand.onEquip();
	}

	function isParryingDagger(_item) {
		if (_item == null || !("m" in _item)) {
			return false;
		}
		return _item.m.ID == "shield.legend_parrying_dagger"
			|| _item.m.ID == "shield.legend_named_parrying_dagger";
	}

	o.onEquip = function ()
	{
		if (this.m.Container != null)
		{
			if (this.m.Container.getActor() != null) this.m.LastEquippedByFaction = this.m.Container.getActor().getFaction();
			if ("getSkills" in this.getContainer().getActor()) this.getContainer().getActor().getSkills().update();
		}
		if (this.isRuned())
		{
			this.onEquipRuneSigil();
		}

		if (this.isToBeSalvaged())
		{
			this.setToBeSalvaged(false, 0);
		}
	}

	local onPutIntoBag = o.onPutIntoBag;
	o.onPutIntoBag = function () {
		if (this.m.Container != null) {
			if (this.m.Container.getActor() != null) {
				this.m.LastEquippedByFaction = this.m.Container.getActor().getFaction();
			}
		}
		onPutIntoBag();
	}

	o.onEquipRuneSigil <- function ()
	{
		local def = ::Legends.Runes.get(this.getRuneVariant());
		if (def == null)
			return;
		this.addSkill(::Legends.Effects.new(def.Effect));
	}

	o.getRuneSigilTooltip <- function ()
	{
		local def = ::Legends.Runes.get(this.getRuneVariant());
		if (def == null)
			return "This item is inscribed with a rune sigil, even though it shouldn't have been: please report this bug. Variant = " + this.getRuneVariant();
		return def.getTooltip(this);
	}

	o.setRuneBonus <- function ( _bonus = false) {
		local def = ::Legends.Runes.get(this.getRuneVariant());
		if (def == null)
			return;
		def.setRuneBonus(this, _bonus);
	}

	o.updateRuneSigilToken <- function() {
		local def = ::Legends.Runes.get(this.getRuneVariant());
		if (def == null) {
			this.m.Name = "Unknown Rune Sigil: Error";
			this.m.Description = "An inscribed rock that cannot be attached to a character\'s equipment.";
			this.m.Icon = "rune_sigils/legend_vala_rune_sigil_blank.png";
			this.m.IconLarge = "rune_sigils/legend_vala_rune_sigil_blank.png";
		} else {
			this.m.Name = def.Name;
			this.m.Description = def.Description;
			this.m.Icon = def.Icon;
			this.m.IconLarge = def.IconLarge;
		}
	}

	o.setRuneVariant <- function (_rune) {
		this.getFlags().set("LegendsRuneVariant", _rune);
	}

	o.getRuneVariant <- function ()	{
		return this.getFlags().getAsInt("LegendsRuneVariant");
	}

	o.setRuneBonus1 <- function (_mult)	{
		this.getFlags().set("LegendsRuneBonus1", _mult);
	}

	o.getRuneBonus1 <- function () {
		return this.getFlags().getAsInt("LegendsRuneBonus1");
	}

	o.setRuneBonus2 <- function (_mult) {
		this.getFlags().set("LegendsRuneBonus2", _mult);
	}

	o.getRuneBonus2 <- function () {
		return this.getFlags().getAsInt("LegendsRuneBonus2");
	}

	o.isRuned <- function () {
		return this.getRuneVariant() > 0;
	}

	o.updateRuneSigil <- function ()
	{
		// local iconLargeParts = split(this.m.IconLarge, "/");
		// local iconParts = split(this.m.Icon, "/");
		// local text = ""
		// if(this.m.IconLarge.find("runed_") == null) {
		// 	for (local i = 0; i < iconLargeParts.len(); i = ++i)
		// 	{
		// 		if (i == iconLargeParts.len() - 1)
		// 		{
		// 			text = text + "runed_" + iconLargeParts[i]
		// 		} else {
		// 			text = text + iconLargeParts[i] + "/";
		// 		}
		// 	}
		// 	this.m.IconLarge = text;
		// }
		// if(this.m.Icon.find("runed_") == null) {
		// 	text = ""
		// 	for (local i = 0; i < iconParts.len(); i = ++i)
		// 	{
		// 		if (i == iconParts.len() - 1)
		// 		{
		// 			text = text + "runed_" + iconParts[i]
		// 		} else {
		// 			text = text + iconParts[i] + "/";
		// 		}
		// 	}
		// 	this.m.Icon = text;
		// }
		if (this.m.Name.find("(Runed)") == null)
		{
			this.m.Name =  this.m.Name + "[color=" + this.Const.UI.Color.RuneColor + "] (Runed)[/color]";
		}
	}

	o.onNewDay <- function ()
	{
	}

	o.getMedicinePerDay <- function ()
	{
		return this.m.MedicinePerDay;
	}

	o.getUpgrades <- function ()
	{
		return [];
	}

	o.getLootLayers <- function ()
	{
		return [this];
	}

	o.getResourceValue <- function ()
	{
		return this.m.ResourceValue;
	}

	o.isNamed <- function ()
	{
		if (this.isItemType(this.Const.Items.ItemType.Named))
			return true;
		if (this.isItemType(this.Const.Items.ItemType.Legendary))
			return true;
		return false
	}


	o.onPaint <- function ( _color )
	{
	}

	o.getOriginSettlementID <- function ()
	{
		return this.m.OriginSettlementID;
	}

	o.getOriginSettlement <- function ()
	{
		return ::World.getEntityByID(this.m.OriginSettlementID);
	}

	o.getTradeHistorySettlementIDs <- function ()
	{
		return this.m.TradeHistorySettlementIDs;
	}

	o.getTradeHistorySettlements <- function ()
	{
		return this.m.TradeHistorySettlementIDs.map(function(id){return ::World.getEntityByID(id)});
	}

	o.setOriginSettlementID <- function ( _id )
	{
		this.m.OriginSettlementID = _id;
	}

	o.setOriginSettlement <- function ( _settlement )
	{
		this.setOriginSettlementID( _settlement.getID());
	}

	o.addSettlementIDToTradeHistory <- function ( _id )
	{
		if (_id != this.getOriginSettlementID() && (this.m.TradeHistorySettlementIDs.len() < 1 || _id != this.m.TradeHistorySettlementIDs[this.m.TradeHistorySettlementIDs.len()-1]))
		{
			this.m.TradeHistorySettlementIDs.push(_id);
		}
	}

	o.addSettlementToTradeHistory <- function ( _settlement )
	{
		this.addSettlementIDToTradeHistory(_settlement.getID());
	}

	// for items that slings are able to throw
	o.onSlingUpdateProperties <- function () {}

	local onSerialize = o.onSerialize;
	o.onSerialize = function ( _out )
	{
		onSerialize(_out);
		_out.writeString(this.getInstanceID()); //Need old ID for saved formations
		_out.writeBool(this.m.IsToBeSalvaged);
		_out.writeU16(this.m.IsToBeRepairedQueue);
		_out.writeU16(this.m.IsToBeSalvagedQueue);
		_out.writeI32(this.m.OriginSettlementID);
		::MSU.Serialization.serialize(this.m.TradeHistorySettlementIDs, _out);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function ( _in )
	{
		onDeserialize(_in);
		this.m.OldID = _in.readString();
		this.m.IsToBeSalvaged = _in.readBool();
		this.m.IsToBeRepairedQueue = _in.readU16();
		this.m.IsToBeSalvagedQueue = _in.readU16();
		this.m.OriginSettlementID = _in.readI32();
		this.m.TradeHistorySettlementIDs = ::MSU.Serialization.deserialize(_in);
		this.updateVariant();
	}
});
