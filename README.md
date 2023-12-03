# Second homework

You have two applications in the __frontapp__ and __backapp__ folders.

You can test the applications with the Postman collection: _Second Homework.postman_collection.json_ or with the Bruno collection in the _bruno-api_ folder.

## Frontapp application

You can run the application with these commands:

```
./mvnw clean package
java -jar target/cubix-second-homework-frontapp-0.0.1-SNAPSHOT.jar
```


## Backapp application

You can run the application with these commands:

```
./mvnw clean package
java -jar target/cubix-second-homework-backapp-0.0.1-SNAPSHOT.jar
```

## Running the two applications together

By default both applications will bind to the localhost's 8080 port - only one of them can do this simultaneously.

The backapp application can be started with a modified port binding like this:

```
java -jar target/cubix-second-homework-backapp-0.0.1-SNAPSHOT.jar --server.port=8081
```

The frontapp can reach the backapp only if it's URL is provided.
The backapp application's URL can be configured like this with the startup command (the URL here is http://localhost:8081):

```
java -jar target/cubix-second-homework-frontapp-0.0.1-SNAPSHOT.jar --back.url=http://localhost:8081
```


## Házifeladat megoldása

A label a Dockerfile-ban lett beállítva.

```dockerfile
FROM eclipse-temurin:17-jre

# Label add as needed 
LABEL "cubix.homework.owner"="Markgruber Ferenc"

# Create apps directory
RUN mkdir /opt/app && chown 1001 -R /opt/app

# non root user (for higher security) 
USER 1001

WORKDIR /opt/app

# copy frontend app
COPY --chown=1001 frontapp/target/*.jar frontapp.jar

# copy backend app
COPY --chown=1001 backapp/target/*.jar backapp.jar
 
# copy starter script

COPY --chown=1001 start.sh start.sh


CMD ./start.sh
```

A konténerhez bevezettem a kérteken kívül még pár környezeti változót.

BACK_PORT - a backen portja

MODE a konténer üzemmódja. Értékei:

FE - frontendkén indul el

BE - backendként indul el
	
FULL - fullstack mód 

Ezeket a start.sh-ban használom

```bash
#!/bin/bash

# Start the backend
if [[ $MODE == "BE" || $MODE == "FULL" ]]; then

	java -jar backapp.jar --server.port=$BACK_PORT & 
	
fi

# in fullstack mode wait 15 secs for backend to start. It would be better to check backend's URL for readiness. 

if [[ $MODE == "FULL" ]]; then

	sleep 15
	
fi
	

# Start the frontend
if [[ $MODE == "FE" || $MODE == "FULL" ]]; then

	java -jar frontapp.jar --back.url=$BACK_URL &
	
fi



# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?
```

	
konténer build:

```
docker build -f Dockerfile -t homework2:0.1 .
```

A  
```
docker inspect homework2:0.1 
```
parancs eredménye, ott a label:

