this.legion_origin_training_event <- this.inherit("scripts/events/events/legends/scenario/legion/legion_event", {
	m = {},

	function create() {
		this.m.ID = "event.legion_origin_training";
		this.m.Title = "During camp...";
		this.m.Cooldown = 55.0 * ::World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_45.png[/img]As time passes, the conflict takes shape — what seemed to be a scouring of primitive tribes in both north and south has turned into a grinding conflict. This will be no quick war.\n\n Your conscience turns to your cohort — which has now grown to a reasonable number. Combat has shaped all of you, while you have been training in brief moments of respite, the training you have done is a shadow of what was done all those lifetimes ago. With this thought, you prepare the legion for intensive training.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We'll be better prepared from now on.",
					getResult = @(_event)0
				}
			],

			function start(_event) {
				foreach (bro in ::World.getPlayerRoster().getAll()) {
					if (::Math.rand(1, 100) <= 50) {
						this.List.push(::Legends.EventList.changeBroExperience(bro, ::Math.rand(150, 1200)));
					}
				}
			}
		});
	}

	function onUpdateScore() {
		if (!this.validateLegionEvent()) {
			return;
		}

		if (::World.getPlayerRoster().getAll().len() < 14) { //must have at least 14 fighters or more
			return;
		}

		this.m.Score = 5;
	}
});
