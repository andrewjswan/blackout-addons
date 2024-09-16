#!/usr/bin/with-contenv bashio

# ==============================================================================
# Home Assistant SvitloBot Monitor Add-on
# Displays a simple add-on banner on startup
# ==============================================================================

if bashio::supervisor.ping; then
  bashio::log.blue \
    '-----------------------------------------------------------'
  bashio::log.blue " Add-on: $(bashio::addon.name)"
  bashio::log.blue " $(bashio::addon.description)"
  bashio::log.blue \
    '-----------------------------------------------------------'
  bashio::log.blue " Add-on version: $(bashio::addon.version)"
  if bashio::var.true "$(bashio::addon.update_available)"; then
    bashio::log.magenta ' There is an update available for this add-on!'
    bashio::log.magenta \
        " Latest add-on version: $(bashio::addon.version_latest)"
    bashio::log.magenta ' Please consider upgrading as soon as possible.'
  else
    bashio::log.green ' You are running the latest version of this add-on.'
  fi

  bashio::log.blue " System: $(bashio::info.operating_system)" \
    " ($(bashio::info.arch) / $(bashio::info.machine))"
  bashio::log.blue " Home Assistant Core: $(bashio::info.homeassistant)"
  bashio::log.blue " Home Assistant Supervisor: $(bashio::info.supervisor)"

  bashio::log.blue \
    '-----------------------------------------------------------'
  bashio::log.blue \
    ' Please, share the above information when looking for help'
  bashio::log.blue \
    ' or support in, e.g., GitHub, forums or the Discord chat.'
  bashio::log.blue \
    '-----------------------------------------------------------'
fi

# ==============================================================================

bashio::log.info 'SvitloBot Monitor Starting...'

bashio::log.info 'Prepare config...'

CONFIG_PATH=/data/options.json

declare -a options

export TELEGRAM_BOT_AUTH_TOKEN=$(bashio::config 'token')
export TELEGRAM_CHAT_ID=$(bashio::config 'chat_id')
export TELEGRAM_TOPIC_ID=0

bashio::log.info 'SvitloBot Monitor Starting...'
bashio::log.info 'Configuration:'
bashio::log.blue "  Group: $(bashio::config 'group')"
bashio::log.blue "  Chat ID: $(bashio::config 'chat_id')"
bashio::log.blue "  Step interval: $(bashio::config 'step_interval')"
bashio::log.blue "  Nighttime: $(bashio::config 'night_time')"
if bashio::config.true 'debug'; then
    bashio::log.info "  Setting debug mode"
    options+=(--debug)
fi
bashio::log.info 'SvitloBot Monitor Start'
bashio::log.info

# ==============================================================================

bashio::color.blue
cd /app
node src/index.js --language uk --group $(bashio::config 'group') --refresh-interval 5 --add-timestamp --time-zone "Europe/Kiev" --night_time $(bashio::config 'night_time') --step-interval-pair $(bashio::config 'step_interval') ${options[@]}
bashio::color.reset

# ==============================================================================

bashio::log.info 'SvitloBot Monitor Stop'
bashio::exit.ok
