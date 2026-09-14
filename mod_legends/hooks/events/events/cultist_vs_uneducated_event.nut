::mods_hookExactClass("events/events/cultist_vs_uneducated_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "B", function(_screen) {
			_screen.start <- function (_event) {
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());

				this.List.push(::Legends.EventList.changeMoralReputation(-1));

				_event.m.Uneducated.getBackground().Convert();
				_event.m.Uneducated.getBackground().m.RawDescription += " " + _event.m.Cultist.getName() + " helped " + _event.m.Uneducated.getName() + " see the darkness.";
				_event.m.Uneducated.getBackground().buildDescription(true);
				_event.m.Uneducated.getSkills().update();
				//set relations
				this.List = [{
					id = 13,
					icon = _event.m.Uneducated.getBackground().getIcon(),
					text = _event.m.Uneducated.getName() + " has been converted to a Cultist"
				}];

				this.List.push(::Legends.EventList.changeResolve(_event.m.Cultist, 2));
			}
		});
		::Legends.Screens.hook(this, "B", function(_screen) {
			local start = _screen.start;
			_screen.start <- function (_event) {
				this.List.push(::Legends.EventList.changeMoralReputation(2));
				start(_event);
			}
		});
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 4)
			return;

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers ) {
			switch (true)
			{
				case bro.getFlags().get("IsSpecial"):
				case bro.getFlags().get("IsPlayerCharacter"):
					continue;
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist):
					cultist_candidates.push(bro);
					continue;
				case ::Legends.Backgrounds.has(bro, ::Legends.Background.Slave):
				case ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendPuppet):
				case ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendCommanderBerserker):
				case ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendBerserker):
				case ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendDonkey):
					continue;
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist):
				{
					cultist_candidates.push(bro);
					continue;
				}
			 	case bro.getSkills().hasTrait(::Legends.Trait.Dumb):
				case bro.getSkills().hasSkill("injury.brain_damage"):
				{
					uneducated_candidates.push(bro);
					continue;
				}
				case bro.getSkills().hasTrait(::Legends.Trait.Bright):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble):
				case bro.getBackground().isBackgroundType(this.Const.BackgroundType.Educated):
				case !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Lowborn):
					continue;
			}
			uneducated_candidates.push(bro);
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0)
			return;

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.Uneducated = uneducated_candidates[this.Math.rand(0, uneducated_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len() * 5;
	}
})
