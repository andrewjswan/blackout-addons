<div align="center">
<h1>DTEKInfo Add-on</h1>
</div>

## General

[![ha addon_badge](https://img.shields.io/badge/HA-Addon-blue.svg)](https://developers.home-assistant.io/docs/add-ons)
[![DTEKInfo](https://img.shields.io/badge/DTEK-Info-blue.svg)](https://github.com/andrewjswan/blackout-addons/dtekinfo/)
[![GitHub](https://img.shields.io/github/license/andrewjswan/blackout-addons?color=blue)](https://github.com/andrewjswan/blackout-addons/blob/master/LICENSE)
[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

DTEKInfo checks the last message on the public channel that warns about blackouts, filters the message and sends it to your private channel or group.

## Architecture

![Supports amd64 Architecture][amd64-shield] ![Supports aarch64 Architecture][aarch64-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports armhf Architecture][armhf-shield] ![Supports i386 Architecture][i386-shield]

## Confururation settings

```
toket: 9999999999:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA # Telegram bot Token
url: 'https://rsshub.app/telegram/channel/dtek_svitlo_official?limit=1&?format=json' # RSSHub URL for channel that warns about blackouts
chat_id: -0000000000000 # Target Chat ID
text_pattern: '1\s*груп[ау]' # Regex Text pattern (DTEK group)
log_level: DEBUG # Optional, values: DEBUG|INFO|WARNING|ERROR|CRITICAL
```

> [!TIP]
> DTEK Blackout schedule [calendars](https://github.com/andrewjswan/dtek-blackout-schedule-calendars)

[amd64-shield]: https://img.shields.io/badge/amd64-yes-blue.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-blue.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-blue.svg
[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg
