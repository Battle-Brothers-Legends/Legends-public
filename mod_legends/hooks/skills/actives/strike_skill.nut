::mods_hookExactClass("skills/actives/strike_skill", function(o) {
	o.m.IsGlaiveStrike <- false;

	local setItem = o.setItem;
	o.setItem <- function(_item) {
		setItem(_item);
		if (this.m.IsGlaiveStrike) {
			this.m.Description = "A thrusting or sweeping strike that can cover the distance of 2 tiles and can be used from behind the frontline, outside the range of most other melee weapons.";
			this.m.Icon = "skills/glaive_slash.png";
			this.m.IconDisabled = "skills/glaive_slash_bw.png";
			this.m.InjuriesOnBody = this.Const.Injury.CuttingAndPiercingBody;
			this.m.InjuriesOnHead = this.Const.Injury.CuttingAndPiercingHead;
			this.m.ChanceDecapitate = 0;
		}
	}
}
