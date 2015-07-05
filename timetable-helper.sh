#!/bin/bash

url="https://webapp.coventry.ac.uk/Timetable-main/Show/5977084?f=&t=&d=20140924&u=furgerf&k=CpWmMMiAjL9-ElWAas3Q7kB2\$Gw.X#view=month"

wget -O timetable_data "$url" &> /dev/null

