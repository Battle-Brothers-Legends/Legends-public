::mods_hookExactClass("contracts/contracts/hunting_lindwurms_contract", function(o) 
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DescriptionTemplates = [
			"Giant, serpentine monsters are ravaging the countryside, devouring cattle and men. None appear able to stop them.",
			"A creature of nightmare and legend, the Lindwurm is a massive serpent with razor-sharp fangs and venom that burns like fire.",
			"Monstrous serpents that usually prowl the depths of the wilderness, the Lindwurm is a primal force of nature that brooks no challengers to its dominion.",
			"A monstrous serpent with a hunger that knows no bounds is terrorising the area. None dare face it.",
			"Colossal serpents with scales as hard as iron, few would ever dare to hunt such a creature.",
			"Hunt and eliminate the Lindwurm that has become a blight upon the region. Only the boldest need apply.",
		];
	}

	local createScreens = o.createScreens;
	o.createScreens = function()
	{
		createScreens();
		foreach (s in this.m.Screens)
		{
			if (s.ID == "Task")
			{
				s.Title = this.m.Name;
			}
		}
	}
});
