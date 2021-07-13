$studentprefix = "hbs"
$githubAccount = "hatboyzero"
$githubRepo = "mcw-continuous-delivery-lab-files"
$resourcegroupName = "fabmedical-rg-" + $studentprefix
$cosmosDBName = "fabmedical-cdb-" + $studentprefix

# Fetch CosmosDB Mongo connection string
$mongodbConnectionString = `
    $(az cosmosdb keys list `
        --name $cosmosDBName `
        --resource-group $resourcegroupName `
        --type connection-strings `
        --query 'connectionStrings[0].connectionString')

# Seed CosmosDB database
docker run -ti `
    -e MONGODB_CONNECTION="$mongodbConnectionString" `
    docker.pkg.github.com/$githubAccount/$githubRepo/fabrikam-init

