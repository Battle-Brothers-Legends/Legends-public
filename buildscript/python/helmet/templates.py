import os


class Templates:
    @staticmethod
    def get_sprites(name):
        dir = os.path.join("..", "entity", "legend_helmets", "layers")
        sprite = os.path.join(dir, name + ".png")
        damaged = os.path.join(dir, name + "_damaged.png")
        dead = os.path.join(dir, name + "_dead.png")
        return sprite, damaged, dead, dir

    @staticmethod
    def get_cropped_sprites(name):
        dir = os.path.join("..", "entity", "legend_helmets", "cropped")
        sprite = os.path.join(dir, name + ".png")
        damaged = os.path.join(dir, name + "_damaged.png")
        dead = os.path.join(dir, name + "_dead.png")
        return sprite, damaged, dead, dir

    @staticmethod
    def calculate_cardinals(cardinals, crop_area):
        left, right, top, bottom = crop_area
        return 'left="{0}" right="{1}" top="{2}" bottom="{3}"'.format(
            cardinals[0] + left, cardinals[1] - right,
            cardinals[2] + bottom, cardinals[3] - top,
        )

    @staticmethod
    def load_template(file_name):
        try:
            with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), file_name), 'r') as file:
                template_content = file.read()
            return template_content
        except FileNotFoundError:
            raise FileNotFoundError(f"Error: Template file '{file_name}' not found.")

    Cardinals = [
        [-67, 68, -40, 108],
        [-67, 68, -40, 108],
        [-57, 59, -53, 55]
    ]

    BLayer = [
        '<sprite id="${name}" offsetY="35" f="64F0" ic="FF4E5053" img="${name_path}" ${name_cardinals} />\n',
        '<sprite id="${name}_damaged" offsetY="35" f="64F0" ic="FF4B4D51" img="${damaged_path}" ${damaged_cardinals} />\n',
        '<sprite id="${name}_dead" offsetX="6" offsetY="10" f="64F0" ic="FF222933" img="${dead_path}" ${dead_cardinals} />\n'
    ]

    BaseLayer = load_template("templates/BaseLayer.template")
    Layer = load_template("templates/Layer.template")
    NamedLayer = load_template("templates/NamedLayer.template")

