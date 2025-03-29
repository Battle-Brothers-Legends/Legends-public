::mods_hookExactClass("items/supplies/food_item", function(o) {
	o.m.AddGenericSkill <- true;
	o.m.StaminaModifier <- 0;
	o.m.StashModifier <- 0;
	o.m.IsRandomized <- false;
	o.m.MaxStack <- 0;

	o.isDesirable = function ()
	{
		return this.m.IsUndesirable;
	}

	o.getValue = function ()
	{
		if(this.m.IsRandomized){
			return this.Math.floor(this.m.Amount / this.m.MaxStack * (this.getSpoilInDays() / (this.m.GoodForDays * 1.0)) * this.m.Value);
		}
		return this.Math.floor(1 * (this.getSpoilInDays() / (this.m.GoodForDays * 1.0)) * this.m.Value);
	}

	o.randomizeAmount = function ()
	{
		this.m.IsRandomized = true;
		this.m.MaxStack = this.m.Amount;
		this.m.Amount = this.Math.rand(this.Math.ceil(this.m.MaxStack * 0.4), this.m.MaxStack);
	}

	o.create = function ()
	{
		this.item.create();
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.ItemType = this.Const.Items.ItemType.Food;
		this.m.Amount = 25.0;
		this.m.IsDroppedAsLoot = true;
		this.m.IsChangeableInBattle = true;
		this.m.IsAllowedInBag = true;
	}

	o.onEquip <- function ()
	{
		this.item.onEquip();

		if (this.m.AddGenericSkill)
		{
			this.addGenericItemSkill();
		}

			if (this.World.State.getPlayer() == null)
			{
				return;
			}

		if (this.m.StashModifier > 0)
		{
			this.World.State.getPlayer().calculateStashModifier();
		}

	}

	o.onUnequip <- function ()
	{
		this.item.onUnequip();

			if (this.World.State.getPlayer() == null)
			{
				return;
			}

		if (this.m.StashModifier > 0)
		{
			this.World.State.getPlayer().calculateStashModifier();
		}

	}

	o.getStaminaModifier <- function ()
	{
		return this.m.StaminaModifier;
	}

	o.getStashModifier <- function ()
	{
		return this.m.StashModifier;
	}

	o.onUpdateProperties <- function ( _properties )
	{
	}
});
