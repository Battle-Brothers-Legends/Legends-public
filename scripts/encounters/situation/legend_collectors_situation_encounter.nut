this.legend_collectors_situation_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
        Dude = null;
    },
    function create() {
        this.createScreens();
        this.m.Name = "{While at %settlement... | Strolling through %settlement%. | Something\'s up at %settlement.}";
        this.m.Name = "Collectors in Town";
    }

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Strolling around the city...",
            Text = "[img]gfx/ui/events/event_70.png[/img]{By the side of %settlement%\'s market, a couple town militia are trying to restrain an irate old man, with questionable success. You attempt to go around him, but the man suddenly lunges at your feet and grabs your hand in a vice, kneeling like a petitioner before a king. %SPEECH_ON%Sellsword, sellsword, you need to help me! He took them, the ungrateful bastard, he took all of them!%SPEECH_OFF% You debate whether or not it\'d be in bad taste to kick an old man in front of half of %settlement% before tiredly motioning the man to get on with it. My grandson, a pox on him, has stolen all my possessions, he intends to sell it all because of some damned collectors in town! He thinks he\'ll make a fortune bartering my history, my life, away!%SPEECH_OFF% You lift an eyebrow and glance at the militia who are trying to covertly abscond while you deal with the oldtimer. What collectors? %SPEECH_ON%Bunch of crazy farks who want monster parts are in town, fools are offering crowns hand over fist for any chicken bone that looks like it could be from an unhold.%SPEECH_OFF% The old man at your feet seems to straighten slightly with an oddly youthful gleam in his eye. %SPEECH_ON%I was a soldier in my old life, I had an entire unhold skull, among other things! I lost my brother and countless brothers in arms acquiring those, and I\'ll be damned if I\'m going to lose them all because my good-for-nothing grandson can\'t keep a roof over our heads!%SPEECH_OFF% The militiamen and the old man start arguing again. You use this as your opportunity to enter the market. Apparently there are traders in town. }",
            Image = "",
            List = [],
            Options = [
                {
                    Text = "Perhaps these collectors will also buy our own trophies at a premium.",
                    function getResult(_event) {
                        local roll = this.Math.rand(1,100);
                        local check = 0;
                        foreach (b in brothers){
                            if (b.getBackground().getID == background.retired_soldier){
                                check = 1;
                            }
                        }
                        if (roll<=15 && check != 1){//to prevent repeats. Unclear if there's a better way to do this, lmk
                            return "proposal";
                        }
                        else {
                            return 0;
                        }


                        return 0;
                    }
                }
            ],
            function start(_event) {}
        }]);
        this.m.Screens.push({
			ID = "proposal",
			Title = "A proposal...",
			Text = "[img]gfx/ui/events/event_17.png[/img]{As you walk away, you hear a pained grunt followed by a shriek and a thud. You turn around and find the old man shaking out his hand. One of the militia men is curled up and groaning on the ground, the other is face down in the mud. %SPEECH_ON% How about a new proposal sellsword? You get me back my things, and I\'ll serve you faithfully, free of charge! Not like I can stay here after this display anyway.%SPEECH_OFF% You mull it over. Clearly the man can fight. The question is would it be worth getting the %company_name% involved in this?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Maybe we can make use of this man?",
					function getResult( _event )
					{
						return "Recruitment";
					}

				},
				{
					Text = "My answer has not changed.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
            function start(_event) {}
		});

        this.m.Screens.push({
			ID = "Recruitment",
			Title = "Confrontation",
			Text = "[img]gfx/ui/events/event_17.png[/img]{You march with the old man who quickly locates his grandson in the midst of the market. He takes him in a headlock and starts shaking him from behind. A few of the passerby give concerned glances but quickly find better things to look at when they meet your eyes. %SPEECH_ON%Where are they, you bastard?!%SPEECH_OFF% He throws his grandson onto the mud. A young man with shadows under his eyes glares back at you. Hard times indeed. %SPEECH_ON%You\'re too late you senile old fool, the last of the merchants are already gone.%SPEECH_OFF% Before you can stop the old man, he takes up a dagger and stabs his grandson in the eye. He's dead before he hits the ground. %SPEECH_ONWell fark. This got out of hand wouldn\'t you say sellsword?%SPEECH_OFF% You shake your head and grab the man's shoulder. It's time to leave %settlement%.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Today certainly got more interesting.",
					function getResult( _event )
					{
						return "Battle";
					}

				},
			],
            function start(_event) {
                local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"retired_soldier_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "You found %name% in " + ::Legends.S.getClosestSettlement().getName() + ", trying to get back his trophies after his grandson stole them. While you did not get them back, you did get to slaughter the town militia together, and the man\'s been at your side faithfully ever since.'	.";
				_event.m.Dude.getBackground().buildDescription(true);
				::Legends.Traits.grant(_event.m.Dude, ::Trait.Loyal);
				this.Characters.push(_event.m.Dude.getImagePath());
            }
		});
        
        this.m.Screens.push({
			ID = "Battle",
			Title = "Blue Skies and a Battle -- ",
			Text = "[img]gfx/ui/events/event_17.png[/img]{Having quickly gathered the rest of the %company_name%, who greet their newest member surprisingly well despite having alienated all of %settlement% and killing his kin in broad daylight, you march the company towards the gates as quickly as you can. Some hundred paces from the gates the militia cuts you off, and raises their spears. %SPEECH_ON%{You are all under arrest for the murder of a citizen and assaulting two keepers of the peace! | Halt! You brigands have murdered in this town and are to be tried as criminals.}%SPEECH_OFF% Before you can attempt to smooth things over, the %company_name% start laughing and jeering. The idea of this green militia stopping your seasoned company is admittedly laughable. Evidently this incensed the commander of the militia, who all - in a somewhat haphazard manner - lower their spears and charge.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Time to see if the old man can fight in a battle.",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(-2);
						this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationBetrayal, "You killed some of the militia");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Militia, this.Math.rand(100, 140), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				},
			],
            function start(_event) {}
		});
    }

    function isValid(_settlement) {
        if (!_settlement.hasSituation("situation.collectors"))
            return false;
        return !isOnCooldown();
    }
    function onClear(){
        this.m.Dude = null;
    }
})
