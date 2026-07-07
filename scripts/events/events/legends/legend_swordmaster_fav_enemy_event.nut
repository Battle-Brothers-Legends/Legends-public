this.legend_swordmaster_fav_enemy_event <- this.inherit("scripts/events/event", {
	m = {
		Stats = null,
		MinStrength = 100,
		Candidates = null,
		Champion = null,
		Enemy = {
			ID = 0,
			Name = "",
			Gender = -1,
			Script = "scripts/entity/tactical/humans/swordmaster",
			Appearance = {},
			SpriteNames = [
				"body",
				"head",
				"beard",
				"hair",
				"tattoo_body",
				"beard_top",
				"tattoo_head"
			]
		},
		Flags = null,
		Perk = ::Legends.Perks.getID(::Legends.Perk.LegendFavouredEnemySwordmaster),
		ValidTypes = ::Const.LegendMod.FavoriteSwordmaster,
		WasInReserves = [],
		isValidForEncounter = false
	},

	function create() {
		this.m.ID = "event.legend_swordmaster_fav_enemy";
		this.m.Title = "While camping...";
		this.m.Cooldown = 45.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_134.png[/img]{Your feet are still tired from the strain of the last few days. Your activities are interrupted by a lean, young and eager looking %child_enemy%.%SPEECH_ON%Stop right there, rabble!%SPEECH_OFF% %They_enemy% shouts to you and your company. Slightly confused, your mercenaries throw glances to each other, raising their shoulders. %randombrother% replies, slightly amused.%SPEECH_ON%What in the hells do you think you're doing, you little wanker? Those rabble you\'re talking to will cut your throat just for fun. Didn\'t your parents teach you any common sense?%SPEECH_OFF%Carelessly, the young %child_enemy% proceeds. %SPEECH_ON%My name is %enemy%. Looks like it is I who will have to teach you some common sense. It is I who decides which throats get cut! One more insolent comment like that from any of you, and I\'ll have you all hanged!%SPEECH_OFF% Your mercenaries start to fall in laughter. %randombrother2% replies with an angry voice. %SPEECH_ON% Ha. You? I don\'t see your army. Or is it the high-and-mighty %themselves_enemy%, who wants to do all the dirty work, hm? Come here and try me.%SPEECH_OFF% %enemy% answers. %SPEECH_ON% It is not you I want to fight. It is %chosen%. I heard %they're_champion% a good fighter. I want to beat %them_champion%. In the glory of my name, I demand a fight to life or death!%SPEECH_OFF% The haughty juvenile raises %their_enemy% weapon, pointing it toward %chosen%. \n\n Despite the fact that a couple meters separate %enemy% and %chosen%, you can feel the tension in the air.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],

			function start(_event) {
				if (_event.checkTownProximity()) {
					_event.m.Title = "In town..."
				}
				_event.m.Candidates.sort(function (_a, _b) {
					if (_a.getXP() > _b.getXP()) {
						return -1;
					} else if (_a.getXP() < _b.getXP()) {
						return 1;
					}
					return 0;
				});

				local maxCandidates = ::Math.min(4, _event.m.Candidates.len());
				for (local i = 0; i < maxCandidates; i = ++i) {
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "Alright " + bro.getName() + ", teach this little wanker a lesson.",

						function getResult(_event) {
							_event.m.Champion = bro;
							return "N";
						}
					});
				}

				this.Options.push({
					Text = "Leave %them_enemy% alone. Slaughtering a %child_enemy% wont bring us any fame.",

					function getResult(_event) {
						return 0;
					}
				});
				_event.m.Champion = _event.m.Candidates[::Math.rand(0, _event.m.Candidates.len() - 1)]; // for event text so the enemy can point to one of the candidates before you choose one
			}
		});
		this.m.Screens.push({
			ID = "N",
			Text = "[img]gfx/ui/events/event_35.png[/img]{%chosen% heads off to confront %enemy% while the rest of the company observes from a distance.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You can take %them_enemy%, %chosen%!",function getResult(_event) {
						local properties = ::World.State.getLocalCombatProperties(::World.State.getPlayer().getPos());
						properties.Music = ::Const.Music.NobleTracks;
						properties.Entities = [{ // this entity unfortunately is generated separately from the one in event, so we need to copy stuff over
								ID = _event.m.Enemy.ID,
								Variant = 1,
								Row = 0,
								Name = _event.m.Enemy.Name,
								Script = _event.m.Enemy.Script,
								Faction = ::Const.Faction.Enemy,
								Callback = _event.onActorPlaced.bindenv(_event)
						}];
						
						if (_event.m.Champion.isInReserves()) {
							_event.m.WasInReserves.push(_event.m.Champion);
							_event.m.Champion.setInReserves(false);
						}
						properties.Players = [_event.m.Champion];
						properties.IsUsingSetPlayers = true;
						properties.IsFleeingProhibited = true;
						properties.IsAttackingLocation = true;
						properties.BeforeDeploymentCallback = function () {
							local size = this.Tactical.getMapSize();
							for (local x = 0; x < size.X; ++x) {
								for (local y = 0; y < size.Y; ++y) {
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = ::Math.min(1, tile.Level);
								}
							}
						};
						_event.registerToShowAfterCombat("Victory", "Defeat");
						::World.State.startScriptedCombat(properties, false, false, false);
						return 0;
					}
				}
			],

			function start(_event) {
				_event.m.Title = "The duel!";
				this.Characters.push(_event.m.Champion.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_96.png[/img]{%chosen% stands victorious over the badly wounded %enemy%. The defeated %noble_enemy% can barely catch %their_enemy% breath. Every gasp of air comes with great pain for %them_enemy%. Bleeding and shaking, %they_enemy% is soon to depart from the world of the living. The duel was meant to be to the death but %chosen% does not deliver a final blow. The rest of your mercenaries gather around the winner. Most of the company is cheering the now glorious %chosen%, but some are more concerned about the unfinished business laying on the ground in a pool of his own blood. %randombrother% speaks up with strong contempt for the loser of this duel. %SPEECH_ON%What are you waiting for %chosen%? You think this whipster would show you mercy?%SPEECH_OFF% The company champion answers. %SPEECH_ON%I will take %their_enemy% equipment as spoils, but %they're_enemy% no good to me dead.%SPEECH_OFF% }",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You did well, %chosen%.",function getResult(_event) {
						return 0;
					}
				}
			],

			function start(_event) {
				_event.m.Title = "After the battle...";
				this.Characters.push(_event.m.Champion.getImagePath());
				::World.Assets.addBusinessReputation(50);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/special.png",
						text = "The company gained renown"
					}
				];

				if (_event.m.Champion.getBaseProperties().MeleeSkill < 100) {
					_event.m.Champion.improveMood(0.5, "Improved his skills though duel");
					this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Champion, ::Math.rand(1, 3)));
				}

				if (_event.m.Champion.getBaseProperties().MeleeDefense < 50) {
					_event.m.Champion.improveMood(0.5, "Improved his skills though duel");
					::Legends.EventList.changeMeleeDefense(_event.m.Champion, ::Math.rand(1, 3));
				}

				if (_event.m.Champion.getMoodState() >= ::Const.MoodState.Neutral) {
					this.List.push(::Legends.EventList.changeMood(_event.m.Champion));
				}

				_event.m.Champion.getSkills().update();
				local playerRoster = ::World.getPlayerRoster().getAll();

				foreach (bro in playerRoster) {
					if (bro.getBackground().isBackgroundType(::Const.BackgroundType.Combat) && ::Math.rand(1, 100) <= 33) {
						bro.improveMood(0.5, "The company\'s champion won an impressive duel");
					}

					if (bro.getMoodState() > ::Const.MoodState.Neutral) {
						this.List.push(::Legends.EventList.changeMood(bro));
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_58.png[/img]{%enemy% emerges victorious from the duel. Winning this fight made him even more eager and confident. Looks like he wants to fight everybody in the company, one by one. With a voice full of pride he shouts to your men. %SPEECH_ON%Who\'s  next ?!%SPEECH_OFF% }",
			Image = "",
			List = [],
			Characters = [],
			Options = [],

			function start(_event) {
				_event.m.Title = "After the battle...";

				_event.m.Candidates.sort(function (_a, _b) {
					if (_a.getXP() > _b.getXP()) {
						return -1;
					} else if (_a.getXP() < _b.getXP()) {
						return 1;
					}

					return 0;
				});

				local maxCandidates = ::Math.min(4, _event.m.Candidates.len());
				for (local i = 0; i < maxCandidates; i = ++i) {
					local bro = _event.m.Candidates[i];
					this.Options.push({
						Text = "I need you to avenge us, " + bro.getName() + ".",

						function getResult(_event) {
							_event.m.Champion = bro;
							return "N";
						}

					});
				}

				this.Options.push({
					Text = "This isn\'t worth it. We should leave.",

					function getResult(_event) {
						return 0;
					}
				});
			}
		});
	}

	function checkTownProximity() {
		local towns = ::World.EntityManager.getSettlements();
		local nearTown = false;
		local playerTile = ::World.State.getPlayer().getTile();

		foreach (t in towns) {
			if (t.getTile().getDistanceTo(playerTile) <= 8 && !t.isIsolated()) // WAS 10
			{
				nearTown = true;
				break;
			}
		}
		return nearTown;
	}

	function onUpdateScore() {
		this.m.isValidForEncounter = false;
		
		if (!::World.getTime().IsDaytime) {
			return;
		}

		if (!checkTownProximity()) {
			return;
		}

		local candidates = [];
		local maxStrength = 0;

		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (!bro.getSkills().hasPerk(::Legends.Perk.LegendFavouredEnemySwordmaster)) {
				continue;
			}

			if (bro.getLevel() < 11) {
				continue;
			}

			local stats = ::Const.LegendMod.GetFavoriteEnemyStats(bro, ::Const.LegendMod.FavoriteSwordmaster);

			if (stats.Strength > maxStrength) {
				maxStrength = stats.Strength;
			}
			candidates.push(bro);
		}

		if (candidates.len() == 0) {
			return;
		}

		this.m.Candidates = candidates;
		this.m.Stats = ::Math.floor(maxStrength);

		this.m.isValidForEncounter = maxStrength >= 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil; // set maxStrength threshold higher if necessary
		this.m.Score = 0; // this disables event from happening normally
	}

	function onActorPlaced (_entity, _tag) {
		_entity.setName(this.m.Enemy.Name);
		_entity.setGender(this.m.Enemy.Gender);

		foreach (s in this.m.Enemy.SpriteNames) {
			if (!(s in this.m.Enemy.Appearance)) {
				continue;
			}
			local brush = this.m.Enemy.Appearance[s];
			local sprite = _entity.getSprite(s);
			if (brush != "") {
				sprite.setBrush(brush);
			} else {
				sprite.resetBrush();
			}
		}
	}

	function generateActors() {
		local r = ::Math.rand(0, 2);
		if (r == 1) {
			this.m.Enemy.Script = "scripts/entity/tactical/enemies/bandit_leader";
		} else if (r == 2) {
			this.m.Enemy.Script = "scripts/entity/tactical/humans/hedge_knight";
		}
		local enemy = ::World.getTemporaryRoster().create(this.m.Enemy.Script);
		this.m.Enemy.ID = enemy.getType();
		local name = ::Const.Strings.KnightNames[::Math.rand(0, ::Const.Strings.KnightNames.len() - 1)];
		if (enemy.getGender() == 1) {
			name = ::MSU.String.replace(name, "Sir", "Dame");
		}
		this.m.Enemy.Name = name;
		this.m.Enemy.Gender = enemy.getGender();
		foreach (s in this.m.Enemy.SpriteNames) {
			this.m.Enemy.Appearance[s] <- "";
			if (enemy.hasSprite(s)) {
				local sprite = enemy.getSprite(s);
				this.m.Enemy.Appearance[s] = sprite.HasBrush ? sprite.getBrush().Name : "";
			}
		}
		::World.getTemporaryRoster().clear();
	}

	function onPrepareVariables(_vars) {
		if (this.m.Enemy.Name == "") {
			this.generateActors();
		}
		
		_vars.push([
			"chosen",
			this.m.Champion != null ? this.m.Champion.getName() : ""
		]);
		_vars.push([
			"enemy",
			this.m.Enemy != null ? this.m.Enemy.Name : ""
		]);

		if (this.m.Enemy.Gender != -1) {
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Enemy.Gender, "enemy");
		}
	}

	function onDetermineStartScreen() {
		/*local currentTile = ::World.State.getPlayer().getTile();
		if (currentTile.SquareCoords.Y > ::World.getMapSize().Y * 0.7) {
			return "A";
		}*/
		return "A";
	}

	function onClear() {
		this.m.Candidates = [];
		this.m.Champion = null;
		this.m.Enemy = {
			ID = 0,
			Name = "",
			Gender = -1,
			Script = "scripts/entity/tactical/humans/swordmaster",
			Appearance = {},
			SpriteNames = [
				"body",
				"head",
				"beard",
				"hair",
				"tattoo_body",
				"beard_top",
				"tattoo_head"
			]
		};
		foreach (bro in this.m.WasInReserves) {
			bro.setInReserves(true);
		}
		this.m.WasInReserves.clear();
		::World.getTemporaryRoster().clear();
	}

});
