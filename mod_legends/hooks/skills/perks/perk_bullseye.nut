::mods_hookExactClass("skills/perks/perk_bullseye", function(o) {
	o.onAdded <- function()
	{
		if (!this.getContainer().hasSkill("actives.legend_mark_target") && this.getContainer().getActor().isPlayerControlled())
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_mark_target_skill"));
		}
	}

	o.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.legend_mark_target");
	}
});