::mods_hookExactClass("contracts/contracts/big_game_hunt_contract", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Foul beasts, ghouls and other monstrosities are roaming the land with impunity. %s needs someone of your caliber to slay them all.",
			"Seeking fearless hunters! A monster hunt contract of great reward beckons!",
			"%s is calling all skilled hunters to join an open monster hunt contract for honor and coin.",
			"Daring souls wanted! Take up arms for %s and kill monsters for great rewards.",
			"Fields lay barren, and homes abandoned, as monster attacks ravage a once thriving region.",
			"Life in the region has become a struggle, overshadowed by the constant threat of monster attacks.",
		];
	}

	o.formatDescription <- function ()
	{
		local r = ::MSU.Array.rand(this.m.DescriptionTemplates);

		if (r.find("%") != null)
			r = format(r, ::Const.UI.getColorized(::World.FactionManager.getFaction(this.getFaction()).getName(), ::Const.UI.Color.getHighlightLightBackgroundValue()));

		this.m.Description = r;
	}

	local createStates = o.createStates;
	o.createStates = function()
	{
		createStates();
		foreach (s in this.m.States)
		{
			if (s.ID == "Offer")
			{
				s.start <- function ()
				{
					this.Flags.set("StartDay", this.World.getTime().Days);
					this.Contract.m.BulletpointsObjectives.clear();

					if (this.Contract.m.Size == 0)
					{
						this.Contract.m.BulletpointsObjectives.push("Hunt for Direwolves, Webknechts, Nachzehrers, Hyenas and Serpents");
					}
					else if (this.Contract.m.Size == 1)
					{
						this.Contract.m.BulletpointsObjectives.push("Hunt for Alps, Unholds and Hexen");
					}
					else
					{
						this.Contract.m.BulletpointsObjectives.push("Hunt for Schrats and Lindwurms");
					}

					this.Contract.m.BulletpointsObjectives.push("Hunt around the %regiontype% region of %worldmapregion% %distance% to the %direction% and other regions");
					this.Contract.m.BulletpointsObjectives.push("Return to %townname% at any time to get paid");

					if (this.Contract.m.Size == 0)
					{
						this.Contract.setScreen("TaskSmall");
					}
					else if (this.Contract.m.Size == 1)
					{
						this.Contract.setScreen("TaskMedium");
					}
					else
					{
						this.Contract.setScreen("TaskLarge");
					}
				}
			}
			if (s.ID == "Running")
			{
				s.start <- function ()
				{
					this.Contract.m.BulletpointsObjectives.clear();

					if (this.Contract.m.Size == 0)
					{
						this.Contract.m.BulletpointsObjectives.push("Hunt for Direwolves, Webknechts, Nachzehrers, Hyenas and Serpents around the %regiontype% region of %worldmapregion% (%killcount%/%maxcount%)");
					}
					else if (this.Contract.m.Size == 1)
					{
						this.Contract.m.BulletpointsObjectives.push("Hunt for Alps, Unholds and Hexen around the %regiontype% region of %worldmapregion% (%killcount%/%maxcount%)");
					}
					else
					{
						this.Contract.m.BulletpointsObjectives.push("Hunt for Schrats and Lindwurms around the %regiontype% region of %worldmapregion% (%killcount%/%maxcount%)");
					}

					this.Contract.m.BulletpointsObjectives.push("Return to %townname% at any time to get paid");
				}

				s.onActorKilled = function ( _actor, _killer, _combatID )
				{
					if (_killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
					{
						return;
					}

					if (this.Flags.get("HeadsCollected") >= this.Contract.m.Payment.MaxCount)
					{
						return;
					}

					local beasts = [[
							this.Const.EntityType.Ghoul,
							this.Const.EntityType.LegendSkinGhoul,
							this.Const.EntityType.Direwolf,
							this.Const.EntityType.LegendWhiteDirewolf,
							this.Const.EntityType.Spider,
							this.Const.EntityType.LegendRedbackSpider,
							this.Const.EntityType.Hyena,
							this.Const.EntityType.Serpent
						],
						[
							this.Const.EntityType.Alp,
							this.Const.EntityType.LegendDemonAlp,
							this.Const.EntityType.Unhold,
							this.Const.EntityType.UnholdFrost,
							this.Const.EntityType.UnholdBog,
							this.Const.EntityType.LegendRockUnhold,
							this.Const.EntityType.Hexe,
							this.Const.EntityType.LegendHexeLeader
						],
						[
							this.Const.EntityType.Lindwurm,
							this.Const.EntityType.Schrat,
							this.Const.EntityType.LegendGreenwoodSchrat,
							this.Const.EntityType.LegendGreenwoodSchratSmall,
							this.Const.EntityType.LegendStollwurm
						]
					];

					if (beasts[this.Contract.m.Size].find(_actor.getType()) != null && !_actor.getFlags().has("tail"))
					{
						this.Flags.set("HeadsCollected", this.Flags.get("HeadsCollected") + 1);
					}
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
			if (s.ID == "TaskSmall")
			{
				s.Title = "Big Game Hunt";
			}
			if (s.ID == "SuccessSmall")
			{
				s.Text = "[img]gfx/ui/events/event_04.png[/img]{You come back and dump the beastly heads onto %employer%\'s floor. He looks up from his desk.%SPEECH_ON%Well that was unwarranted. Fetch the man his money, and fetch a servant to clean this mess.%SPEECH_OFF% | %employer% welcomes your return, though he keeps his distance. He\'s staring at your cargo.%SPEECH_ON%A fitting return, sellsword. I\'ll have one of my men count the heads and pay you according to our agreement.%SPEECH_OFF% | The slayings are produced for %employer%\'s approval. He nods and waves you away.%SPEECH_ON%Appreciated, but I need not look at those ghastly things a moment longer. %randomname%, come hither and pay this sellsword his money.%SPEECH_OFF% | %employer% welcomes you back and looks over your wares.%SPEECH_ON%Absolutely disgusting. Splendid! Here is your pay, as agreed upon.%SPEECH_OFF% | You show the heads to %employer% who counts them with a wiggling finger and his lips whispering numbers. Finally, he straightens up.%SPEECH_ON%I don\'t have time for this shite. %randomname%, yes you servant, get over here and count these heads and pay the sellsword the agreed amount for each.%SPEECH_OFF% | %employer% is eating an apple as he walks over to see what you\'ve returned with. He stares into the satchel of ghastly beast heads. He takes a huge bite of the apple.%SPEECH_ON%Ehpressive rehsalts, sehswahrd.%SPEECH_OFF%He quickly chews and swallows in a big gulp.%SPEECH_ON%See my servant standing idly yonder with the purse. He\'ll pay out what you are owed.%SPEECH_OFF%The nobleman tosses the half-eaten apple and fetches himself another. | %employer% has a child with him when you enter his room. The kiddo rushes to see what you\'ve brought, then retreats in a screaming fit. The nobleman nods.%SPEECH_ON%Suppose that means you got what I paid you for. My servant %randomname% will count the heads and pay what you are owed.%SPEECH_OFF% | You lug the heads into %employer%\'s room. He raises an eyebrow.%SPEECH_ON%Did you have to drag those all the way in here? Look, you\'ve left a stain! Why didn\'t you just fetch a servant, that\'s what they\'re there for. By the old gods the smell is worse than the stains!%SPEECH_OFF%The nobleman snaps his fingers at a man standing with a purse.%SPEECH_ON%%randomname%, count the heads and see to it that the sellsword gets his pay.%SPEECH_OFF% | You unfurl the sack of heads and let them pile onto %employer%\'s floor. He stands up.%SPEECH_ON%That\'s not on the rug, is it?%SPEECH_OFF%A servant runs over and kicks the heads apart. He quickly shakes his head no. The nobleman nods and slowly sits down.%SPEECH_ON%Good. You there, %randomname%, get to counting and then pay this mess making sellsword his dues. And by the way, mercenary, take it easy on the presentation next time, alright?%SPEECH_OFF% | You lug a satchel of beast scalps and heads into %employer%\'s room. Popping the lid, you start to tip it forward. A servant\'s eyes go wide and he rushes forward, slamming into the satchel and tilting it back over. The lid clatters closed over his fingers and he chokes down a yelp.%SPEECH_ON%Thank you, mercenary, but the noble sir would prefer we count these without spilling them all over the floor. I will add up the totals and pay you once I am finished.%SPEECH_OFF% | %employer% reviews your handiwork.%SPEECH_ON%Impressive. Disgusting. Not you, the beasts. I mean you\'re a filthy sort, sellsword, but these foul beasts are the antithesis of hygiene.%SPEECH_OFF%You don\'t know what that word means, or the other one for that matter. You simply ask that he count the heads and give you what you\'re owed. | %employer% counts the heads and then leans backs. He shrugs.%SPEECH_ON%I thought they\'d be scarier.%SPEECH_OFF%You mention that they\'ve but a slightly different affect on one\'s courage when still attached to the beastly torsos. The nobleman shrugs again.%SPEECH_ON%I suppose so, but my mother lost her head to an executioner\'s blade and she looked all the scarier settin\' in that basket staring up at the world.%SPEECH_OFF%You don\'t know what to say to that. You ask the man to pay you what you\'re owed. | %employer% eyes the beastly heads you\'ve deposited upon his floor. A servant with a broom counts them one by one, subtracting from one pile to add to another. When he\'s finished the accounting he reports his numbers and the nobleman nods.%SPEECH_ON%Good work, sellsword. The servant will fetch your pay.%SPEECH_OFF%The lowborn sighs and puts the broom away. | %employer% opens the satchel of beastly scalps and skulls. He purses his lips, sniffs, and claps it back closed. The nobleman instructs one of his servants to count out the remains and pay you according to the agreement.%SPEECH_ON%A good job, sellsword. The townsfolk are grateful that I paid you to take care of this.%SPEECH_OFF% | %employer% whistles as he stares at your collection of skulls and scalps.%SPEECH_ON%That\'s a hell of a sigh if there ever was one. For work of this nasty nature I should consider paying you extra, which I won\'t, but the thought crossed my mind and that\'s what really counts.%SPEECH_OFF%}";
			}
		}
	}
});
