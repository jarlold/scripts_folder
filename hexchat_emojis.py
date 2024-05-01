# This is a hexchat script, its meant to be loaded in ~/.config/hexchat/addons
# it is not meant to be called from the terminal and would serve little purpose
# if you did.

__module_name__ = "Vomit"
__module_version__ = "1.1"
__module_description__ = "Add vomit emoji command and other emojis too"

import hexchat
import emoji

wrong = lambda : print("You used my command wrong!")

def search_emoji(word, word_eol, userdata):
    if len(word) <= 1:
        wrong()
        return hexchat.EAT_ALL

    found_one = False
    search_term = word[1]
    for e in emoji.EMOJI_DATA:
        if search_term in emoji.EMOJI_DATA[e]["en"]:
            print(e, "is called", emoji.EMOJI_DATA[e]["en"])
            found_one = True

    if not found_one:
        print("Couldn't find any emoji called that")

    return hexchat.EAT_ALL


def vomit(word, word_eol, userdata):
    # Get the amount of vomits to vomit
    if len(word) > 1:
        try:
            amount = int(word[1])
        except ValueError:
            wrong()
            return hexchat.EAT_ALL
    else:
        amount = 1

    # Make sure its somewhat reasonable
    if amount < 1 or amount > 256:
        wrong()
        return hexchat.EAT_ALL

    # Send them in chat
    hexchat.command("MSG {} {}".format(
        hexchat.get_info("channel"), amount*"🤮"))

    return hexchat.EAT_ALL


def any_emoji(word, word_eol, userdata):
    if len(word) < 2:
        wrong()
        return hexchat.EAT_ALL

    # Get the amount of emojis to vomit
    if len(word) > 2:
        try:
            amount = int(word[2])
        except ValueError:
            wrong()
            return hexchat.EAT_ALL
    else:
        amount = 1

    # Make sure its somewhat reasonable
    if amount < 1 or amount > 256:
        wrong()
        return hexchat.EAT_ALL

    # If the user forgot the colons (:) on either side
    # of the emoji name, we'll forgive them.
    if word[1].count(":") != 2:
        word[1] = ":" + word[1].strip(":")+ ":"

    # Send them in chat
    selected_emoji = emoji.emojize(word[1])
    if selected_emoji == word[1]:
        print("No such emoji")
    else:
        hexchat.command("MSG {} {}".format(
            hexchat.get_info("channel"),
            amount*selected_emoji)
        )
    return hexchat.EAT_ALL


def emoji_help(word, word_eol, userdata):
    print("Vomit.py Emoji Script:")
    print("/vomit [amount] \t use my favorite emoji [amount] times")
    print("/emoji [emoji_name] [amount] \t use [emoji_name] [amount] times.")
    print("/search_emoji [search_term] \t search an emoji name")
    print("Made with ❤️ by Jarlold")
    return hexchat.EAT_ALL


hexchat.hook_command("vomit", vomit)
hexchat.hook_command("emoji", any_emoji)
hexchat.hook_command("search_emoji", search_emoji)
hexchat.hook_command("emoji_help", emoji_help)

