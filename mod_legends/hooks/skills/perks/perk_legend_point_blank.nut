::mods_hookExactClass("skills/perks/perk_legend_point_blank", function(o) {
	// Author: WNTR Jimmy
	// Date: 1/18/23
	// nessesaries to register
	//change the perk to have a status effect
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	o.onGetHitFactors <- function(_skill, _targetTile, _tooltip){

		// get the bro's ranged def
		local rdef = this.getContainer().getActor().getCurrentProperties().getRangedDefense();

		// check if the skill they are using to attack is ranged
		if(_skill.isRanged()){

			// find how far away the target is from your brother
			local CharDistFromTarget = _targetTile.getDistanceTo(this.getContainer().getActor().getTile());

			// positive bonus because they are within two tiles away
			if( CharDistFromTarget <= 2){
				_tooltip.push({
					id = 1,
					type = "text",
        			icon = "ui/tooltips/positive.png",
       				text = rdef + "% more damage \n" + "  " +  this.getName()
     			 });
			}
			//negative bonus because they are further that 3 tiles away
			else if (CharDistFromTarget >= 4){
				_tooltip.push({
					id = 1,
					type = "text",
        			icon = "ui/tooltips/negative.png",
       				text = rdef  + "% less damage \n" + "  " + this.getName()
     			 });
			}

		}
	}
});
