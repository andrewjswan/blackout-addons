<div align="center">
<h1><b>SvitloBot</b> Monitor Add-on</h1>
</div>

## General

[![ha addon_badge](https://img.shields.io/badge/HA-Addon-blue.svg)](https://developers.home-assistant.io/docs/add-ons)
[![svitlobot_badge](https://img.shields.io/badge/Svitlo-Bot-orange.svg)](https://svitlobot.in.ua/)
[![svitlobot_monitor](https://img.shields.io/badge/SvitloBot-Monitor-blue.svg)](https://github.com/PetroVoronov/svitlobot-monitor)
[![GitHub package.json version](https://img.shields.io/github/package-json/v/PetroVoronov/svitlobot-monitor?label=upstream%40based)](https://github.com/PetroVoronov/svitlobot-monitor)
[![GitHub](https://img.shields.io/github/license/andrewjswan/blackout-addons?color=blue)](https://github.com/andrewjswan/blackout-addons/blob/master/LICENSE)
[![StandWithUkraine](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/badges/StandWithUkraine.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

**Svitlo**Bot Monitor check the data from Svtilobot API and send the electricity switching on or off tendency indication for the appropriate DTEK group to the appropriate telegram user/chat/group/forum. By using this application, you will be able to receive notifications about the start of power outages or restorations for your group before it happens to you.

## Architecture

![Supports amd64 Architecture][amd64-shield] ![Supports aarch64 Architecture][aarch64-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports armhf Architecture][armhf-shield] ![Supports i386 Architecture][i386-shield]

## Confururation settings

```
group: int
token: 9999999999:AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA # Telegram bot Token
chat_id: -0000000000000 # Target Chat ID
step_interval: 5:10 10:30 15:60 # Tendency by specifying a value step in percentage and a time interval in minutes
debug: false # Optional: Debug level of logging
```

> [!NOTE]
> Builded from [**Svitlo**Bot Monitor](https://github.com/PetroVoronov/svitlobot-monitor) by [Petro Voronov](https://github.com/PetroVoronov)
> 
> [![English Documentation](https://img.shields.io/static/v1?label=Documentation&message=English&color=blue)](https://github.com/PetroVoronov/svitlobot-monitor/blob/main/README.md)
[![Ukrainian Documentation](https://img.shields.io/static/v1?label=Documentation&message=Ukrainian&labelColor=1f5fb2&color=fad247)](https://github.com/PetroVoronov/svitlobot-monitor/blob/main/README-uk.md)


> [!TIP]
> ESPHome **Svitlo**Bot [configuration](https://github.com/andrewjswan/svitlobot) and [**SvitloBot - ESP Web Tools**](https://andrewjswan.github.io/svitlobot/)
> 
> DTEK Blackout schedule [calendars](https://github.com/andrewjswan/dtek-blackout-schedule-calendars)

[amd64-shield]: https://img.shields.io/badge/amd64-yes-blue.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-blue.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-blue.svg
[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg
