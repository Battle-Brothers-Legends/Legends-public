::mods_hookExactClass("events/events/dlc8/anatomist_vs_ailing_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "D") {
				s.start = function (_event) {
					::Legends.Traits.remove(_event.m.Ailing, ::Legends.Trait.Ailing);
					this.List.push({
						id = 10,
						icon = "ui/traits/trait_icon_59.png",
						text = _event.m.Ailing.getName() + " is no longer Ailing"
					});
					local new_traits = [
						::Legends.Trait.LegendAggressive,
						::Legends.Trait.Bloodthirsty,
						::Legends.Trait.Brute,
						::Legends.Trait.Cocky,
						::Legends.Trait.Deathwish,
						::Legends.Trait.Dumb,
						::Legends.Trait.Gluttonous,
						::Legends.Trait.Impatient,
						::Legends.Trait.Irrational,
						::Legends.Trait.Paranoid,
						::Legends.Trait.Spartan,
						::Legends.Trait.Superstitious
					];
					local num_new_traits = 2;

					while (num_new_traits > 0 && new_traits.len() > 0)
					{
						local newTrait = new_traits.remove(this.Math.rand(0, new_traits.len() - 1));

						if (!::Legends.Traits.has(_event.m.Ailing, newTrait))
						{
							::Legends.Traits.grant(_event.m.Ailing, newTrait, function(_trait) {
								this.List.push({
									id = 10,
									icon = _trait.getIcon(),
									text = _event.m.Ailing.getName() + " gains " + _trait.getName()
								});
							}.bindenv(this));
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
