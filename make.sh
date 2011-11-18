#!/bin/bash
haml index.haml > 'index.html'
sass style.sass > 'style.css'
coffee -c js.coffee
