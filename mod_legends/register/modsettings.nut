::Legends.Settings <- {
	skipCamp = @() ::Legends.Mod.ModSettings.getSetting("SkipCamp").getValue() || ::Legends.S.oneOf(::World.Assets.getOrigin().getID(), "scenario.legend_risen_legion", "scenario.legends_solo_necro", "scenario.raiders")
}

function addNCSetting( _page, _setting ) {
	_setting.getData().NewCampaign <- true;
	_setting.getData().NewCampaignOnly <- true;
	_page.addElement(_setting);
}

local map = ::Legends.Mod.ModSettings.addPage("Map Options");

//Setting, Default, Min, Max, ?, Name, Description
addNCSetting(map, ::MSU.Class.RangeSetting("WaterLevel", 50, ::Const.World.Settings.MinWaterSetting, ::Const.World.Settings.MaxWaterSetting, 1, "Water", "Determines the amount of water on the map. Default is 50."));
addNCSetting(map, ::MSU.Class.RangeSetting("Snowline", 85, 75, 95, 1, "Snowline", "Determines where the snowline is generated. Default is 85. This value is inverted. A value of 10 would mean the top 90% of the map is snow."));
addNCSetting(map, ::MSU.Class.RangeSetting("Settlements", 19, 19, 27, 1, "Settlements", "Maximum number of settlements. Depending on map size, this will try to add the number of settlements on the slider. It will keep the same ratio of settlement types as default Battle Brothers maps. Minimum distance between settlements is 12 tiles. Vanilla default is 19."));
addNCSetting(map, ::MSU.Class.RangeSetting("Factions", 3, 2, 6, 1, "Factions", "Maximum number of Factions to try and generate. Depending on map size, this may not add all the factions on the slider."));

addNCSetting(map, ::MSU.Class.SettingsDivider("MapDivider1"));

addNCSetting(map, ::MSU.Class.BooleanSetting("StackCitadels", false, "Decked Out Citadels", "If enabled, every Citadel will start with all those building attachments map scummers are re-rolling for."));
addNCSetting(map, ::MSU.Class.BooleanSetting("AllTradeLocations", false, "All trade buildings available", "If enabled, ensures there is at least one of each trade location building on the map."));
//addNCSetting(map, ::MSU.Class.BooleanSetting("DebugMap", false, "(Debug) Show Entire Map", "If enabled, the map will start completely revealed and all enemies and camps will be visible."));

local config = ::Legends.Mod.ModSettings.addPage("Campaign Options");

addNCSetting(config, ::MSU.Class.RangeSetting("FemaleGenderPercent", 25, 0, 100, 5, "Allied Female Character %", "The higher the value, the more allied female characters will appear in the game. Default at 25%. Some characters are locked as male or female only and are not affected by this setting."));
addNCSetting(config, ::MSU.Class.RangeSetting("EnemyFemaleGenderPercent", 25, 0, 100, 5, "Enemy Female Character %", "The higher the value, the more enemy female characters will appear in the game. Default at 25%. Some characters are locked as male or female only and are not affected by this setting."));
addNCSetting(config, ::MSU.Class.EnumSetting("GenderEquality", "Enabled", ["Enabled", "Disabled (Cosmetic)"], "Gender Stat Difference", "When enabled female characters receive +10 fatigue, but -10 hit points.\n\n[u]Enabled[/u]\nBeing female has gameplay effects.\n\n[u]Disabled (Cosmetic)[/u]\nBeing female has no effect on stats."));
addNCSetting(config, ::MSU.Class.EnumSetting("CommanderAvatarGender", "Random", ["Random", "Male", "Female"], "Commander Avatar Gender", "Sets the gender of the commander in scenarios with an avatar present (apart from random scenarios). Leave at random to have it follow the percentage specified in Female Character % setting."));
local myEnumTooltip = "Specialist Skills bonuses (in example Poacher\'s arm) count as 25% for non specialist weapons, but will grow by 5% according to the following rules.\n\n[u]Level[/u]\n5% per level (100% at level 16)\n\n[u]Week in company (SSU Style)[/u]\n5% per 7 days the mercenary has been in the company (100% at day 105)\n\n[u]Training[/u]\n5% per camp training level (100% when training completed)";
// addNCSetting(config, ::MSU.Class.EnumSetting("SpecialistSkillsSetting", "Level", ["Level", "Week in company", "Training"], "Specialist Skills Rules", myEnumTooltip));
// deprecated with the removal of spec skills
addNCSetting(config, ::MSU.Class.SettingsDivider("ConfigDivider1"));
// addNCSetting(config, ::MSU.Class.RangeSetting("DynamicDayToSkip", 150, 0, 150, 10, "Dynamic Troops Day To Skip", "Impacts how fast elite enemies start appearing on the map. If you leave it at 150 they will by default choose according to difficulty: 30 - Legendary, 60 Expert, 90 Veteran and 120 beginner."));
addNCSetting(config, ::MSU.Class.BooleanSetting("SkipCamp", true, "Skip Camp Tutorial", "If disabled, you will gradually unlock camping activities by visiting towns. Useful for first playthroughs. \n\n Detail: skips the camp unlock events and ambition, you still need to buy upgrades."));
addNCSetting(config, ::MSU.Class.BooleanSetting("RecruitScaling", true, "Recruit Scaling", "If enabled, new recruits will gain levels based on the levels in your party and your renown in the world. \n\n  Details: The maximum level of recruits is increased by half the average level of mercs in your company, averaged with your reputation divided by 1,000. \n\n For example: if your company were all level 10, and your renown was 10,000, new recruits could gain up to 7 levels rounded down. \n\n This in addition to normal recruit level variance."));

