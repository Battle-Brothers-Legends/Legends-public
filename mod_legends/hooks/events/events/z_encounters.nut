foreach(event in [
	"apprentice_learns_event",
	"bad_curse_event",
	"ball_on_roof_event",
	"beggar_begs_event",
	"cat_on_tree_event",
	"creepy_guy_event",
	"enter_friendly_town_event",
	"enter_unfriendly_town_event",
	"eunuch_ladies_event",
	"graverobber_heist_event",
	"inadvertently_save_merchant_event",
	"jousting_tournament_event",
	"juggler_entertains_townsfolk_event",
	"lend_men_to_build_event",
	"master_no_use_apprentice_event",
	"melon_thief_event",
	"surefooted_saves_damsel_event",
	"traveling_troupe_event",
	"troublemakers_bully_peasants_event",
	"wildman_causes_havoc_event",
	"witch_being_burned_event",
	"dlc2/nightowl_catches_thief_event",
	"dlc4/wild_dog_sounds_event",
	"dlc8/anatomist_creeps_out_locals_event",
	"dlc8/captured_oathbringer_event",
	"dlc8/lindwurm_slayer_event",
	"dlc8/oathtakers_skull_cracked_event",
	"dlc8/strange_scribe_event",
	"dlc8/volunteers_event"
]) {
	::mods_hookExactClass("events/events/" + event, function(o) {
		o.m.isValidForEncounter <- false;

		local onUpdateScore = o.onUpdateScore;
		o.onUpdateScore = function() {
			onUpdateScore();
			this.m.isValidForEncounter = this.m.Score > 0 && this.Time.getVirtualTimeF() > this.m.CooldownUntil;
			this.m.Score = 0; // this disables event from happening normally
		}
	});
}

// these events were moved to encounters entirely, just disable them
foreach(event in [
	"dlc6/arena_tournament_event",
]) {
	::mods_hookExactClass("events/events/" + event, function(o) {
		o.onUpdateScore = function() {
			this.m.Score = 0; // this disables event from happening normally
		}
	});
}
