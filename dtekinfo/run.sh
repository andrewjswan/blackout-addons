#!/usr/bin/with-contenv bashio

# ==============================================================================
# Home Assistant DTEKInfo Add-on
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

CONFIG_PATH=/data/options.json

export LOG_LEVEL=$(bashio::config 'log_level')
export TOKEN=$(bashio::config 'token')
export CHAT_ID=$(bashio::config 'chat_id')
export URL=$(bashio::config 'url')
export TIME_PATTERN=$(bashio::config 'time_pattern')
export TEXT_PATTERN=$(bashio::config 'text_pattern')

bashio::log.info 'DTEKInfo Starting...'
bashio::log.info 'Configuration:'
bashio::log.blue "  Chat ID: $(bashio::config 'chat_id')"
bashio::log.blue "  RSSHub URL: $(bashio::config 'url')"
bashio::log.info 'DTEKInfo Start'
bashio::log.info

# ==============================================================================

bashio::color.blue
python /dtekinfo.py
bashio::color.reset

# ==============================================================================

bashio::log.info
bashio::log.info 'DTEKInfo Stop'
bashio::exit.ok
