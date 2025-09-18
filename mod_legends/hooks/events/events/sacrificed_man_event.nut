::mods_hookExactClass("events/events/sacrificed_man_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Cultist") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Cultist.getImagePath());
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
					{
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"cultist_background"
						]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					}
					if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
					{
						_event.m.Dude.getBaseProperties().MeleeSkill += 10;
						_event.m.Dude.setStartValuesEx([
							"cultist_background"
						]);
					}
					else
					{
						_event.m.Dude.setStartValuesEx([
							"cultist_background"
						]);
					}

					_event.m.Dude.setTitle("the Sacrifice");
					_event.m.Dude.getBackground().m.RawDescription = "You found this man as a sacrifice, but he arose from his fate to be a servant of Davkul. He asked to fight for you, and you, for some reason, actually agreed.";
					_event.m.Dude.getBackground().buildDescription(true);

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();

					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
			return;

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns ) {
			local d = playerTile.getDistanceTo(t.getTile());

			if (d >= 6 && d <= 12) {
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_cultist = [];
		local candidates_other = [];

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Player))
				continue;
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(this.Const.BackgroundType.Cultist))
				candidates_cultist.push(bro);
			else if (bro.getBackground().getID() != "background.slave")
				candidates_other.push(bro);
		}

		if (candidates_other.len() == 0)
			return;

		if (candidates_cultist.len() != 0)
			this.m.Cultist = candidates_cultist[this.Math.rand(0, candidates_cultist.len() - 1)];

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = 3;
	}
})
