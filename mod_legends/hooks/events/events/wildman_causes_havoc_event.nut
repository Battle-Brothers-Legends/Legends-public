::mods_hookExactClass("events/events/wildman_causes_havoc_event", function(o) {
	o.m.Trader <- null;
	o.m.Berserker <- null;

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options = [];
				s.start <- function ( _event ) {
					this.Options.push({
						Text = "This ain\'t our problem.",
						function getResult( _event ) {
							return "B";
						}
					});

					if (_event.m.Wildman != null && _event.m.Berserker == null) {
						this.Options.push({
							Text = "Fine, the company will cover the damages - but %wildman% will work it off.",
							function getResult( _event ) {
								return "D";
							}
						});
					}

					if (_event.m.Berserker != null) {
						this.Options.push({
							Text = "Fine, the company will cover the damages - but %berserker% will work it off.",
							function getResult( _event ) {
								return "X";
							}
						});
					}

					this.Options.push({
						Text = "Fine, the company will cover the damages.",
						function getResult( _event ) {
							return "C";
						}
					});

					if (_event.m.Trader != null) {
						this.Options.push({
							Text = "Fine, the company will cover the damages. But %trader% will assess compensation.",
							function getResult( _event )
							{
								if (_event.m.Berserker != null)
									this.m.Compensation = this.Math.round(400 + 0.03 * this.World.Assets.getMoney());
								else
									this.m.Compensation = this.Math.round(300 + 0.02 * this.World.Assets.getMoney());
								return "T";
							}

						});
					}

					if (_event.m.Berserker != null)
						this.Characters.push(_event.m.Berserker.getImagePath());

					if (_event.m.Wildman != null && _event.m.Berserker == null)
						this.Characters.push(_event.m.Wildman.getImagePath());
				}
			}
			if (s.ID == "B") {
				s.Options = [{
					Text = "To hell with your shop.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(-1);
						return this.Math.rand(1, 100) <= 80 ? "E" : 0;
					}
				}];
				s.start <- function ( _event ) {
					if (_event.m.Berserker != null)
						this.Characters.push(_event.m.Berserker.getImagePath());

					if (_event.m.Wildman != null && _event.m.Berserker == null)
						this.Characters.push(_event.m.Wildman.getImagePath());

					this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "You refused to pay for damages caused by one of your mercenaries");
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_01.png[/img]You go and see the shop. The wildling truly did a number on the place. And it reeks of... scent markings. It would be a bad look for the company to not handle this issue with great care. You agree to pay for the damages, something most mercenary bands would not have done. This act of kindness does not slip the townspeople by.";
				s.Options = [{
					Text = "Charity through destruction?",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(2);
						return 0;
					}
				}];
				s.start <- function ( _event ) {
					if (_event.m.Berserker != null)
						this.Characters.push(_event.m.Berserker.getImagePath());

					if (_event.m.Wildman != null && _event.m.Berserker == null)
						this.Characters.push(_event.m.Wildman.getImagePath());

					this.World.Assets.addMoney(-_event.m.Compensation);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
					});
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
				}
			}
			if (s.ID == "D") {
				s.start <- function ( _event ) {
					this.World.Assets.addMoney(-_event.m.Compensation);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
					});
					this.Characters.push(_event.m.Wildman.getImagePath());
					_event.m.Wildman.getBaseProperties().DailyWage -= this.Math.floor(_event.m.Wildman.getDailyCost() / 4);
					_event.m.Wildman.getSkills().update();
					this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your mercenaries caused havoc in town");
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_daily_money.png",
						text = _event.m.Wildman.getName() + " is now paid [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Wildman.getDailyCost() + "[/color] crowns a day"
					});
					_event.m.Wildman.worsenMood(2.0, "Got a pay cut");

					if (_event.m.Wildman.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Wildman.getMoodState()],
							text = _event.m.Wildman.getName() + this.Const.MoodStateEvent[_event.m.Wildman.getMoodState()]
						});
					}
				}
			}
			if (s.ID == "E") {
				s.Options = [{
					Text = "A shame it had to come to this.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(-2);
						this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationBetrayal, "You killed some of the militia");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Militia, this.Math.rand(90, 130), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}
				}, {
					Text = "Fine. I did not wake up this morning looking to slaughter innocents.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(1);
						return "G";
					}
				}];
				s.start <- function ( _event ) {
					if (_event.m.Berserker != null)
						this.Characters.push(_event.m.Berserker.getImagePath());

					if (_event.m.Wildman != null && _event.m.Berserker == null)
						this.Characters.push(_event.m.Wildman.getImagePath());

					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
				}
			}
			if (s.ID == "E") {
				s.start <- function ( _event ) {
					if (_event.m.Berserker != null)
						this.Characters.push(_event.m.Berserker.getImagePath());

					if (_event.m.Wildman != null && _event.m.Berserker == null)
						this.Characters.push(_event.m.Wildman.getImagePath());

					this.World.Assets.addMoney(-_event.m.Compensation);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
					});
					local brothers = this.World.getPlayerRoster().getAll();
					foreach( bro in brothers ) {
						if (bro.getBackground().isCombatBackground() && this.Math.rand(1, 100) <= 33)
							bro.worsenMood(1.0, "The company backed down from a fight");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
					}
				}
			}
		}

		this.m.Screens.push({
			ID = "X",
			Text = "[img]gfx/ui/events/event_20.png[/img]Surveying the damage, you agree to compensate the businessman. But this isn\'t your fault, it\'s the wildling\'s. You dock their pay: for some time to come, the mercenary\'s earnings will be halved. %vandal% doesn\'t take this information lightly, and as their face starts to contort in anger, you question whether it was good idea to discipline such a volatile brute. %vandal% quickly reaches the limit of their restraint and jumps at you, fists eager to smash your face! You almost faint before rest of %companyname% manages to restrain %vandal%. This time compensation for damage caused by wildlings of %companyname% was paid both with crowns and blood of your men.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "That was not a good idea...",
				function getResult( _event ) {
					return 0;
				}
			}],
			function start( _event ) {
				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
				});
				this.Characters.push(_event.m.Berserker.getImagePath());
				_event.m.Berserker.getBaseProperties().DailyWage -= this.Math.floor(_event.m.Berserker.getDailyCost() / 4);
				_event.m.Berserker.getSkills().update();
				this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "One of your mercenaries caused havoc in town");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Berserker.getName() + " is now paid [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Berserker.getDailyCost() + "[/color] crowns a day"
				});
				_event.m.Berserker.worsenMood(2.0, "Got a pay cut");

				if (_event.m.Berserker.getMoodState() < this.Const.MoodState.Neutral) {
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Berserker.getMoodState()],
						text = _event.m.Berserker.getName() + this.Const.MoodStateEvent[_event.m.Berserker.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers ) {
					if (this.Math.rand(1, 100) <= 75) {
						if (this.Math.rand(1, 100) <= 66) {
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});
						} else {
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + " suffers light wounds"
							});
						}
					}
				}
			}
		});

		this.m.Screens.push({
			ID = "T",
			Text = "[img]gfx/ui/events/event_01.png[/img]%trader% goes and sees the shop. The wildling truly did a number on the place. %trader% demands a list for all caused by %vandal%. The shop owner hands it over… reluctantly. Your trader engages into heated discussion about proper evaluation of compensation for this act of vandalism. Looks like the shop owner wanted to earn extra coins on your account. Numbers on his list were so exaggerated, he could afford three new shops if you paid it. After proper evaluation of necessary compensation by %trader%,  you agree to pay for the damages, something most mercenary bands would not have done. This act of kindness does not slip the townspeople by.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Charity through destruction?",
				function getResult( _event ) {
					this.World.Assets.addMoralReputation(2);
					return 0;
				}
			}],
			function start( _event ) {
				if (_event.m.Berserker != null)
					this.Characters.push(_event.m.Berserker.getImagePath());

				if (_event.m.Wildman != null && _event.m.Berserker == null)
					this.Characters.push(_event.m.Wildman.getImagePath());

				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
			}
		});
	}


	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime)
			return;

		if (this.World.Assets.getMoney() < 600)
			return;

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns ) {
			if (t.isSouthern() || t.isMilitary())
				continue;

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer()) {
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
			return;

		this.m.Town = town;
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_wildchars = [];
		local candidates_berserkers = [];
		local thetraders = [];

		foreach( bro in brothers ) {
			switch (bro.getBackground().getID()) {
				case "background.legend_trader":
				case "background.legend_commander_trader":
					thetraders.push(bro);
					break;
				case "background.wildman":
					candidates_wildchars.push(bro);
					break;
				case "background.legend_berserker":
					candidates_berserkers.push(bro);
					break;
			}
		}

		// this.logInfo("Wildnubs= " + candidates_wildchars.len() + " WildBoss= " + candidates_berserkers.len() + " Traders= " + thetraders.len());

		if (candidates_wildchars.len() == 0 && candidates_berserkers.len() == 0)
			return;

		if (candidates_berserkers.len() != 0)
		{
			this.m.Compensation = this.Math.round(1000 + 0.05 * this.World.Assets.getMoney());
			this.m.Berserker = candidates_berserkers[this.Math.rand(0, candidates_berserkers.len() - 1)];
		}

		if (candidates_wildchars.len() != 0)
		{
			this.m.Compensation = this.Math.round(500 + 0.03 * this.World.Assets.getMoney());
			this.m.Wildman = candidates_wildchars[this.Math.rand(0, candidates_wildchars.len() - 1)];
		}

		if (thetraders.len() != 0)
			this.m.Trader = thetraders[this.Math.rand(0, thetraders.len() - 1)];

		this.m.Score = candidates_wildchars.len() * 10 + candidates_berserkers.len() * 30;
	}

	o.onPrepareVariables = function ( _vars ) {
		_vars.push([
			"trader",
			this.m.Trader != null ? this.m.Trader.getNameOnly() : ""
		]);
		_vars.push([
			"berserker",
			this.m.Berserker != null ? this.m.Berserker.getNameOnly() : ""
		]);
		_vars.push([
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getNameOnly() : ""
		]);
		_vars.push([
			"vandal",
			this.m.Berserker != null ? this.m.Berserker.getNameOnly() : this.m.Wildman.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"compensation",
			this.m.Compensation
		]);
	}

	o.onClear = function () {
		this.m.Trader = null;
		this.m.Berserker = null;
		this.m.Wildman = null;
		this.m.Town = null;
	}
})
