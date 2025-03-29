::mods_hookExactClass("ambitions/ambitions/have_all_provisions_ambition", function(o)
{
	o.getTooltipText = function ()
	{
		if (this.hasAllProvisions())
		{
			return this.m.TooltipText;
		}

		local fish = false;
		local beer = false;
		local bread = false;
		local cured_venison = false;
		local dried_fish = false;
		local dried_fruits = false;
		local goat_cheese = false;
		local ground_grains = false;
		local mead = false;
		local mushrooms = false;
		local berries = false;
		local smoked_ham = false;
		local wine = false;
		local cured_rations = false;
		local dates = false;
		local rice = false;
		local dried_lamb = false;
		local legend_fresh_fruit = false;
		local legend_fresh_meat = false;
		local legend_pie = false;
		local legend_porridge = false;
		local legend_pudding = false;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (item.getID() == "supplies.beer")
				{
					beer = true;
				}
				else if (item.getID() == "supplies.bread")
				{
					bread = true;
				}
				else if (item.getID() == "supplies.cured_venison")
				{
					cured_venison = true;
				}
				else if (item.getID() == "supplies.dried_fish")
				{
					dried_fish = true;
				}
				else if (item.getID() == "supplies.dried_fruits")
				{
					dried_fruits = true;
				}
				else if (item.getID() == "supplies.goat_cheese")
				{
					goat_cheese = true;
				}
				else if (item.getID() == "supplies.ground_grains")
				{
					ground_grains = true;
				}
				else if (item.getID() == "supplies.mead")
				{
					mead = true;
				}
				else if (item.getID() == "supplies.pickled_mushrooms")
				{
					mushrooms = true;
				}
				else if (item.getID() == "supplies.roots_and_berries")
				{
					berries = true;
				}
				else if (item.getID() == "supplies.smoked_ham")
				{
					smoked_ham = true;
				}
				else if (item.getID() == "supplies.wine")
				{
					wine = true;
				}
				else if (item.getID() == "supplies.dates")
				{
					dates = true;
				}
				else if (item.getID() == "supplies.rice")
				{
					rice = true;
				}
				else if (item.getID() == "supplies.dried_lamb")
				{
					dried_lamb = true;
				}
				else if (item.getID() == "supplies.cured_rations")
				{
					cured_rations = true;
				}
				else if (item.getID() == "supplies.legend_fresh_fruit")
				{
					legend_fresh_fruit = true;
				}
				else if (item.getID() == "supplies.legend_fresh_meat")
				{
					legend_fresh_meat = true;
				}
				else if (item.getID() == "supplies.legend_pie")
				{
					legend_pie = true;
				}
				else if (item.getID() == "supplies.legend_porridge")
				{
					legend_porridge = true;
				}
				else if (item.getID() == "supplies.legend_pudding")
				{
					legend_pudding = true;
				}
			}
		}

		local ret = this.m.TooltipText + "\n\nYou\'re currently lacking some provisions.\n";

		if (!beer)
		{
			ret = ret + "\n- Beer";
		}

		if (!bread)
		{
			ret = ret + "\n- Bread";
		}

		if (!cured_venison)
		{
			ret = ret + "\n- Cured Venison";
		}

		if (!dried_fish)
		{
			ret = ret + "\n- Dried Fish";
		}

		if (!dried_fruits)
		{
			ret = ret + "\n- Dried Fruits";
		}

		if (!ground_grains)
		{
			ret = ret + "\n- Ground Grains";
		}

		if (!goat_cheese)
		{
			ret = ret + "\n- Goat Cheese";
		}

		if (!mead)
		{
			ret = ret + "\n- Mead";
		}

		if (!mushrooms)
		{
			ret = ret + "\n- Mushrooms";
		}

		if (!berries)
		{
			ret = ret + "\n- Roots and Berries";
		}

		if (!smoked_ham)
		{
			ret = ret + "\n- Smoked Ham";
		}

		if (!wine)
		{
			ret = ret + "\n- Wine";
		}

		if (!cured_rations)
		{
			ret = ret + "\n- Cured Rations";
		}

		if (!legend_fresh_fruit)
		{
			ret = ret + "\n- Fresh Fruit";
		}

		if (!legend_fresh_meat)
		{
			ret = ret + "\n- Fresh Meat";
		}

		if (!legend_pie)
		{
			ret = ret + "\n- Pie";
		}

		if (!legend_porridge)
		{

			ret = ret + "\n- Porridge";
		}
		if (!legend_pudding)
		{
			ret = ret + "\n- Pudding";
		}

		if (!dates)
		{
			ret = ret + "\n- Dates";
		}

		if (!rice)
		{
			ret = ret + "\n- Rice";
		}

		if (!dried_lamb)
		{
			ret = ret + "\n- Dried Lamb";
		}

		return ret;
	}

	o.hasAllProvisions = function ()
	{
		local beer = false;
		local bread = false;
		local cured_venison = false;
		local dried_fish = false;
		local dried_fruits = false;
		local goat_cheese = false;
		local ground_grains = false;
		local mead = false;
		local mushrooms = false;
		local berries = false;
		local smoked_ham = false;
		local wine = false;
		local cured_rations = false;
		local dates = false;
		local rice = false;
		local dried_lamb = false;
		local legend_fresh_fruit = false;
		local legend_fresh_meat = false;
		local legend_pie = false;
		local legend_porridge = false;
		local legend_pudding = false;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (item.getID() == "supplies.beer")
				{
					beer = true;
				}
				else if (item.getID() == "supplies.bread")
				{
					bread = true;
				}
				else if (item.getID() == "supplies.cured_venison")
				{
					cured_venison = true;
				}
				else if (item.getID() == "supplies.dried_fish")
				{
					dried_fish = true;
				}
				else if (item.getID() == "supplies.dried_fruits")
				{
					dried_fruits = true;
				}
				else if (item.getID() == "supplies.goat_cheese")
				{
					goat_cheese = true;
				}
				else if (item.getID() == "supplies.ground_grains")
				{
					ground_grains = true;
				}
				else if (item.getID() == "supplies.mead")
				{
					mead = true;
				}
				else if (item.getID() == "supplies.pickled_mushrooms")
				{
					mushrooms = true;
				}
				else if (item.getID() == "supplies.roots_and_berries")
				{
					berries = true;
				}
				else if (item.getID() == "supplies.smoked_ham")
				{
					smoked_ham = true;
				}
				else if (item.getID() == "supplies.wine")
				{
					wine = true;
				}
				else if (item.getID() == "supplies.dates")
				{
					dates = true;
				}
				else if (item.getID() == "supplies.rice")
				{
					rice = true;
				}
				else if (item.getID() == "supplies.dried_lamb")
				{
					dried_lamb = true;
				}
				else if (item.getID() == "supplies.cured_rations")
				{
					cured_rations = true;
				}
				else if (item.getID() == "supplies.legend_fresh_fruit")
				{
					legend_fresh_fruit = true;
				}
				else if (item.getID() == "supplies.legend_fresh_meat")
				{
					legend_fresh_meat = true;
				}
				else if (item.getID() == "supplies.legend_pie")
				{
					legend_pie = true;
				}
				else if (item.getID() == "supplies.legend_porridge")
				{
					legend_porridge = true;
				}
				else if (item.getID() == "supplies.legend_pudding")
				{
					legend_pudding = true;
				}
			}
		}

		local hasLegend = legend_fresh_fruit && legend_fresh_meat && legend_pie && legend_porridge && legend_pudding;

		return beer && bread && cured_venison && dried_fish && dried_fruits && goat_cheese && ground_grains && mead && mushrooms && berries && smoked_ham && wine && cured_rations && dates && rice && dried_lamb && hasLegend;
	}

});
