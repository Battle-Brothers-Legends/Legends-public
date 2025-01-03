::mods_hookExactClass("events/events/dlc8/anatomist_vs_ailing_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "D") {
				s.start = function (_event) {
					_event.m.Ailing.getSkills().removeByID("trait.ailing");
					this.List.push({
						id = 10,
						icon = "ui/traits/trait_icon_59.png",
						text = _event.m.Ailing.getName() + " is no longer Ailing"
					});
					local new_traits = [
						"scripts/skills/traits/legend_aggressive_trait",
						"scripts/skills/traits/bloodthirsty_trait",
						"scripts/skills/traits/brute_trait",
						"scripts/skills/traits/cocky_trait",
						"scripts/skills/traits/deathwish_trait",
						"scripts/skills/traits/dumb_trait",
						"scripts/skills/traits/gluttonous_trait",
						"scripts/skills/traits/impatient_trait",
						"scripts/skills/traits/irrational_trait",
						"scripts/skills/traits/paranoid_trait",
						"scripts/skills/traits/spartan_trait",
						"scripts/skills/traits/superstitious_trait"
					];
					local num_new_traits = 2;

					while (num_new_traits > 0 && new_traits.len() > 0)
					{
						local trait = this.new(new_traits.remove(this.Math.rand(0, new_traits.len() - 1)));

						if (!_event.m.Ailing.getSkills().hasSkill(trait.getID()))
						{
							_event.m.Ailing.getSkills().add(trait);
							this.List.push({
								id = 10,
								icon = trait.getIcon(),
								text = _event.m.Ailing.getName() + " gains " + trait.getName()
							});
							num_new_traits = num_new_traits - 1;
						}
					}

					this.Characters.push(_event.m.Anatomist.getImagePath());
					this.Characters.push(_event.m.Ailing.getImagePath());
				}
			}
		}
	}
})
