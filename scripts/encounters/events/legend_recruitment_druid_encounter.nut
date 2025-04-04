this.legend_recruitment_druid_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {
		Druid = null
    },
    function create() {
        this.createScreens();
        this.m.Type = "encounter.legend_recruitment_druid_encounter";
        this.m.Name = "The forest dies";
		this.m.Cooldown = 60 * ::World.getTime().SecondsPerDay;
	}

    function createScreens() {
        this.m.Screens.extend([{
            ID = "Start",
            Title = "The forest burns...",
			Text = "[img]gfx/ui/events/event_25.png[/img]{From a distance, you see a great blaze over a section of the old woods. You reckon it\'s perhaps a little under an hour\'s trek, but you feel oddly compelled to pay tribute to the death of something that has spanned so many centuries.}"
            Image = "",
            List = [],
			Characters = [],
			Options = [

            {
                Text="Let us pay our respects."
                    return "recruit";

            }
			{
				Text = "A frivolous whim, nothing more.",
				function getResult(_event) {
					::World.getTemporaryRoster().clear();
					_event.m.Druid = null;
					return 0;
				}
			}]
		this.m.Screens.push({
			ID = "recruit",
			Text = "[img]gfx/ui/events/event_76.png[/img]{The flames are truly blinding. So blinding you barely can see the spectre approaching from a small copse of not-yet-burned wood. The spectre lowers their hood, revealing an ashen face slick with tears. In a croaky voice, as if unused to the difficulty of the task, the person speaks. %SPEECH_ON%More witnesses to my failure.%SPEECH_OFF% You frown, and ask if the inferno is their fault. The sentence is hardly finished before a snap of vines lurch towards you before falling drunkenly to the ground. A poor display of magic, but still a display. Drawing your sword, you approach the mysterious figure. %SPEECH_ON%I started this?! How dare you, you... you%SPEECH_OFF% the witch collapses and begins to heave their stomach onto the ground. Having finished, they rise into a kneeling position and stare at the flames. %SPEECH_ON%I am a druid. For generations, we have protected this sacred wood. Until me. A band of raiders were passing through, trying to hide from pursuers, and demanded I feed them. When I refused, they torched my cabin. Then as they left...%SPEECH_OFF% They give a weak gesture towards the conflagration before you. %SPEECH_ON%I have failed the cause of centuries. All but a trickle of my magic has deserted me. I am nothing now. I have nothing but hate. I have a request, warrior with steel. Kill me. Let me be with the forest I have so grossly failed.%SPEECH_OFF% You shake your head slowly. This is a broken soul before you. Frankly, you\'re not sure if they won\'t just kill themselves right here and now. Perhaps a druid could be useful to a mercenary company?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "How would you like to turn that hate into something useful?",
					function getResult( _event )
					{
					::World.getPlayerRoster().add(_event.m.Druid);
					::World.getTemporaryRoster().clear();
					_event.m.Druid.onHired();
					_event.m.Druid = null;
					return 0;
					}
				},
				{
					Text = "Forests can regrow. You will regain your stewardship in time.",
					function getResult( _event )
					{
						return 0;
					}

				},
			],
		});
            function start(_event) {
				local roster = ::World.getTemporaryRoster();
				_event.m.Druid = roster.create("scripts/entity/tactical/player");
				_event.m.Druid.setStartValuesEx(["legend_druid_background"]);
				this.Characters.push(_event.m.Druid.getImagePath());
            }
        }]);
    }
    function isValid(_settlement) {
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.Type != this.Const.World.TerrainType.Forest | currentTile.Type != this.Const.World.TerrainType.SnowyForest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}
		if (::World.getPlayerRoster().getSize() >= ::World.Assets.getBrothersMax())
			return false;

		local totalbrothers = 0;
		local brotherlevels = 0;
		foreach (bro in ::World.getPlayerRoster().getAll()) {//vala druid check
		// 	if (bro.getBackground().getID() == "background.legend_vala")
		// 		return false;
		// 	if (bro.getBackground().getID() == "background.legend_commander_vala")
		// 		return false;
			totalbrothers += 1;
			brotherlevels += bro.getLevel();
		}

		if (totalbrothers < 1 || brotherlevels < 30)
			return false;

        return true;
    }

	function onClear() {
		this.m.Druid = null;
	}
})