local general = ::Legends.Mod.ModSettings.addPage("General");
general.addTitle("Gameplay", "Gameplay");
general.addElement(::MSU.Class.RangeSetting("MinimumChanceToHit", 5, 0, 100, 1, "Minimum hitchance", "Slider for minimum hitchance percentage. Pushing this slider too far will result in no chance to hit for anyone."));
general.addElement(::MSU.Class.RangeSetting("MaximumChanceToHit", 95, 0, 100, 1, "Maximum hitchance", "Slider for maximum hitchance percentage. Pushing this slider too far back will result in no chance to hit for anyone."));
myEnumTooltip = "Define AI Rotation rules: 'Default' is the Vanilla behaviour, AI is free to rotate itself and your bros as long as the skill allows; 'Limited' AI can only rotate itself, but not your bros (unless they have the Twirl Perk); 'Disabled' disable AI Rotation entirely";
general.addElement(::MSU.Class.EnumSetting("AiRotation", "Default", ["Default", "Limited", "Disabled"], "AI Rotation Rules", myEnumTooltip));
general.addTitle("Pause", "Pause");
general.addElement(::MSU.Class.BooleanSetting("PauseOnEnemySighted", true, "Pause On Enemy Sighted", "Game pause when new enemy group is sighted"));
general.addElement(::MSU.Class.BooleanSetting("PauseOnEvents", true, "Pause On Events", "Pause on events, encounters, ambitions"));
general.addElement(::MSU.Class.BooleanSetting("PauseOnMorningCamping", false, "Pause Every Daybreak While Camping", "Pause every daybreak while camping (useful for entering towns)"));
general.addElement(::MSU.Class.BooleanSetting("PauseOnNewDayCamping", false, "Pause Every Noon While Camping", "Pause every noon while camping (useful for certain mechanics that reset on a new day)."));
general.addElement(::MSU.Class.BooleanSetting("PauseOnMovementStop", false, "Pause on Movement Stop", "Pause gameplay every time you stop moving"));
general.addElement(::MSU.Class.BooleanSetting("ResumeOnMovementStart", false, "Resume on Movement Start", "Resume gameplay every time you start moving"));
general.addTitle("QoL", "Quality of Life");
myEnumTooltip = "Define how Blueprints are shown: 'All Ingredients Available' is the Vanilla behavior; 'One Ingredient Available' shows recipes when one ingredient is fully satisfied; 'Always' shows all recipes at all time";
general.addElement(::MSU.Class.EnumSetting("ShowBlueprintsWhen", "All Ingredients Available", ["All Ingredients Available", "One Ingredient Available", "Always"], "Show Blueprints when", myEnumTooltip));
//general.addElement(::MSU.Class.BooleanSetting("AutoRepairLayer", false, "Autorepair Layer", "Any Body or Helmet Layer that you strip from a piece of armor is automatically marked as 'to be repaired'.")); // setting disabled with the introduction of inventory management automation
general.addElement(::MSU.Class.BooleanSetting("ShowPotentialOnBars", false, "Show Stat Potential On Bars", "Show brother stat potential at level 12 directly on bars."));
general.addElement(::MSU.Class.BooleanSetting("ShowPotentialOnItems", false, "Show Stat Potential On Items", "Show named items stat potential on named properties."));
general.addElement(::MSU.Class.BooleanSetting("ClickPresetToSwitch", false, "Faster Camping Preset Switch", "Clicking on the camping preset slot immediately applies the preset"));
general.addElement(::MSU.Class.BooleanSetting("SellDialogNamed", true, "Sell Famed Dialog", "Should confirmation dialog appear when selling famed items?"));
general.addTitle("Saves", "Saves");
general.addElement(::MSU.Class.RangeSetting("AutosaveSlots", 5, 1, 9, 1, "Autosave Slots", "Number of autosave slots the game cycles through."));
general.addElement(::MSU.Class.RangeSetting("QuicksaveSlots", 5, 1, 9, 1, "Quicksave Slots", "Number of quicksave slots the game cycles through."));

