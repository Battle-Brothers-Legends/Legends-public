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
		local bros = ::World.getPlayerRoster().getAll();

		if (::World.Assets.getMoney() < this.Math.round(bros.len() * 5 * this.m.Settlement.getBuyPriceMult()))
		{
			return null;
		}

		this.Sound.play(::Const.Sound.TavernRound[this.Math.rand(0, ::Const.Sound.TavernRound.len() - 1)]);
		::World.Assets.addMoney(this.Math.round(bros.len() * -5 * this.m.Settlement.getBuyPriceMult()));
		++this.m.RoundsGiven;
		this.m.LastRoundTime = ::Time.getVirtualTimeF();
		local result = {
			Intro = ::Const.Strings.PayTavernRoundIntro[this.Math.rand(0, ::Const.Strings.PayTavernRoundIntro.len() - 1)],
			Result = []
		};

		foreach( b in bros )
		{
			if (result.Result.len() >= 5)
			{
				break;
			}

			local drunkChance = (this.m.RoundsGiven - 1) * 10;
			if (::World.Assets.getOrigin().getID() == "scenario.legends_troupe")
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

			if ((b.getLastDrinkTime() == 0 || ::Time.getVirtualTimeF() - b.getLastDrinkTime() > ::World.getTime().SecondsPerDay) && this.Math.rand(1, 100) <= 35)
			{
				b.setLastDrinkTime(::Time.getVirtualTimeF());
				b.improveMood(::Const.MoodChange.DrunkAtTavern, "Got drunk with the company");
				result.Result.push({
					Icon = ::Const.MoodStateIcon[b.getMoodState()],
					Text = b.getName() + ::Const.MoodStateEvent[b.getMoodState()]
				});
			}
		}

		return result;
	}

	o.getRumor = function (_isPaidFor = false) {
		if (_isPaidFor) {
			if (::World.Assets.getMoney() < this.Math.round(20 * this.m.Settlement.getBuyPriceMult())) {
				return null;
			}

			::World.Assets.addMoney(this.Math.round(-20 * this.m.Settlement.getBuyPriceMult()));
			++this.m.RumorsGiven;
			this.Sound.play(::Const.Sound.TavernRumor[this.Math.rand(0, ::Const.Sound.TavernRumor.len() - 1)]);
		}

		if (this.m.RumorsGiven > ::Math.round(3 * ::World.Assets.m.ProfessionEffect.LegendCarouser)) {
			if (_isPaidFor) {
				return "The patrons raise their cups to you, but it seems there is nothing more to be learned by talking to them tonight.";
			} else {
				return "The patrons talk about this and that.";
			}
		} else {
			this.m.LastRumorTime = ::Time.getVirtualTimeF();
			local rumor = "";

			if (_isPaidFor) {
				if (!this.m.Settlement.isMilitary()) {
					::World.FactionManager.getFaction(this.m.Settlement.getFactions()[0]).addPlayerRelation(0.1);
				}

				rumor = rumor + ::Const.Strings.PayTavernRumorsIntro[this.Math.rand(0, ::Const.Strings.PayTavernRumorsIntro.len() - 1)];
			} else if (this.m.LastRumor != "") {
				return this.m.LastRumor;
			} else {
				rumor = rumor + "The patrons talk about this and that.";
			}

			local candidates = [];
			local r = ::World.Assets.m.ProfessionEffect.LegendCarouser > 0 ? this.Math.rand(3, 6) : this.Math.rand(1, 6);

			if (r <= 2) {
				if (::World.FactionManager.isGreaterEvil()) {
					candidates.extend(::Const.Strings.RumorsGreaterEvil[::World.FactionManager.getGreaterEvilType()]);
					candidates.extend(::Const.Strings.RumorsGreaterEvil[::World.FactionManager.getGreaterEvilType()]);
				} else {
					candidates.extend(::Const.Strings.RumorsGeneral);
				}

				if (this.m.Settlement.isMilitary()) {
					candidates.extend(::Const.Strings.RumorsMilitary);
				} else {
					candidates.extend(::Const.Strings.RumorsCivilian);
				}

				candidates.extend(this.m.Settlement.getRumors());
			} else if (r == 3) {
				local best;
				local bestDist = 9000;

				foreach (s in ::World.EntityManager.getSettlements()) {
					if (s.isMilitary() || s.getID() == this.m.Settlement.getID()) {
						continue;
					}

					if (::World.FactionManager.getFaction(s.getFactions()[0]).getContracts().len() != 0) {
						local d = s.getTile().getDistanceTo(this.m.Settlement.getTile());

						if (d < bestDist) {
							bestDist = d;
							best = s;
						}
					}

					if (best != null) {
						candidates.extend(::Const.Strings.RumorsContract);
						this.m.ContractSettlement = this.WeakTableRef(best);
					} else {
						candidates.extend(::Const.Strings.RumorsGeneral);

						if (this.m.Settlement.isMilitary()) {
							candidates.extend(::Const.Strings.RumorsMilitary);
						} else {
							candidates.extend(::Const.Strings.RumorsCivilian);
						}

						candidates.extend(this.m.Settlement.getRumors());
					}
				}
			} else if (r == 4) {
				local best;
				local bestDist = 9000;

				foreach (s in ::World.EntityManager.getLocations()) {
					if (s.isLocationType(::Const.World.LocationType.AttachedLocation) || s.isLocationType(::Const.World.LocationType.Unique) || s.isAlliedWithPlayer())	{
						continue;
					}

					local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - this.Math.rand(1, 10);

					if (d < bestDist) {
						bestDist = d;
						best = s;
					}
				}

				if (best != null) {
					candidates.extend(::Const.Strings.RumorsLocation);
					this.m.Location = this.WeakTableRef(best);
				} else {
					candidates.extend(::Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary()) {
						candidates.extend(::Const.Strings.RumorsMilitary);
					} else {
						candidates.extend(::Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			} else if (r == 5) {
				local best;
				local bestDist = 9000;

				foreach (s in ::World.EntityManager.getLocations()) {
					if (s.isAlliedWithPlayer()) {
						continue;
					}

					if (s.getLoot().isEmpty()) {
						continue;
					}

					local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - this.Math.rand(1, 10);

					if (d > 20) {
						continue;
					}

					if (d < bestDist) {
						bestDist = d;
						best = s;
					}
				}

				if (best != null) {
					local f = ::World.FactionManager.getFaction(best.getFaction());
					local category = 0;

					if (best.getLoot().getItems()[0].isItemType(::Const.Items.ItemType.Shield)) {
						category = 1;
					} else if (best.getLoot().getItems()[0].isItemType(::Const.Items.ItemType.Armor)
						|| best.getLoot().getItems()[0].isItemType(::Const.Items.ItemType.Helmet))
					{
						category = 2;
					}

					if (f.getType() == ::Const.FactionType.Orcs) {
						candidates.extend(::Const.Strings.RumorsItemsOrcs[category]);
					} else if (f.getType() == ::Const.FactionType.Goblins) {
						candidates.extend(::Const.Strings.RumorsItemsGoblins[category]);
					} else if (f.getType() == ::Const.FactionType.Undead
						|| f.getType() == ::Const.FactionType.Zombies)
					{
						candidates.extend(::Const.Strings.RumorsItemsUndead[category]);
					} else if (f.getType() == ::Const.FactionType.Barbarians) {
						candidates.extend(::Const.Strings.RumorsItemsBarbarians[category]);
					} else if (f.getType() == ::Const.FactionType.OrientalBandits) {
						candidates.extend(::Const.Strings.RumorsItemsNomads[category]);
					} else {
						candidates.extend(::Const.Strings.RumorsItemsBandits[category]);
					}

					this.m.Location = this.WeakTableRef(best);
				} else {
					candidates.extend(::Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary()) {
						candidates.extend(::Const.Strings.RumorsMilitary);
					} else {
						candidates.extend(::Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			} else if (r == 6) {
				local best;
				local bestDist = 9000;

				foreach (s in ::World.EntityManager.getSettlements()) {
					if (s.getID() == this.m.Settlement.getID()) {
						continue;
					}

					s.updateSituations();

					if (s.getSituations().len() > 0) {
						local d = s.getTile().getDistanceTo(this.m.Settlement.getTile());

						if (d < bestDist) {
							bestDist = d;
							best = s;
						}
					}
				}

				if (best != null) {
					local situation = best.getSituations()[this.Math.rand(0, best.getSituations().len() - 1)];
					candidates.extend(situation.getRumors());
					this.m.ContractSettlement = this.WeakTableRef(best);
				} else {
					candidates.extend(::Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary()) {
						candidates.extend(::Const.Strings.RumorsMilitary);
					} else {
						candidates.extend(::Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}

			rumor = rumor + "\n\n[color=#bcad8c]\"" + candidates[this.Math.rand(0, candidates.len() - 1)] + "\"[/color]\n\n";
			rumor = this.buildText(rumor);
			this.m.LastRumor = rumor;
			return rumor;
		}
	}

	local buildText = o.buildText;
	o.buildText = function (_text) {
		local text = buildText(_text);
		local vars = [
			[
				"direction_settlement",
				this.m.ContractSettlement != null && !this.m.ContractSettlement.isNull() ? ::Const.Strings.Direction8[this.m.Settlement.getTile().getDirection8To(this.m.ContractSettlement.getTile())] : ""
			],
		];
		return this.buildTextFromTemplate(text, vars);
	}
});
