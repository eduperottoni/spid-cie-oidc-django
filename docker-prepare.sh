#!/bin/bash

# Copy your configuration to a separate folder
export EXPFOLDER="examples-docker"
cp -R examples $EXPFOLDER

# remove dev db
rm -f $EXPFOLDER/relying_party/db.sqlite3 
rm -f $EXPFOLDER/provider/db.sqlite3 
rm -f $EXPFOLDER/rnp_ta/db.sqlite3 

# Configure the rewrite rules:
export SUB_AT='s,http://127.0.0.1:8000,http://rnp-ta.org:8000,g'
export SUB_RP='s,http://127.0.0.1:8001,http://relying-party.org:8001,g'
export SUB_OP='s,http://127.0.0.1:8002,http://cie-provider.org:8002,g'
export SUB_WTA='s,http://127.0.0.1:8000,http://ufrgs-ta.org:8005,g'
export SUB_UFRGS_TA='s,http://127.0.0.1:8005,http://ufrgs-ta.org:8005,g'
export SUB_UFRGS_SP='s,http://127.0.0.1:8001,http://ufrgs-sp.org:8006,g'


# Apply the rewrite rules:

sed -e $SUB_AT -e $SUB_RP -e $SUB_OP examples/rnp_ta/dumps/example.json > $EXPFOLDER/rnp_ta/dumps/example.json
sed -e $SUB_AT -e $SUB_RP -e $SUB_OP examples/rnp_ta/rnp_ta/settingslocal.py.example > $EXPFOLDER/rnp_ta/rnp_ta/settingslocal.py

sed -e $SUB_WTA -e $SUB_UFRGS_SP examples/ufrgs_ta/dumps/ta-ec.json > $EXPFOLDER/ufrgs_ta/dumps/ta-ec.json
sed -e $SUB_WTA -e $SUB_UFRGS_SP examples/ufrgs_ta/ufrgs_ta/settingslocal.py.example > $EXPFOLDER/ufrgs_ta/ufrgs_ta/settingslocal.py

sed -e $SUB_AT -e $SUB_RP -e $SUB_OP examples/relying_party/dumps/example.json > $EXPFOLDER/relying_party/dumps/example.json
sed -e $SUB_AT -e $SUB_RP -e $SUB_OP examples/relying_party/relying_party/settingslocal.py.example > $EXPFOLDER/relying_party/relying_party/settingslocal.py

sed -e $SUB_AT -e $SUB_OP -e $SUB_UFRGS_SP -e $SUB_UFRGS_TA examples/ufrgs_sp/dumps/example.json > $EXPFOLDER/ufrgs_sp/dumps/example.json
sed -e $SUB_AT -e $SUB_OP -e $SUB_UFRGS_SP -e $SUB_UFRGS_TA examples/ufrgs_sp/ufrgs_sp/settingslocal.py.example > $EXPFOLDER/ufrgs_sp/ufrgs_sp/settingslocal.py

sed -e $SUB_AT -e $SUB_RP -e $SUB_OP examples/provider/dumps/example.json > $EXPFOLDER/provider/dumps/example.json
sed -e $SUB_AT -e $SUB_RP -e $SUB_OP examples/provider/provider/settingslocal.py.example > $EXPFOLDER/provider/provider/settingslocal.py


