#!/bin/bash

copy -r ./client /app/client
copy -r ./server /app/server

npm run start /app/dist/server.js