```json
[
    {
        "Id": "sha256:8bfc796fb2b35809f826f33bf51608051c1679d1a874e263f1c31cc59501edf8",
        "RepoTags": [
            "homework2:0.1"
        ],
        "RepoDigests": [],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2023-12-03T19:01:03.590990864Z",
        "Container": "",
        "ContainerConfig": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": null,
            "Cmd": null,
            "Image": "",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "DockerVersion": "",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "1001",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "JAVA_HOME=/opt/java/openjdk",
                "LANG=en_US.UTF-8",
                "LANGUAGE=en_US:en",
                "LC_ALL=en_US.UTF-8",
                "JAVA_VERSION=jdk-17.0.9+9"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "./start.sh"
            ],
            "ArgsEscaped": true,
            "Image": "",
            "Volumes": null,
            "WorkingDir": "/opt/app",
            "Entrypoint": [
                "/__cacert_entrypoint.sh"
            ],
            "OnBuild": null,
            "Labels": {
                "cubix.homework.owner": "Markgruber Ferenc",
                "org.opencontainers.image.ref.name": "ubuntu",
                "org.opencontainers.image.version": "22.04"
            }
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 323349727,
        "VirtualSize": 323349727,
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/pjibq87znbf8thztnu3w924t1/diff:/var/lib/docker/overlay2/6brmyma4drzic8qas5phnpmy7/diff:/var/lib/docker/overlay2/9lrvndjf7wss31uwwn0722uh2/diff:/var/lib/docker/overlay2/65tt6frmtrq99nd4b5u82s0yu/diff:/var/lib/docker/overlay2/447331fa150a022ddd6bf2c3a3f099587a5c546f1892467b64cff297acd37ba5/diff:/var/lib/docker/overlay2/eda45219711df10b0f6a3b630839fa12601ba52705fc29c912b32617243ee58c/diff:/var/lib/docker/overlay2/2e2e296e8ed26ee8ce2fd123195e3c708026ee3d2022e666dcdec95da07bb8a2/diff:/var/lib/docker/overlay2/b8f721b8f1ccf5a7c09b07f31c1b1792d598637b174a0bd0e4995ed889640edc/diff:/var/lib/docker/overlay2/a51863c2d16eefa4d0db8dd96ac5edb56d2e362c90f951810ea7d5ff18cbd711/diff",
                "MergedDir": "/var/lib/docker/overlay2/ip7l5eq1if0kzad1axlsnuynx/merged",
                "UpperDir": "/var/lib/docker/overlay2/ip7l5eq1if0kzad1axlsnuynx/diff",
                "WorkDir": "/var/lib/docker/overlay2/ip7l5eq1if0kzad1axlsnuynx/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:8ceb9643fb36a8ac65882c07e7b2fff9fd117673d6784221a83d3ad076a9733e",
                "sha256:3de9bbd55c1d9b722e3195a582388ac023cd61712d45d6f921a19d6b21c62b6f",
                "sha256:e9db4731c77199fdae06a3937671a4a0051af80faa15b3c9459b61e3c38f6bb0",
                "sha256:8ddec224834c3dd26b73830159393ae80baa7ceb1650a310bc7c38cd2f75d228",
                "sha256:c28fdec40c4aa0c7bc3926e4e97a46f50c3bc1731c2e92171027996167f37c70",
                "sha256:8e5226efcad36381cfb029b4d53149c225ddcd9d3f68ac81a750e4abdb62866d",
                "sha256:5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef",
                "sha256:b2a06a4fe4ba582ddcfc1438e8f337ce9d1ab5bab12b3cd5cc6121f0dae4ef44",
                "sha256:42e8af9d4ef2099610820bc2d43e72c4ffc3839bd84181f96e4d0164bace1bfd",
                "sha256:8450486a97d19c97f703aec0979908ef22f418595a762ce26f01e52ce29acd35"
            ]
        },
        "Metadata": {
            "LastTagTime": "2023-12-03T19:01:03.666926303Z"
        }
    }
]

``` 

Indítás fullstack módban (a https://host.docker.internal:8081 nálam nem működött):

```
docker run -p 8080:8080 --rm -d --name hw2 -e BACK_PORT=8081 -e BACK_URL=http://localhost:8081 -e MODE=FULL -e CUBIX_HOMEWORK=MarkgruberF -e APP_DEFAULT_MESSAGE=  homework2:0.1
```




a http://localhost:8080/frontapp?message=Hello

hívás eredménye
```json
{
    "msForReply": 302,
    "backappMessage": "Hello",
    "frontappHomeworkOwner": "MarkgruberF",
    "frontappHostAddress": "172.17.0.2",
    "backappHomeworkOwner": "MarkgruberF",
    "backappHostAddress": "172.17.0.2",
    "doExtraImageDataMatch": false
}
```



A docker-compose.yaml két példányban indítja el a build-elt image-t, BE és FE módban.

```yaml
services:
    backend:
        image: homework2:0.1
        environment:
            BACK_PORT: 8081 
            BACK_URL:  
            MODE: BE 
            CUBIX_HOMEWORK: MarkgruberF  
            APP_DEFAULT_MESSAGE: 
            
    frontend: 
        image: homework2:0.1
        ports:
        - 8080:8080
        environment:
            BACK_PORT: 
            BACK_URL:  http://backend:8081
            MODE: FE 
            CUBIX_HOMEWORK: MarkgruberF  
            APP_DEFAULT_MESSAGE: 

```

Indítás

```
docker compose up
```

