::mods_hookExactClass("contracts/contracts/arena_tournament_contract", function(o)
{
	o.m.WasInReserves <- [];

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"A grand tournament to the death, a celebration of slaughter. Eternal glory and prized items await.",
			"Blood soaks the sand, yet the crowd always screams for more. A grand tournament has been announced!",
			"Don your armor and sharpen your blades! The Imperial Arena grand tournament is about to begin!",
			"Calling all warriors! The Imperial Arena grand tournament beckons!",
			"Champions, assemble! The Imperial Arena tournament awaits your valor!",
			"The Imperial Arena is set to host a thrilling tournament of skill and bravery!",
		];
	}

	o.start = function ()
	{
		local item;
		local idx = this.Math.rand(1, 3);
		if (idx == 1)
		{
			local items = clone this.Const.Items.NamedWeapons;
			item = this.new("scripts/items/" + items[this.Math.rand(0, items.len() - 1)]);
		}
		else if (idx == 2)
		{
			item = this.Const.World.Common.pickHelmet(
				this.Const.World.Common.convNameToList(
					this.Const.Items.NamedHelmets
				)
			);
		}
		else if (idx == 3)
		{
			item = this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(
					this.Const.Items.NamedArmors
				)
			);
		}

		local cnh;
		if (idx == 1)
		{
			this.m.Flags.set("PrizeName", item.createRandomName());
			cnh = item.ClassNameHash;
		}
		else
		{
			local nameList = [];
			if ((item.m.ItemType & this.Const.Items.ItemType.Named) != 0) //if base layer named
				nameList.push(item);
			foreach(i, type in item.getUpgrades()) { //if upgrade named
				if (type != 1)
					continue;
				local u = item.getUpgrade(i);
				if (u != null && u.isNamed())
					nameList.push(u);
			}
			local item = nameList[this.Math.rand(0, nameList.len() - 1)];
			this.m.Flags.set("PrizeName", item.getName());
			cnh = item.ClassNameHash;
		}
		this.m.Flags.set("PrizeScript", cnh);

		if (item.isItemType(this.Const.Items.ItemType.Weapon))
		{
			this.m.Flags.set("PrizeType", "weapon");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Shield))
		{
			this.m.Flags.set("PrizeType", "shield");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Armor))
		{
			this.m.Flags.set("PrizeType", "armor");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Helmet))
		{
			this.m.Flags.set("PrizeType", "helmet");
		}

		this.m.Flags.set("Round", 1);
		this.m.Flags.set("RewardApplied", 0);
		this.m.Flags.set("Opponents1", this.getOpponents(1).I);
		this.m.Flags.set("Opponents2", this.getOpponents(2).I);
		this.m.Flags.set("Opponents3", this.getOpponents(3).I);
		this.contract.start();
	}

	o.getOpponents = function ( _round, _index = -1 )
	{
		local twists = [];

		if (_round == 1) {
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Spider, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Spider);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Serpent, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Serpent);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.HyenaHIGH, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.HyenaHIGH);
				}
			});
		}
		if (_round <= 2) {
			twists.push({
				R = 10,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
				}
			});
		}
		if (_round == 2) {
			twists.push({
				R = 10,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
				}
			});
			twists.push({
				R = 10,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.SandGolemMEDIUM, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.SandGolemMEDIUM);
				}
			});
			twists.push({
				R = 10,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
				}
			});
		}
		if (_round >= 2) {
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
				}
			});
		}
		if (_round == 3) {
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Executioner.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Executioner.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertStalker);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Executioner.Cost - this.Const.World.Spawn.Troops.DesertStalker.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
				}
			});
			twists.push({
				R = 10,
				function F( _c, _d, _e ) {
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Unhold, _d); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Unhold);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					for( local i = 0; i < this.Math.min(3, _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Lindwurm, _d)); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Lindwurm);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.BanditRaider, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.BanditRaider);
				}
			});
			twists.push({
				R = 5,
				function F( _c, _d, _e ) {
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = ++i )
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
				}
			});
			if (this.World.getTime().Days > 50) {
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);
						for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Gladiator.Cost * 2); i = ++i )
							_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				});
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);
						for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.Swordmaster.Cost * 2); i = ++i )
							_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}

				});
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight, true);
						for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost * 2); i = ++i )
							_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
					}

				});
			}
			if (this.World.getTime().Days > 50) {
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.MasterArcher, true);
					}
				});
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);
						for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost * 2 - this.Const.World.Spawn.Troops.Swordmaster.Cost * 2); i = ++i )
							_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
					}
				});
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);
						for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost * 2 - this.Const.World.Spawn.Troops.Executioner.Cost * 2); i = ++i )
							_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}

				});
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertStalker, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);
					}

				});
				twists.push({
					R = 5,
					function F( _c, _d, _e ) {
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);
						for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Gladiator.Cost * 4); i = ++i )
							_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
					}
				});
			}
		}

		if ( "bool" == typeof _index || _index >= 0)
		{
			return {
				I = _index,
				F = twists[_index].F
			};
		}
		else
		{
			local maxR = 0;

			foreach( t in twists )
			{
				maxR = maxR + t.R;
			}

			local r = this.Math.rand(1, maxR);

			foreach( i, t in twists )
			{
				if (r <= t.R)
				{
					return {
						I = i,
						F = t.F
					};
				}
				else
				{
					r = r - t.R;
				}
			}
		}
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Start")
			{
				s.start <- function ()
				{
					this.Text += "\n\n\n\n\n\n\n\nThe following characters will enter the arena:\n\n%bro1name%\n%bro2name%\n%bro3name%\n%bro4name%\n%bro5name%";
				}
				break;
			}
			if (s.ID == "Failure1") {
				s.Options[0].getResult <- function () {
					foreach (bro in ::Legends.Arena.getCollaredBros()) {
						bro.getFlags().increment("ArenaFights", 1);
					}

					this.Contract.getHome().removeSituationByID("situation.arena_tournament");
					this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
					this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
					this.World.Contracts.finishActiveContract(true);
				}
			}
		}
	}

	o.updateTraits = function (_list) {
		foreach( bro in ::Legends.Arena.getCollaredBros()) {
			bro.getFlags().increment("ArenaFightsWon", 1);
			bro.getFlags().increment("ArenaFights", 1);
			::Legends.Arena.updateTraits(_list, bro);
		}
	}

	o.getBros = function ()
	{
		local ret = ::Legends.Arena.getCollaredBros();
		foreach (bro in ret) {
			if (bro.isInReserves()) {
				this.m.WasInReserves.push(bro);
				bro.setInReserves(false);
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
		local currentBro = 1;
		foreach (bro in ::Legends.Arena.getCollaredBros()) {
			_vars.push([
				"bro" + currentBro++ + "name",
				" - " + bro.getName()
			]);
		}
		for (local i = currentBro; i <= _maxNumBros; ++i) {
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
		this.prepareBroVariables(5, _vars)
	}

	local onClear = o.onClear;
	o.onClear = function ()
	{
		foreach (bro in this.m.WasInReserves) {
			bro.setInReserves(true);
		}
		this.m.WasInReserves.clear();
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			::Legends.Arena.removeCollar(bro);
		}
		onClear();
	}
});
