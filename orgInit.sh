sf demoutil org create scratch -f config/project-scratch-def.json -d 5 -s -p admin -e electron.demo
sf project deploy start
sf org assign permset -n electron
sfdx shane:user:permset:assign -n analytics -g Integration -l User
sf automig load --inputdir ./data --deletebeforeload

# Deploy the metadata for the the dataflow (this needed to happen AFTER the other meta data was pushed and the permset was applied to the Integration user)
sf project deploy start -d dataflow

# Start the dataflow for the Analytics.
sfdx shane:analytics:dataflow:start -n Electron

# Deploy the metadata for the Einstein Analytics visualizations (this will only deploy after the dataflow has run)
sf project deploy start -d visualizations
sfdx shane:theme:activate -n Electron
sf demoutil user password set -p salesforce1 -g User -l User
sf org open
