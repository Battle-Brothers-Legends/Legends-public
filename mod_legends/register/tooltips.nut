// MSU Tooltips Features
// Documentation available at https://github.com/MSUTeam/MSU/wiki/Tooltips
// Setup custom tooltips to bind to UI elements
::Legends.getEncounterUIData <- function(_data) {
	local encounterType = _data.encounterType;
	local encounter = ::World.Encounters.getEncounter(_data.encounterType);
	local title;
	if (encounter != null)
		title = encounter.getName();
	if (title == null)
		title = "Error";
	return [{
		id = 1,
		type = "title",
		text = title
	}, {
		id = 2,
		type = "description",
		text = "Click to check what is going on here."
	}];
}

::Legends.Mod.Tooltips.setTooltips({

	// Camping - Commander's Tent
	CampingPresets = {
		ButtonSavePreset = ::MSU.Class.BasicTooltip("Save Preset","Save the current camping assignments to the currently selected numbered preset slot"),
		ButtonLoadPreset = ::MSU.Class.BasicTooltip("Load Preset","Load the camping assignments from the currently selected numbered preset slot"),
		ButtonPresetName = ::MSU.Class.BasicTooltip("Customize Preset Name","Give a custom name to the currently selected numbered preset slot"),
		ButtonPresetSlot = ::MSU.Class.BasicTooltip(
			@(_data) "Preset Slot " + (_data.index + 1),
			function(_data)
			{
				local name = ::World.Camp.getPresetName(_data.index);
				if (name)
					return name;
				return "";
			}
		),
		PresetNameDialog = {
			ButtonDelete = ::MSU.Class.BasicTooltip("Delete Preset Name","Delete the current preset slot's custom name and close this pop-up"),
			ButtonCancel = ::MSU.Class.BasicTooltip("Cancel Changes","Discard any changes and close this pop-up"),
			ButtonOk = ::MSU.Class.BasicTooltip("Save Preset Name","Save the input name as the current preset slot's custom name and close this pop-up"),
		},
	}

	Camping = {
		ButtonAssignAll = ::MSU.Class.BasicTooltip("Assign All","Assign all mercenaries to the current tent"),
		ButtonConfigure = ::MSU.Class.CustomTooltip(function(_data){
			local ret = [];
			/*switch(_data.tent)
			{
				case ::Legends.Camp.CampBuildings.Hunter:
					if (::World.Camp.getBuildingByID(::Legends.Camp.CampBuildings.Hunter).getUpgraded())
					{
						ret.push({
							id = 0,
							type = "title",
							text = "Hunting Mode",
						});
						ret.push({
							id = 1,
							type = "description",
							text = "Customize the priorities of the hunting party."
						})
					}
					else
					{
						ret.push({
							id = 0,
							type = "title",
							text = "Hunting Mode",
						});
						ret.push({
							id = 1,
							type = "description",
							text = "Customize the priorities of the hunting party.\n\n" + ::Const.UI.getColorized("Requires the Kitchen Tent upgrade",::Const.UI.Color.NegativeValue),
						})
					}
					break;
				default:*/
					ret.push({
						id = 0,
						type = "title",
						text = "Configure",
					});
					ret.push({
						id = 1,
						type = "description",
						text = "There are no special configurations for this tent."
					});
			//}
			return ret;
		}),
	},

	CampHealerIntensiveCare = {
		Manual = ::MSU.Class.BasicTooltip("Selected", "Toggle which brothers are to receive intensive treatment inside the healer's tent."),
		Auto = ::MSU.Class.BasicTooltip("All", "All brothers are treated intensively automatically whenever required.")
	},
	CampGatheringMode = {
		Foraging = ::MSU.Class.BasicTooltip("Foraging",	"Allow your gatherers to Forage supplies."),
		Hunting = ::MSU.Class.BasicTooltip("Hunting", "Allow your gatherers to Hunt for meat and trophies."),
		Mining = ::MSU.Class.BasicTooltip("Mining", "Allow your gatherers to Mine for ores and gemstones."),
		Woodcutting = ::MSU.Class.BasicTooltip("Woodcutting", "Allow your gatherers to cut trees down to procure wood.")
	},
	CombatResult = {
		Sort = ::MSU.Class.BasicTooltip("Sort Items", "Sort items by type.")
	},
	Encounters = {
		Element = ::MSU.Class.CustomTooltip(@(_data) ::Legends.getEncounterUIData(_data))
	},

	Placeholder = ::MSU.Class.BasicTooltip("Placeholder","Under development"),
});
