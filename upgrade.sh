#!/bin/shell
#Variabelen
sa = "sudo apt"

$sa update && $sa upgrade && $sa dist-upgrade