local tooltip = ::Legends.Mod.ModSettings.addPage("Tooltips / UI");
tooltip.addTitle("TooltipCombat", "Tooltips - Combat");
tooltip.addElement(::MSU.Class.BooleanSetting("EnhancedTooltips", false, "Enhanced Enemy Tooltips", "Enemy tooltips in tactical battles will show more information, like perks and statuses"));
tooltip.addDivider("TooltipDivider1");
tooltip.addTitle("TooltipInventory", "Tooltips - Inventory");
tooltip.addElement(::MSU.Class.BooleanSetting("ShowArmorPerFatigueValue", true, "Show Armor/Fatigue Efficiency", "Show the Armor value gained per unit of Fatigue cost of an Armor/Helmet Piece/Layer in the Tooltip when the player mouses over an individual Armor/Helmet Piece/Layer.\n\nUseful for people who like to buy their groceries based on price per unit weight"));
tooltip.addElement(::MSU.Class.BooleanSetting("ShowExpandedArmorLayerTooltip", true, "Expanded Armor Layer Tooltips", "Show the Armor value and Fatigue cost of each Armor/Helmet layer in the Tooltip when the player mouses over a combined Armor/Helmet set.\n\nDisabling this may help reduce the Tooltip length to fit better on lower resolution screens"));
tooltip.addElement(::MSU.Class.BooleanSetting("ShowItemTradeHistory", true, "Show Item Trade History", "Show the trade history of items, such as where they were produced or imported from.\n\nHas no effect if World Economy is disabled"));
tooltip.addDivider("TooltipDivider2");
tooltip.addTitle("TooltipCharacter", "Tooltips - Character");
tooltip.addElement(::MSU.Class.BooleanSetting("ShowCharacterBackgroundType", true, "Show Character Background Types", "Show a character's Background Types in Tooltips.\n\nUseful when playing Origins with additional gameplay mechanics based on Background Types"));
tooltip.addDivider("TooltipDivider3");
tooltip.addTitle("TooltipWorldMap", "Tooltips - World Map");
tooltip.addElement(::MSU.Class.BooleanSetting("ExactEngageNumbers", false, "Exact engagement numbers", "Display exact engagement numbers."));
tooltip.addDivider("TooltipDivider4");
tooltip.addTitle("TooltipUI", "UI");

