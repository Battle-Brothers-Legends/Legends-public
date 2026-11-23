::mods_hookBaseClass("ambitions/ambition", function (o) {
	o.buildText <- function (_text) {
		local brothers = this.World.getPlayerRoster().getAll();
		local brother1 = this.Math.rand(0, brothers.len() - 1);
		local brother2 = this.Math.rand(0, brothers.len() - 1);

		if (brothers.len() >= 2) {
			while (brother1 == brother2) {
				brother2 = this.Math.rand(0, brothers.len() - 1);
			}
		}

		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_START",
				"[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randombrother",
				brothers.len() < 2 ? "unknown" : brothers[brother1].getName()
			],
			[
				"randombrother2",
				brothers.len() < 2 ? "unknown" : brothers[brother2].getName()
			]
		];

		this.onPrepareVariables(vars);

		::Const.LegendMod.extendVarsWithPronouns(vars, brothers[brother1], "randombrother");
		::Const.LegendMod.extendVarsWithPronouns(vars, brothers[brother2], "randombrother2");

		local veteran = brothers[0];
		foreach (bro in brothers) {
			if (bro.getHireTime() < veteran.getHireTime()) {
				veteran = bro;
			}
		}
		::Const.LegendMod.extendVarsWithPronouns(vars, veteran, "veteranbrother");

		foreach (key, value in this.m) {
			if (::MSU.isKindOf(value, "actor")) {
				::Const.LegendMod.extendVarsWithPronouns(vars, value, key.tolower());
			}
		}
		return this.buildTextFromTemplate(_text, vars);
	}

	o.getSuccessText <- function () {
		return this.buildText(this.m.SuccessText);
	}
});
