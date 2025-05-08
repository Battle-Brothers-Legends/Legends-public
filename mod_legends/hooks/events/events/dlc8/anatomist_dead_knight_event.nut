::mods_hookExactClass("events/events/dlc8/anatomist_dead_knight_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- 	function ( _event ) {
					this.Characters.push(_event.m.Anatomist.getImagePath());

					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.decayed_coat_of_scales],
						[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk]
					]);

					item.setCondition(item.getConditionMax() / 2 - 1);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					item = this.new("scripts/items/weapons/arming_sword");
					item.setCondition(item.getConditionMax() / 2 - 1);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					_event.m.Anatomist.improveMood(0.75, "Got to examine the corpse of a heroic knight");

					if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
							text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
						});
					}
				}
			}
			if (s.ID == "C") {
				s.start <- function ( _event )
				{
					this.Characters.push(_event.m.Anatomist.getImagePath());
					this.Characters.push(_event.m.Noble.getImagePath());

					local armor_list = [
						this.Const.World.Common.pickArmor([[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk]]),
						this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.decayed_closed_flat_top_with_mail]])
					];

					local item = this.new(armor_list[this.Math.rand(0, armor_list.len() - 1)]);
					item.setCondition(item.getConditionMax() / 2 - 1);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					_event.m.Anatomist.worsenMood(1.0, "Was denied the opportunity to examine a promising corpse");

					if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
							text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
						});
					}

					_event.m.Noble.worsenMood(2.0, "Saw the decaying remains of an old friend");

					if (_event.m.Noble.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Noble.getMoodState()],
							text = _event.m.Noble.getName() + this.Const.MoodStateEvent[_event.m.Noble.getMoodState()]
						});
					}
				}
			}
			if (s.ID == "E") {
				s.start <- function ( _event )
				{
					this.Characters.push(_event.m.Anatomist.getImagePath());
					local armor_list = [
						this.Const.World.Common.pickArmor([[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk]]),
						this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Standard.decayed_closed_flat_top_with_mail]])
					];
					local item = this.new(armor_list[this.Math.rand(0, armor_list.len() - 1)]);
					item.setCondition(item.getConditionMax() / 2 - 1);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					_event.m.Anatomist.addXP(200, false);
					_event.m.Anatomist.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = _event.m.Anatomist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] Experience"
					});
				}
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Paladins)
			return;

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
			return;

		if (this.World.getTime().Days <= 25)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local noble_candidates = [];

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() == "background.anatomist")
				anatomist_candidates.push(bro);
			else if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.Noble))
				noble_candidates.push(bro);
		}

		if (noble_candidates.len() > 0)
			this.m.Noble = noble_candidates[this.Math.rand(0, noble_candidates.len() - 1)];

		if (anatomist_candidates.len() == 0)
			return;

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Score = 5 + anatomist_candidates.len();
	}
})
