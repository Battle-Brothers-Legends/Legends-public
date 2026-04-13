mod_legends.Hooks.XBBCODE_process = XBBCODE.process;

XBBCODE.process = function(config) {
    var ret = mod_legends.Hooks.XBBCODE_process(config);

	// this one adds a [leg_img] tag that allows dynamic width and height manipulation of img in texts
    ret.html = ret.html.replace(
        /(?:\[|&#91;)leg_img(?:\]|&#93;)\(\s*([\s\S]+?)\s*\)(?:\[|&#91;)\/leg_img(?:\]|&#93;)/gi,
        function(_match, content) {
            var parts = content.split(',');
            for (var i = 0; i < parts.length; i++) {
                parts[i] = parts[i].replace(/^\s+|\s+$/g, ''); // trim
            }

            var path = parts.shift() || "";
            if (!path) return "";

            var width = "";
            var height = "";

            for (var j = 0; j < parts.length; j++) {
                var param = parts[j].split('=');
                if (param.length === 2) {
                    var key = param[0].replace(/^\s+|\s+$/g, '').toLowerCase();
                    var value = param[1].replace(/^\s+|\s+$/g, '');
                    if (key === 'width') width = ' width="' + value + '"';
                    if (key === 'height') height = ' height="' + value + '"';
                }
            }

            var safePath = path.replace(/[<>"']/g, "");
            return '<img src="coui://' + safePath + '"' + width + height + ' style="vertical-align: -3px;"/>';
        }
    );

    return ret;
};
