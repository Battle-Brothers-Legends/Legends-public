::mods_hookExactClass("skills/traits/mad_trait", function(o)
{
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "This character has gazed into the abyss, and the abyss has gazed right back at them, turning them quite mad. This character often rambles unintelligibly, and their cryptic mind has become inaccessible both to peers and to the enemy."
	}

	o.getTooltip = function () {
		return [{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Triggers a morale check to shift morale randomly at the start of turn with a random difficulty of [color=%negative%]-15[/color] to [color=%positive%]15[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Can only receive a positive morale check at [color=%status%]Wavering[/color] or [color=%status%]Fleeing[/color]"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Can only receive a negative morale check at [color=%status%]Confident[/color]"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Immune against fear and mind control abilities"
		}];
	}

	o.onTurnStart <- function () {
		local actor = this.getContainer().getActor();
		local morale = actor.getMoraleState();

		local rand = this.Math.rand(1, 2) == 1 ? -1 : 1;
		if (morale == this.Const.MoraleState.Fleeing || morale == this.Const.MoraleState.Breaking) {
			a.checkMorale(1, this.Math.rand(-15, 15), this.Const.MoraleCheckType.Default);
		}
		else if (morale == this.Const.MoraleState.Confident) {
			a.checkMorale(-1, this.Math.rand(-15, 15), this.Const.MoraleCheckType.Default);
		}
		else {
			a.checkMorale(rand, this.Math.rand(-15, 15), this.Const.MoraleCheckType.Default);
		}
		local newMorale = actor.getMoraleState();
		if (morale != this.Const.MoraleState.Fleeing && morale != newMorale) { // it'll say he rallied so no point spamming the log
			if (newMorale - morale > 0) {
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " experienced a wild mood swing for the better");
			}
			else {
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " experienced a wild mood swing for the worse");
			}
		}
	}
});
