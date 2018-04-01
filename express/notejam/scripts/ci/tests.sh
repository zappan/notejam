#!/bin/bash
set -e

npm install
node db.js
./node_modules/mocha/bin/mocha tests

exit 0;