local cpLight = tooltip.addElement(::MSU.Class.ColorPickerSetting("HighlightLightBackground", "2,55,189,1", "Highlighted Text (Light Background)", "Customize the color for special highlighted text occurring in light backgrounds, such as in tooltips"));
::Const.UI.Color.getHighlightLightBackgroundValue <- @() "#" + cpLight.getValueAsHexString().slice(0,6);
local cpDark = tooltip.addElement(::MSU.Class.ColorPickerSetting("HighlightDarkBackground", "111,145,201,1", "Highlighted Text (Dark Background)", "Customize the color of special highlighted text occurring in dark backgrounds, such as in events"));
::Const.UI.Color.getHighlightDarkBackgroundValue <- @() "#" + cpDark.getValueAsHexString().slice(0,6);
local cpFade = tooltip.addElement(::MSU.Class.ColorPickerSetting("FadeDarkBackground", "135,114,81,1", "Faded Text (Dark Background)", "Customize the color of faded text occurring in dark backgrounds, such as in events"));
::Const.UI.Color.getFadeDarkBackgroundValue <- @() "#" + cpFade.getValueAsHexString().slice(0,6);
tooltip.addElement(::MSU.Class.EnumSetting("ContractCategoryIconAlignment", "Middle", ["Left","Middle","Right","Below"], "Contract Category Icon Alignment", "Adjust the position of the Contract Category icon at the bottom of Contracts in the Settlement screen"));

local betterobituary = ::Legends.Mod.ModSettings.addPage("Obituary");
betterobituary.addBooleanSetting("SwapPerks",    false, "Show Perks", "Swaps the trait/permanent injuries columns for perks.");
betterobituary.addBooleanSetting("SwapStats", 	 false, "Swap Stat Order", "Swaps the position of first 4 stats (hp, fatigue, initiative, bravery) with the last 4 (attack / defense).");
betterobituary.addBooleanSetting("StackedStars", false, "Stacked Talent Stars", "Replace the 3 star talent icon (row of 3) with a triangle of stars.");
betterobituary.addDivider("Divider");
betterobituary.addBooleanSetting("HideObituarySetting",    false, "Hide Obituary Settings", "Hide the checkbox settings shown in top right of the obituary.\n\nThese mirror the settings above, providing a way to change them whilst in the obituary without using hotkeys, or simply to view the current settings.");
betterobituary.addBooleanSetting("HideDismissOption", false, "Hide Dismiss Option", "Hide the checkbox option for adding a bro to the obituary when dismissing them.");
betterobituary.addRangeSetting("Backgroundspecific", 50, 0, 100, 1, "Background specific fates", "Chance of getting a background specific message when dismissing a bro, as opposed to a generic message.\n\ne.g. Crusader:\n 'Continued their righteous war' vs 'Parted amicably' \n\nSet to 0 to disable and only use generic messaging." );
betterobituary.addDivider("Divider");
betterobituary.addTitle("DisplayLimit", "Display Limit (Icons shrink beyond defaults)");
betterobituary.addRangeSetting( "show_num_traits", 8, 1, 12, 1, "Traits" );
betterobituary.addRangeSetting( "show_num_perminjuries", 3, 1, 5, 1, "Permanent Injuries" );
betterobituary.addRangeSetting( "show_num_perks", 10, 1, 20, 1, "Perks" );
betterobituary.addDivider("Divider");
betterobituary.addTitle("TooltipSettings", "Tooltip Settings");
betterobituary.addColorPickerSetting("obituary_hotkey_text_colour", "255,255,0,1", "Hotkey Text Colour");

// Obituary settings hotkeys
::Legends.Mod.Keybinds.addJSKeybind("toggle_perks",				"shift+p", "Obituary - Show Perks");
::Legends.Mod.Keybinds.addJSKeybind("toggle_stat_order",		"shift+s", "Obituary - Swap Stat Order");
::Legends.Mod.Keybinds.addJSKeybind("stacked_talent_stars",		"shift+t", "Obituary - Stacked Talent Stars");

local logging = ::Legends.Mod.ModSettings.addPage("Logging");
foreach(f in ::Const.LegendMod.Debug.FlagDefs)
{
	local b = logging.addElement(::MSU.Class.BooleanSetting(f.ID, f.Value, f.Name, f.Description)); // Set the default MSU Debug logging flags based on configuration in ::Const.LegendMod.Debug.FlagDefs
	b.Data.FlagID <- f.ID;
	b.addBeforeChangeCallback(function(_value)
		{
			::Legends.Mod.Debug.setFlag(this.Data.FlagID, _value);
		}
	);
}
logging.addElement(::MSU.Class.BooleanSetting("LogOutfits", false, "Log Outfits", "An option for fashion submissions which will log the entire outfit someone is wearing when you hover it, used to add custom outfits in Legends."));
