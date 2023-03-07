#!/usr/bin/env python

import os
import json
import requests

WEATHER_CODES = {
    '113': '☀️',
    '116': '⛅️',
    '119': '☁️',
    '122': '☁️',
    '143': '🌫',
    '176': '🌦',
    '179': '🌧',
    '182': '🌧',
    '185': '🌧',
    '200': '⛈',
    '227': '🌨',
    '230': '❄️',
    '248': '🌫',
    '260': '🌫',
    '263': '🌦',
    '266': '🌦',
    '281': '🌧',
    '284': '🌧',
    '293': '🌦',
    '296': '🌦',
    '299': '🌧',
    '302': '🌧',
    '305': '🌧',
    '308': '🌧',
    '311': '🌧',
    '314': '🌧',
    '317': '🌧',
    '320': '🌨',
    '323': '🌨',
    '326': '🌨',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧',
    '353': '🌦',
    '356': '🌧',
    '359': '🌧',
    '362': '🌧',
    '365': '🌧',
    '368': '🌨',
    '371': '❄️',
    '374': '🌧',
    '377': '🌧',
    '386': '⛈',
    '389': '🌩',
    '392': '⛈',
    '395': '❄️'
}

data = {}

try:
    # grab from the backyard
    key = open(os.getenv("HOME") + "/.config/waybar/modules/ha_key", "r").read().strip()

    ha = requests.get("https://ha.kulak.us/api/states/sensor.backyard_motion_sensor_temperature",
        headers = {
            "Authorization": "Bearer " + key,
            "Content-Type": "application/json"
        }
    ).json()

    # and the forecast
    weather = requests.get("https://wttr.in/portland?format=j1").json()

    data['text'] = str(round(float(ha['state']), 1)) + "° " + \
        WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + "    " + \
        f"↑ {weather['weather'][0]['maxtempF']}° ↓ {weather['weather'][1]['mintempF']}° "
except Exception as e:
    data['text'] = "…"
    print(str(e))


print(json.dumps(data))

