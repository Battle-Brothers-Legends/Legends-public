::mods_hookExactClass("crafting/blueprints/lindwurm_scales_upgrade_blueprint", function(o)
{
	o.isValid <- function ()
	{
		return false; // Deactives this vanilla recipe as it was replaced by a legends recipe
	}
});
