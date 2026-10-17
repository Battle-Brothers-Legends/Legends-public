class DefsHelpers:
    MINOR_WORDS = {"of", "the", "and", "in", "on", "at", "to", "for", "a", "an", "with", "or", "by"}

    @staticmethod
    def tokenize_const(string: str) -> list[str]:
        if not string:
            return []

        words = []
        last_index = 0
        for i in range(1, len(string)):
            char = string[i]
            if char.isupper():
                words.append(string[last_index:i])
                last_index = i
        words.append(string[last_index:])
        return words

    @staticmethod
    def convert_to_snake_case(string: str) -> str:
        tokens = DefsHelpers.tokenize_const(string)
        return "_".join(token.lower() for token in tokens)

    @staticmethod
    def convert_to_display_name(string: str, strip: str = "Legend") -> str:
        if string.startswith(strip):
            string = string[len(strip):]

        words = DefsHelpers.tokenize_const(string)
        transformed_words = []

        for idx, word in enumerate(words):
            if idx != 0 and word.lower() in DefsHelpers.MINOR_WORDS:
                transformed_words.append(word.lower())
            else:
                transformed_words.append(word)
        return " ".join(transformed_words)