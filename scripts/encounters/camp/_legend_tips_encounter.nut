this._legend_tips_encounter <- this.inherit("scripts/encounters/encounter", {
    m = {

    },
    function create() {
	    this.encounter.create();
		this.m.Icon = "ui/encounters/encounter_02.png";
		this.m.Type = "encounter.legend_tips_encounter";
        this.m.Name = "Tips";
    }

    function createScreens() {
        local text = "Here are some tips for you:";
        foreach(i, tip in ::Const.TipOfTheDay) {
            text = text + "\n- " + tip;
        }
        this.m.Screens.extend([{
            ID = "Task",
            Title = "Tips",
            Text = text,
            Image = "",
            List = [],
            Options = [{
                Text = "Nice",
                getResult = @(_event) 0
            }],
            function start(_event) {}
        }]);
    }

    function isValid(_camp) {
        return false;
    }
})
