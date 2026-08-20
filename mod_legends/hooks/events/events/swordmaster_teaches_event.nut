::mods_hookExactClass("events/events/swordmaster_teaches_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function(_screen) {
			_screen.Text = "[img]gfx/ui/events/event_17.png[/img]An old mercenary\'s voice is heard quietly issuing orders.%SPEECH_ON%The foot leads, the body follows. Again.%SPEECH_OFF%You find %swordmaster% the swordmaster and %swordstudent% practicing in a field. The elder\'s head shakes at the most recent display of swordsmanship.%SPEECH_ON%The foot leads, the body follows. Again!%SPEECH_OFF%The student practices what is taught. Nodding, the swordmaster barks another order.%SPEECH_ON%Now do it in reverse. The foot retreats, the body follows. Do not retreat with your mind. Let your feet do the thinking for you. Instinct is survival! Thinking is death! Move as though the world demanded it. If a wind blows are you faster than the leaves which hear its call? I see. Good... you are learning. Now... again.%SPEECH_OFF%";
		});
	}

	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3) {
			return;
		}

		local teacher_candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 4 && ::Legends.Backgrounds.has(bro, ::Legends.Background.Swordmaster)) {
				teacher_candidates.push(bro);
			}
		}

		if (teacher_candidates.len() < 1) {
			return;
		}

		local student_candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() >= 3 && !bro.getFlags().has("taughtBySwordmaster") && ::Legends.Backgrounds.hasAny(bro,
				::Legends.Background.Squire,
				::Legends.Background.Bastard,
				::Legends.Background.DisownedNoble,
				::Legends.Background.AdventurousNoble,
				::Legends.Background.LegendAdventurousNobleRanged,
				::Legends.Background.LegendDisownedNobleRanged,
				::Legends.Background.RegentInAbsentia)) {
				student_candidates.push(bro);
			}
		}

		if (student_candidates.len() < 1) {
			return;
		}

		this.m.Student = student_candidates[this.Math.rand(0, student_candidates.len() - 1)];
		this.m.Teacher = teacher_candidates[this.Math.rand(0, teacher_candidates.len() - 1)];
		this.m.Score = teacher_candidates.len() * 4;
	}
})
