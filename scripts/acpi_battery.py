#!/usr/bin/env python3
# A script to parse the battery status from acpi for use with status bar apps.
# Assumes that multiple batteries will each have the same capacity.

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
    unknown = []
    charging = []
    full = []
    percentages = []
    for battery in batteries:
        if battery != '':
            state = battery.split(": ")[1].split(", ")[0]
            percent = int(battery.split(", ")[1].rstrip("%\n"))
            if state == "Discharging":
                full.append(False)
                charging.append(False)
                unknown.append(False)
            elif state == "Full":
                full.append(True)
                charging.append(False)
                unknown.append(False)
            elif state == "Unknown":
                full.append(False)
                charging.append(False)
                unknown.append(True)
            else:
                full.append(False)
                charging.append(True)
                unknown.append(False)
            percentages.append(percent)
    if all(full): output += " F "
    elif any(charging): output += " C "
    elif all(unknown): output += " U "
    else: output += " D "
    output += str(sum(percentages) // len(percentages)) + "%"
print(output)
