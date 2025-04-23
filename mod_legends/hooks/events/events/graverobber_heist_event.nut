::mods_hookExactClass("events/events/graverobber_heist_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "D") {
				local start = s.start;
				s.start <- function ( _event )
				{
					this.World.Assets.addMoralReputation(2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases"
					});
					start(_event);
				}
			}
			if (s.ID == "E") {
				local start = s.start;
				s.start <- function ( _event )
				{
					this.World.Assets.addMoralReputation(-2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases"
					});
					start(_event);
				}
			}
			if (s.ID == "H") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Graverobber.getImagePath());
					local item;
					local r = this.Math.rand(1, 3);

					if (r == 1)
						item = this.new("scripts/items/weapons/arming_sword");
					else if (r == 2)
						item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.decayed_full_helm]]);
					else if (r == 3)
						item = this.Const.World.Common.pickArmor([
							[1, ::Legends.Armor.Standard.decayed_coat_of_plates],
						]);

					item.setCondition(item.getRepair() / 2);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					_event.m.Graverobber.improveMood(1.0, "Found treasure while robbing a grave");
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
						text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
					});
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (!this.World.Assets.getStash().hasEmptySlot())
			return;
		onUpdateScore();
	}
})
