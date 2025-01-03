::mods_hookExactClass("contracts/contracts/arena_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"The buzzing roar of the crowd draw many to the Arena. Gold, glory and death can be found inside.",
			"Amidst the cheers and jeers, the Arena stands as a testament to the might of the Southern Realms.",
			"The Imperial Arena, where gold and glory are earned through blood and sweat.",
			"Legends are made and dreams shattered within the walls of the Imperial Arena.",
			"Nobles and commoners alike gather to witness the spectacle of the Imperial Arena.",
			"Glittering under the sun, the sands of the Imperial Arena bear witness to countless contests."
		];
	}

	o.newTwist <- function (_chance, _flag, _payment) {
		return {
			R = _chance,
			F = _flag,
			P = _payment
		}
	}

	o.onTwistsSetup <- function (_twists) {}

	o.setup = function()
	{
		this.m.Flags.set("Number", 0);
		local pay = 550;
		local twists = [
			this.newTwist(10, "IsGhouls", 0),
			this.newTwist(15, "IsDesertRaiders", 0),
			this.newTwist(10, "IsSerpents", 0)
		];

		if(this.m.Home.hasSituation("situation.bread_and_games"))
			pay = pay + 100;

		local arenaFights = this.World.Statistics.getFlags().getAsInt("ArenaFightsWon");

		if (arenaFights <= 3) {
			twists.push(this.newTwist(10, "IsHyenas", 0));
		}

		if (arenaFights <= 5) {
			twists.push(this.newTwist(10, "IsSpiders", -75));
		}

		if (arenaFights >= 3) {
			twists.push(this.newTwist(5, "IsSandGolems", 50));
			twists.push(this.newTwist(15, "IsGladiators", 0));
		}

		if (arenaFights >= 4) {
			twists.push(this.newTwist(10, "IsFrenziedHyenas", 0));
		}

		if (arenaFights >= 5) {
			twists.push(this.newTwist(5, "IsSwordmaster", 50));
			twists.push(this.newTwist(5, "IsHedgeKnight", 50));
			twists.push(this.newTwist(5, "IsDesertDevil", 50));
			twists.push(this.newTwist(5, "IsMercenaries", 0));
		}

		if (arenaFights >= 6) {
			twists.push(this.newTwist(5, "IsUnholds", 100));
		}

		if (arenaFights >= 10) {
			twists.push(this.newTwist(5, "IsLindwurm", 200));
		}

		if (arenaFights >= 15) {
			twists.push(this.newTwist(2, "IsSwordmasterChampion", 150));
			twists.push(this.newTwist(2, "IsDesertDevilChampion", 150));
			twists.push(this.newTwist(5, "IsGladiatorChampion", 150));
		}

		this.onTwistsSetup(twists);

		local maxR = 0;

		foreach( t in twists )
		{
			maxR = maxR + t.R;
		}

		local r = this.Math.rand(1, maxR);

		foreach( t in twists )
		{
			if (r <= t.R)
			{
				this.m.Flags.set(t.F, true);
				pay = pay + t.P;
				break;
			}
			else
			{
				r = r - t.R;
			}
		}

		this.m.Payment.Pool = pay * this.getPaymentMult() * this.getReputationToPaymentMult();
		this.m.Payment.Completion = 1.0;
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Overview")
			{
				s.Options.push(
				{
					Text = "{This isn\'t what I had in mind. | I\'ll sit this one out. | I\'ll wait for the next fight.}",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						return 0;
					}
				});
			}

			if (s.ID == "Start")
			{
				s.Options.push(
				{
					Text = "I\'ll have to think it over.",
					function getResult()
					{
						return 0;
					}
				});

				s.start <- function ()
				{
					this.Text += "\n\n\n\n\n\n\n\nThe following characters will enter the arena:\n\n%bro1name%\n%bro2name%\n%bro3name%";
				}
			}

			if (s.ID == "Success")
			{
				s.start <- function ()
				{
					local roster = this.World.getPlayerRoster().getAll();
					local n = 0;

					foreach( bro in roster )
					{
						local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

						if (item != null && item.getID() == "accessory.arena_collar") {
							local skill;
							bro.getFlags().increment("ArenaFightsWon", 1);
							bro.getFlags().increment("ArenaFights", 1);

							if (bro.getFlags().getAsInt("ArenaFightsWon") == 1) {
								skill = this.new("scripts/skills/traits/arena_pit_fighter_trait");
								bro.getSkills().add(skill);
								this.List.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});
							} else if (bro.getFlags().getAsInt("ArenaFightsWon") == 5 && bro.getSkills().hasSkill("trait.pit_fighter")) {
								bro.getSkills().removeByID("trait.pit_fighter");
								skill = this.new("scripts/skills/traits/arena_fighter_trait");
								bro.getSkills().add(skill);
								this.List.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});
							} else if (bro.getFlags().getAsInt("ArenaFightsWon") >= 12 && bro.getSkills().hasSkill("trait.arena_fighter")) {
								bro.getSkills().removeByID("trait.arena_fighter");
								skill = this.new("scripts/skills/traits/legend_arena_veteran_trait");
								bro.getSkills().add(skill);
								this.List.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});
							} else if (bro.getFlags().getAsInt("ArenaFightsWon") >= 25 && bro.getSkills().hasSkill("trait.legend_arena_veteran")) {
								bro.getSkills().removeByID("trait.legend_arena_veteran");
								skill = this.new("scripts/skills/traits/legend_arena_champion_trait");
								bro.getSkills().add(skill);
								this.List.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});
							} else if (bro.getFlags().getAsInt("ArenaFightsWon") >= 50 && bro.getSkills().hasSkill("trait.legend_arena_champion")) {
								bro.getSkills().removeByID("trait.legend_arena_champion");
								skill = this.new("scripts/skills/traits/legend_arena_invictus_trait");
								bro.getSkills().add(skill);
								this.List.push({
									id = 10,
									icon = skill.getIcon(),
									text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
								});
							}
							n++;
						}

						if (n >= 3)
							break;
					}

					if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
					{
						local r;
						local a;
						local u;

						if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 5)
							r = 1;
						else if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 10)
							r = 3;
						else if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 15)
							r = 2;
						else
							r = this.Math.rand(1, 3);

						switch(r)
						{
						case 1:
							a = this.Const.World.Common.pickArmor([
									[1, "oriental/gladiator_harness"],
							]);
							a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));

							this.List.push({
								id = 12,
								icon = "ui/items/armor_upgrades/upgrade_24.png",
								text = "You gain a " + a.getName()
							});
							break;

						case 2:
							a = this.Const.World.Common.pickArmor([
									[1, "oriental/gladiator_harness"],
							]);
							a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
							this.List.push({
								id = 12,
								icon = "ui/items/armor_upgrades/upgrade_25.png",
								text = "You gain a " + a.getName()
							});
							break;

						case 3:
							a = ::new(::MSU.Array.rand([
								"scripts/items/legend_helmets/helm/legend_helmet_southern_gladiator_helm_crested",
								"scripts/items/legend_helmets/helm/legend_helmet_southern_gladiator_helm_split",
								"scripts/items/legend_helmets/helm/legend_helmet_southern_gladiator_helm_masked"
							]));
							this.List.push({
								id = 12,
								icon = "ui/items/" + a.getIcon(),
								text = "You gain a " + a.getName()
							});
							break;
						}

						this.World.Assets.getStash().makeEmptySlots(1);
						this.World.Assets.getStash().add(a);
					}
				}
			}
		}
	}


	o.getBros = function ()
	{
		local ret = [];
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				if (bro.isInReserves())
				{
					bro.setInReserves(false);
				}
				ret.push(bro);
			}
		}

		return ret;
	}

	/*Adds the following vars:
		bro1name = "Bro Name"
		bro2name = "2nd Bro Name" (if bro exists)
		bro3name = "" (if bro doesn't exist)
	*/
	o.prepareBroVariables <- function ( _maxNumBros, _vars)
	{
		local currentBro = 1

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				_vars.push([
					"bro" + currentBro++ + "name",
					" - " + bro.getName()
				]);
			}

		}

		for (local i = currentBro; i <= _maxNumBros; ++i)
		{
			_vars.push([
				"bro" + i + "name",
				""
			])
		}
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		this.prepareBroVariables(3, _vars)
	}
});
