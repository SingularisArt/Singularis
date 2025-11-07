#!/usr/bin/env python3

import os
import json
import time
from rofi import Rofi
import requests
import argparse
from datetime import datetime


class Times:
    def __init__(self, api_key, url, country='US', city='Tigard', state='OR'):
        self.api_key = api_key
        self.url = url
        self.country = country
        self.city = city
        self.state = state
        self.query = {"country": self.country, "city": self.city, "state":
                      self.state}
        self.headers = {}

        self.headers = {
            'x-rapidapi-host': "aladhan.p.rapidapi.com",
            'x-rapidapi-key': self.api_key
        }

        self.fajir, self.sun_rise, self.duhur, \
            self.asar, self.maghrib, self.isha = self.get_times()

    def get_times(self):
        response = requests.request('GET', self.url, headers=self.headers,
                                    params=self.query)
        data = json.loads(response.text)

        fajir = datetime.strptime(data['data']['timings']['Fajr'],
                                  "%H:%M").strftime("%I:%M %p")
        sun_rise = datetime.strptime(data['data']['timings']['Sunrise'],
                                     "%H:%M").strftime("%I:%M %p")
        dhuhr = datetime.strptime(data['data']['timings']['Dhuhr'],
                                  "%H:%M").strftime("%I:%M %p")
        asar = datetime.strptime(data['data']['timings']['Asr'],
                                 "%H:%M").strftime("%I:%M %p")
        maghrib = datetime.strptime(data['data']['timings']['Maghrib'],
                                    "%H:%M").strftime("%I:%M %p")
        isha = datetime.strptime(data['data']['timings']['Isha'],
                                 "%H:%M").strftime("%I:%M %p")

        return fajir, sun_rise, dhuhr, asar, maghrib, isha

    def check_current_time(self):
        now = datetime.now()
        current_time = now.strftime("%I:%M %p")

        if current_time >= self.fajir and current_time <= self.isha:
            return "Fajir"
        elif current_time >= self.sun_rise and current_time <= self.fajir:
            return "Sunrise"
        elif current_time >= self.duhur and current_time <= self.sun_rise:
            return "Dhuhr"
        elif current_time >= self.asar and current_time <= self.duhur:
            return "Asar"
        elif current_time >= self.maghrib and current_time <= self.asar:
            return "Maghrib"
        elif current_time >= self.isha and current_time <= self.maghrib:
            return "Isha"
        else:
            return "Not in prayer"

    def freeze_computer(self):
        now = datetime.now()
        current_time = now.strftime("%I:%M %p")

        if current_time == self.fajir:
            os.system('notify-send "Fajir" "Freezing computer in 10 seconds"')
            time.sleep(10)
            os.system('slock')
            print('Fajir')
            time.sleep('120')
        elif current_time == self.duhur:
            os.system('notify-send "Duhur" "Freezing computer in 10 seconds"')
            time.sleep(10)
            os.system('slock')
            print('Duhur')
            time.sleep('120')
        elif current_time == self.asar:
            os.system('notify-send "Asar" "Freezing computer in 10 seconds"')
            time.sleep(10)
            os.system('slock')
            print('Asar')
            time.sleep('120')
        elif current_time == self.maghrib:
            os.system('notify-send "Maghrib" + \
                      "Freezing computer in 10 seconds"')
            time.sleep(10)
            os.system('slock')
            print('Maghrib')
            time.sleep('120')
        elif current_time == self.isha:
            os.system('notify-send "Isha" "Freezing computer in 10 seconds"')
            time.sleep(10)
            os.system('slock')
            print('Isha')
            time.sleep('120')
        else:
            return False


def Main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-r", "--rofi", default=False,
                        help="Output times for prayer through rofi",
                        action="store_true")

    args = parser.parse_args()
    rofi = Rofi()

    data = Times('76b37c03a4msh5e8966f29e28d19p1bdc2djsn170abec73e0e',
                 'https://aladhan.p.rapidapi.com/timingsByCity')

    if not args.rofi:
        print(data.check_current_time())
        data.freeze_computer()
    else:
        rofi.error("""Fajir:      {}
Duhur:      {}
Asar:       {}
Maghrib:    {}
Isha:       {}""".format(data.fajir, data.duhur, data.asar, data.maghrib,
                         data.isha))


if __name__ == "__main__":
    Main()
