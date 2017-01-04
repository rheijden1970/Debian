#!/bin/bash
#Variabelen
sa = "sudo apt"
vandaag = "date %D"

$sa update && $sa upgrade && $sa dist-upgrade
