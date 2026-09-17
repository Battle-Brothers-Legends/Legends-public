this.stables_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {},

	function create() {
		this.building.create();
		this.m.ID = "building.stables";
		this.m.Name = "Stables";
		this.m.Description = "Stables for horses";
		this.m.UIImage = "ui/settlements/building_14";
		this.m.UIImageNight = "ui/settlements/building_14_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Stables";
		this.m.TooltipIcon = "ui/icons/buildings/stables.png";
		this.m.Sounds = []; // should probably use horses or donkeys rather than dogs at one point
		for (local i = 0; i <= 2; i++) {
			this.m.Sounds.push({
				File = format("ambience/buildings/kennel_cage_%02d.wav", i),
				Volume = 1.0,
				Pitch = 1.0
			});
		}
		for (local i = 0; i <= 12; i++) {
			this.m.Sounds.push({
				File = format("ambience/buildings/kennel_dog_%02d.wav", i),
				Volume = 1.0,
				Pitch = 1.0
			});
		}
		this.m.SoundsAtNight = this.m.Sounds.map(@(s) {
			File = s.File,
			Volume = 0.5,
			Pitch = s.Pitch
		});
	}

	function onClicked(_townScreen) {
		_townScreen.getStablesDialogModule().setRosterID(this.m.Settlement.getID());
		_townScreen.showStablesDialog();
		this.pushUIMenuStack();
	}

	function onSettlementEntered() {}

	function onUpdateStablesList(_list) {
		_list.push(::Legends.Background.LegendHorseRouncey);
		_list.push(::Legends.Background.LegendDonkey);
	}

	function onSerialize(_out) {
		this.building.onSerialize(_out);
	}

	function onDeserialize(_in) {
		this.building.onDeserialize(_in);
	}
});
