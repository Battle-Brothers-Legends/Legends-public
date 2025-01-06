import os


class Templates:
    @staticmethod
    def load_template(file_name):
        try:
            with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), file_name), 'r') as file:
                template_content = file.read()
            return template_content
        except FileNotFoundError:
            raise FileNotFoundError(f"Error: Template file '{file_path}' not found.")

    Layer = [
        '<sprite id="$name" offsetY="35" f="64FE" ic="$ic" width="104" height="142" img="$name_path" left="-44" right="50" top="-53" bottom="13" />\n',
        '<sprite id="$damaged" offsetY="35" f="64FE" ic="$ic" width="104" height="142" img="$damaged_path" left="-44" right="50" top="-53" bottom="13" />\n',
        '<sprite id="$dead" offsetX="6" offsetY="10" f="64FE" ic="$ic" width="131" height="125" img="$dead_path" left="-57" right="59" top="-53" bottom="55" />\n'
    ]

    LBase = [
        '<sprite id="$name" offsetY="35" f="64FE" ic="$ic" width="104" height="142" img="$name_path" left="-44" right="50" top="-53" bottom="13" />\n',
        '<sprite id="$damaged" offsetY="35" f="64FE" ic="$ic" width="104" height="142" img="$damaged_path" left="-44" right="50" top="-53" bottom="13" />\n',
        '<sprite id="$dead" offsetX="6" offsetY="10" f="64FE" ic="$ic" width="131" height="125" img="$dead_path" left="-57" right="59" top="-53" bottom="55" />\n',
        '<sprite id="$arrow" offsetX="6" offsetY="10" f="64FB" ic="$ic" width="131" height="114" img="$arrow_path" left="0" right="28" top="-8" bottom="30" />\n',
        '<sprite id="$javelin" offsetX="6" offsetY="10" f="64FB" ic="$ic" width="131" height="134" img="$javelin_path" left="-11" right="35" top="-5" bottom="67" />\n'
    ]


    BaseNut = load_template("templates/BaseNut.template")
    BaseNutInherit = load_template("templates/BaseNutInherit.template")
    UpgradeNut = load_template("templates/UpgradeNut.template")
    UpgradeNutInherit = load_template("templates/UpgradeNutInherit.template")
    NamedUpgradeNut = load_template("templates/NamedUpgradeNut.template")
    BaseNamedNut = load_template("templates/BaseNamedNut.template")
    CloakNut = load_template("templates/CloakNut.template")
    TabardNut = load_template("templates/TabardNut.template")
