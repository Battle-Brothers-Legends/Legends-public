this.profession_legend_friends_in_right_places <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendFriendsInRightPlaces);
	}
});
