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

    BLayer = [
        '<sprite id="${name}" offsetY="35" f="64F0" ic="FF4E5053" width="184" height="222" img="${name_path}" left="-67" right="68" top="-40" bottom="108" />\n',
        '<sprite id="${name}_damaged" offsetY="35" f="64F0" ic="FF4B4D51" width="184" height="222" img="${damaged_path}" left="-67" right="68" top="-40" bottom="108" />\n',
        '<sprite id="${name}_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" width="131" height="125" img="${dead_path}" left="-57" right="59" top="-53" bottom="55" />\n'
    ]

    BaseLayer = load_template("templates/BaseLayer.template")
    Layer = load_template("templates/Layer.template")
    NamedLayer = load_template("templates/NamedLayer.template")

