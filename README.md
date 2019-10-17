# linshare-editor-onlyoffice-dockerfile

## Build
```
docker build -t linagora/linshare-editor-onlyoffice .
```

## Run
| Environment variables                       | Description
|---------------------------------------------|---------------------------------------------------------------------------------------------------
| BASE_URL                                    | The url of how browser editor and document server address the backend app, default: "http://editor-onlyoffice.linshare.local"
| LINSHARE_API_BASE_URL                       | The base url of LinShare backend API, default: "http://backend.linshare.local/linshare/webservice/rest"
| MONGODB_CONNECTION                          | The string for MongoDB connection, default: "mongodb://mongo.linshare.local/linshare-oo-editor"
| DOCUMENT_SERVER_JWT_BROWSER_TOKEN_ENABLE    | Enable tokenizing the payload of document configuration that is sent to document server, default: true
| DOCUMENT_SERVER_JWT_BROWSER_TOKEN_SECRET    | The secret key to write the token, default: secret
| DOCUMENT_SERVER_JWT_INCOMING_REQUEST_ENABLE | Enable JWT authorization of incoming requests from document server, default: true
| DOCUMENT_SERVER_JWT_INCOMING_REQUEST_SECRET | The secret key to verify the token, default: secret

Example:
```
docker run -it -p 8800:8081 --rm --name linshare-editor-onlyoffice \
  -e BASE_URL=http://172.17.0.1:8081 \
  -e LINSHARE_API_BASE_URL=http://172.17.0.1:28080/linshare/webservice/rest \
  -e MONGODB_CONNECTION=mongodb://172.17.0.1:27017/linshare-oo-editor \
  linagora/linshare-editor-onlyoffice
```