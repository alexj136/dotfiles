#!/usr/bin/env python3
# A script to parse the battery status from acpi for use with status bar apps.

import re
from subprocess import check_output

acpi_output = check_output(['acpi'], universal_newlines=True)
output = "BAT"
if not acpi_output:
    output += " NONE"
else:
    batteries = acpi_output.split("\n")
    batteries = list(filter(None, batteries))
    num_batteries = len(batteries)
    for battery_index, battery in enumerate(batteries):
        if battery != '':
            state = battery.split(": ")[1].split(", ")[0]
            percent = int(battery.split(", ")[1].rstrip("%\n"))
            if num_batteries > 1:
                output += " " + str(battery_index) + ":"
            if state == "Discharging":
                output += " D"
            elif state == "Full":
                output += " F"
            elif state == "Unknown":
                output += " U"
            else:
                output += " C"
            output += " " + str(percent) + "%"
            if num_batteries > 1 and battery_index < num_batteries - 1:
                output += ";"
print(output)
