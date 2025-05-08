::mods_hookExactClass("entity/world/settlements/buildings/tavern_building", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = ::MSU.Array.rand([
			"The Catchpole",
			"The Mother Black",
			"The Ratcatcher",
			"Coachman\'s Inn",
			"Highwayman\'s Rest",
			"The Black Baron",
			"The Padfoot\'s Arms",
			"The Leaking Ghoul",
			"The Henhouse Tavern",
			"The Wurmtail Inn",
			"The Last March",
			"The First Rest",
			"The Last Rest",
			"The Gatehouse",
			"The Giblet",
			"The Drunk Nobleman",
			"The Scarlet Maiden",
			"The Pit",
			"The Artroom",
			"Crossroads Inn",
			"The Nobleman\'s Demise",
			"Trapper Tavern",
			"Pilgrim\'s Rest",
			"The Raging Greenskin",
			"The Ploughman",
			"The Frail Thief",
			"Hollow Heart Inn",
			"The Cutpurse",
			"The Black Hag",
			"Drifter\'s Rest",
			"The Swillbucket",
			"Lilac Donkey Inn",
			"The Huntsmarshal"
		]);
	}

	local getRumorPrice = o.getRumorPrice;
	o.getRumorPrice = function()
	{
		local price = getRumorPrice();

		if (::World.Assets.getOrigin().getID() == "scenario.legends_troupe")
			price = ::Math.round(price * 0.5);

		return price;
	}

	local getDrinkPrice = o.getDrinkPrice;
	o.getDrinkPrice = function()
	{
		local price = getDrinkPrice();

		if (::World.Assets.getOrigin().getID() == "scenario.legends_troupe")
			price = ::Math.round(price * 0.5);

		return price;
	}

	o.getDrinkResult = function ()
	{
		local bros = this.World.getPlayerRoster().getAll();

		if (this.World.Assets.getMoney() < this.Math.round(bros.len() * 5 * this.m.Settlement.getBuyPriceMult()))
		{
			return null;
		}

		this.Sound.play(this.Const.Sound.TavernRound[this.Math.rand(0, this.Const.Sound.TavernRound.len() - 1)]);
		this.World.Assets.addMoney(this.Math.round(bros.len() * -5 * this.m.Settlement.getBuyPriceMult()));
		++this.m.RoundsGiven;
		this.m.LastRoundTime = this.Time.getVirtualTimeF();
		local result = {
			Intro = this.Const.Strings.PayTavernRoundIntro[this.Math.rand(0, this.Const.Strings.PayTavernRoundIntro.len() - 1)],
			Result = []
		};

		foreach( b in bros )
		{
			if (result.Result.len() >= 5)
			{
				break;
			}

			local drunkChance = (this.m.RoundsGiven - 1) * 10;
			if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
			{
			drunkChance = drunkChance * 0.5;
			}

			if (!b.getSkills().hasEffect(::Legends.Effect.Drunk))
			{
				if (b.getSkills().hasTrait(::Legends.Trait.Drunkard))
				{
					drunkChance = drunkChance + 20;
				}

				if (b.getSkills().hasTrait(::Legends.Trait.Strong))
				{
					drunkChance = drunkChance - 10;
				}

				if (b.getSkills().hasTrait(::Legends.Trait.Tough))
				{
					drunkChance = drunkChance - 10;
				}

				if (b.getSkills().hasTrait(::Legends.Trait.Fragile))
				{
					drunkChance = drunkChance + 10;
				}

				if (b.getSkills().hasTrait(::Legends.Trait.Tiny))
				{
					drunkChance = drunkChance + 10;
				}

				if (b.getSkills().hasTrait(::Legends.Trait.Bright))
				{
					drunkChance = drunkChance - 10;
				}
				else if (b.getSkills().hasTrait(::Legends.Trait.Dumb))
				{
					drunkChance = drunkChance + 10;
				}
			}
			else
			{
				drunkChance = 0;
				if (!b.getSkills().hasTrait(::Legends.Trait.Drunkard))
				{
					if (this.Math.rand(1, 100) <= this.m.RoundsGiven + 5)
					{
						::Legends.Traits.grant(b, ::Legends.Trait.Drunkard, function(_trait) {
							result.Result.push({
								Icon = _trait.getIcon(),
								Text = b.getName() + " is now a drunkard."
							});
						}.bindenv(this));
					}
				}
			}

			if (this.Math.rand(1, 100) <= drunkChance)
			{
				::Legends.Effects.grant(b, ::Legends.Effect.Drunk, function(_effect) {
					result.Result.push({
						Icon = _effect.getIcon(),
						Text = b.getName() + " is now drunk."
					});
				}.bindenv(this));
			}

			if ((b.getLastDrinkTime() == 0 || this.Time.getVirtualTimeF() - b.getLastDrinkTime() > this.World.getTime().SecondsPerDay) && this.Math.rand(1, 100) <= 35)
			{
				b.setLastDrinkTime(this.Time.getVirtualTimeF());
				b.improveMood(this.Const.MoodChange.DrunkAtTavern, "Got drunk with the company");
				result.Result.push({
					Icon = this.Const.MoodStateIcon[b.getMoodState()],
					Text = b.getName() + this.Const.MoodStateEvent[b.getMoodState()]
				});
			}
		}

		return result;
	}

	local buildText = o.buildText;
	o.buildText = function (_text) {
		local text = buildText(_text);
		local vars = [
			[
				"direction_settlement",
				this.m.ContractSettlement != null && !this.m.ContractSettlement.isNull() ? this.Const.Strings.Direction8[this.m.Settlement.getTile().getDirection8To(this.m.ContractSettlement.getTile())] : ""
			],
		];
		return this.buildTextFromTemplate(text, vars);
	}
});
