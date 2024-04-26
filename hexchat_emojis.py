__module_name__ = "Vomit"
__module_version__ = "1.0"
__module_description__ = "Add vomit emoji command and other emojis too"

import hexchat
import emoji

def vomit(word, word_eol, userdata):
    if word[0] == "vomit":
        # Get the amount of vomits to vomit
        if len(word) > 1:
            try:
                amount = int(word[1])
            except ValueError:
                print("You used my command wrong")
        else:
            amount = 1

        # Make sure its somewhat reasonable
        if amount < 1 or amount > 256:
            print("You used my command wrong!")
            return

        # Send them in chat
        hexchat.command("MSG {} {}".format(
            hexchat.get_info("channel"), amount*"🤮"))

def any_emoji(word, word_eol, userdata):
    if len(word) < 2:
        print("You used my command wrong")

    if word[0] == "emoji":
        # Get the amount of vomits to vomit
        if len(word) > 2:
            try:
                amount = int(word[2])
            except ValueError:
                print("You used my command wrong")
        else:
            amount = 1

        # Make sure its somewhat reasonable
        if amount < 1 or amount > 256:
            print("You used my command wrong!")
            return

        # Send them in chat
        selected_emoji = emoji.emojize(word[1])
        if selected_emoji == word[1]:
            print("No such emoji")
        else:
            hexchat.command("MSG {} {}".format(
                hexchat.get_info("channel"),
                amount*selected_emoji)
            )


hexchat.hook_command("vomit", vomit)
hexchat.hook_command("emoji", any_emoji)

