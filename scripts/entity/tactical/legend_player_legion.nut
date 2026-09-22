this.legend_player_legion <- this.inherit("scripts/entity/tactical/player", {
	function onInit() {
		this.player.onInit();
		this.getFlags().add("undead");
		this.getFlags().add("skeleton");
		::Legends.Traits.grant(this, ::Legends.Trait.RacialSkeleton);
	}
});
