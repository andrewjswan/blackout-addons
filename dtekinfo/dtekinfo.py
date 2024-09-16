"""DTEKInfo Parser."""

import asyncio
import datetime
import json
import logging
import os
import re
import sys
from pathlib import Path

import html2texttg
import httpx
from telebot.async_telebot import AsyncTeleBot

LOGGER = logging.getLogger(__name__)

config = {
    "token": "",
    "url": "",
    "chat_id": "",
    "text_pattern": "",
    "night_start": 23,
    "night_end": 8,
}

# A temporary file for storing the last message ID
last_message_file = "/share/dtekinfo/last_message.json"


def load_last_message() -> str:
    """Load last message ID."""
    if Path(last_message_file).exists():
        with Path(last_message_file).open("r") as f:
            return json.load(f)
    return {"message_id": None}


def save_last_message(message_id: str) -> None:
    """Save last message ID."""
    folder = Path(last_message_file).parent.resolve()
    if folder and not Path.exists(folder):
        Path(folder).mkdir(parents=True)
    with Path(last_message_file).open("w") as f:
        json.dump({"message_id": message_id}, f)


def extract_relevant_lines(message_text: str) -> list[str]:
    """Extract relevant lines from message."""
    text_pattern = re.compile(config["text_pattern"], re.IGNORECASE)
    lines = message_text.split("\n")
    relevant_lines = []
    h = html2texttg.HTML2Text()

    for line in lines:
        cleaned_line = h.handle(line.strip())
        if text_pattern.search(cleaned_line):
            relevant_lines.append(f"{cleaned_line}")

    return relevant_lines


def is_day() -> bool:
    """Day or Night."""
    return (
        config["night_end"]
        <= (datetime.datetime.now(tz=datetime.timezone.utc)).astimezone().hour
        <= config["night_start"]
    )


async def getdata(url: str) -> str:
    """Get JSON data for URL."""
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()


async def senddata(text: str) -> None:
    """Send data for URL."""
    bot = AsyncTeleBot(config["token"])
    await bot.send_message(
        config["chat_id"],
        text,
        parse_mode="Markdown",
        disable_notification=not is_day(),
    )


async def check_for_new_messages() -> None:
    """Check and Send new messages."""
    try:
        json_data = await getdata(config["url"])
        last_message = load_last_message()

        for message in json_data["items"]:
            if last_message and message["id"] == last_message["message_id"]:
                LOGGER.debug("The message with ID %s has already been processed.", message["id"])
                break

            LOGGER.debug("Processing messages with ID %s.", message["id"])
            LOGGER.debug("Message: %s", message["title"])
            LOGGER.debug("Message: %s", message["content_html"])
            relevant_lines = extract_relevant_lines(message["title"])
            if relevant_lines:
                for line in relevant_lines:
                    LOGGER.debug("Sending a message: %s", line)
                    await senddata(line)
                    save_last_message(message["id"])
            else:
                LOGGER.debug("No matching lines found.")
    except Exception as e:
        LOGGER.exception("Error:", exc_info=e)
        raise


def load_config() -> bool:
    """Load parser configuration."""
    # Logger settings
    logging.basicConfig(format="%(asctime)s %(levelname)s %(message)s")
    LOGGER.setLevel(logging.DEBUG)
    # Set logger level
    log_level = os.getenv("LOG_LEVEL")  # Log level for Logger
    if log_level:
        level = logging.getLevelName(log_level)
        LOGGER.setLevel(level)
    # Get parser settings from OS Environment
    bot_token = os.getenv("TOKEN")  # Telegram Bot token
    chat_id = int(os.getenv("CHAT_ID"))  # Destination chat ID
    url = os.getenv("URL")  # RSSHub URL (json)
    night_time = os.getenv("NIGHT_TIME")  # Nighttime (Hour:Hour)

    # Regex patterns
    text_pattern_str = os.getenv("TEXT_PATTERN")  # Group search regex pattern

    # Check config
    if not bot_token:
        LOGGER.error("Bot token not defined.")
        return False
    if not chat_id:
        LOGGER.error("Chat ID not defined.")
        return False
    if not url:
        LOGGER.error("URL not defined.")
        return False
    if not text_pattern_str:
        LOGGER.error("Text pattern not defined.")
        return False
    config["token"] = bot_token
    config["chat_id"] = chat_id
    config["url"] = url
    config["text_pattern"] = text_pattern_str
    if night_time:
        night = night_time.split(":")
        if len(night) == 2:
            if night[0] and night[1] and (0 <= int(night[0]) <= 24) and (0 <= int(night[1]) <= 24):
                config["night_start"] = int(night[0]])
                config["night_end"] = int(night[1]])

    return True


async def main() -> None:
    """Start the main processing cycle."""
    if not load_config():
        LOGGER.error("Not all configuration parameters are defined.")
        sys.exit(1)
    LOGGER.info("DTEKInfo: started...")
    while True:
        await check_for_new_messages()
        await asyncio.sleep(60)
    LOGGER.info("DTEKInfo: stopped.")


if __name__ == "__main__":
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    loop.run_until_complete(main())
