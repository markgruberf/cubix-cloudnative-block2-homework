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

A label és az env változók a Dockerfile-ban lettek beállítva.
TYPE határozza meg, hogy milyen konténer készüljön.
default frontend

```Dockerfile
FROM quay.io/drsylent/cubix/block2/homework-base:java17 

ARG TYPE=frontapp 

# Label add as needed 
LABEL "cubix.homework.owner"="Markgruber Ferenc"

# evironmet variables
ENV CUBIX_HOMEWORK=MarkgruberF 
ENV APP_DEFAULT_MESSAGE=  

# Create apps directory
RUN mkdir /opt/app && chown 1001 -R /opt/app

# non root user (for higher security) 
USER 1001

WORKDIR /opt/app

# copy  app
COPY --chown=1001 ${TYPE}/target/*.jar app.jar
COPY --chown=1001 ${TYPE}/start.sh start.sh

CMD ./start.sh
```

	
konténer build:
Frontend:
```
docker build -f Dockerfile -t frontapp:0.1 .
```

Backend:
```
docker build -f Dockerfile --build-arg TYPE=backapp -t backapp:0.1 .
```


A  
```
docker inspect frontapp:0.1 
```
parancs eredménye, ott a label:

```json
[
    {
        "Id": "sha256:6b5c9e7c62f1d489920d3c2b88e20013cac140140ca65c6e1f88f61b6dc22ab2",
        "RepoTags": [
            "frontapp:0.1"
        ],
        "RepoDigests": [],
        "Parent": "",
        "Comment": "buildkit.dockerfile.v0",
        "Created": "2023-12-04T10:31:44.711083246Z",
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
                "JAVA_VERSION=jdk-17.0.9+9",
                "EXTRA_FROM_BASE=Cubix training",
                "CUBIX_HOMEWORK=MarkgruberF",
                "APP_DEFAULT_MESSAGE="
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
        "Size": 304294135,
        "VirtualSize": 304294135,
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/jedgym261sbjfgv4eo2vskta3/diff:/var/lib/docker/overlay2/muovnajtlqhlko57en1plviis/diff:/var/lib/docker/overlay2/1ah3szoeq5tihrie2wpdz02sn/diff:/var/lib/docker/overlay2/57a7e9920bc8662a7c51c454eb8a5d9de6dbc8777dfc7944b3b2b043e6a7184f/diff:/var/lib/docker/overlay2/43435068ff0dfb5694857e971b5a21dd0101e127f8775c8ad990d779a4b2cfb1/diff:/var/lib/docker/overlay2/d0850026e7b51840a58d0ac0a0b843ed1f862e0ab328edbc25d0d9395c53f23c/diff:/var/lib/docker/overlay2/b70c6ec775577509b5d84e1cfe0bd5b6377949085bec34d873de20c8882f1b4d/diff:/var/lib/docker/overlay2/3146ac0deac55706c6b1c2c2d94625b0ff49b80859217f62058dddc2cc7717c6/diff",
                "MergedDir": "/var/lib/docker/overlay2/xqh8xq8v13cy9dm0qjm2r00q4/merged",
                "UpperDir": "/var/lib/docker/overlay2/xqh8xq8v13cy9dm0qjm2r00q4/diff",
                "WorkDir": "/var/lib/docker/overlay2/xqh8xq8v13cy9dm0qjm2r00q4/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:256d88da41857db513b95b50ba9a9b28491b58c954e25477d5dad8abb465430b",
                "sha256:e62a9b52de75760495bf88acf7f01641a6f2d30b14e1b537fbfda7a4c02631b3",
                "sha256:ee68869aa760f2546e024f72a49230abd46eefe071e4f4e99a779048488a809e",
                "sha256:b8c176a5086e931073b679462e7f190334b532ce4d8a362fcc1679b4e420d293",
                "sha256:c2873c9f3d938d134c70bff4ca9f12c872f2e92260fd1092911cd838db21bc22",
                "sha256:5d9304511f69d5d0b217b9adba120a2e3cd2f2c732b503c2eb0bfc7781d749d1",
                "sha256:5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef",
                "sha256:cdf9cb2cfe522798478e9f08c93fc44e93e6d78a9cf20ae07aa3b9f55b4d7223",
                "sha256:f235eb6dfe4f88ffa76f75199918a043789945a30eabd92d2b87f2f85df40be2"
            ]
        },
        "Metadata": {
            "LastTagTime": "2023-12-04T10:31:44.796654585Z"
        }
    }
]

``` 





A docker-compose.yaml 

```yaml
services:
    backend:
        image: backapp:0.1
             
    frontend: 
        image: frontapp:0.1
        ports:
        - 8080:8080
        environment:
            BACK_URL:  http://backend:8081
```

a http://localhost:8080/frontapp?message=Hello

hívás eredménye

```json
{
    "msForReply": 322,
    "backappMessage": "Hello",
    "frontappHomeworkOwner": "MarkgruberF",
    "frontappHostAddress": "172.25.0.3",
    "backappHomeworkOwner": "MarkgruberF",
    "backappHostAddress": "172.25.0.2",
    "doExtraImageDataMatch": true
}
```

Log részlet a hívásról

```
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:21.582Z  INFO 7 --- [nio-8080-exec-2] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:21.583Z  INFO 7 --- [nio-8080-exec-2] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:21.586Z  INFO 7 --- [nio-8080-exec-2] o.s.web.servlet.DispatcherServlet        : Completed initialization in 3 ms
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:21.659Z  INFO 7 --- [nio-8080-exec-2] h.c.c.api.controller.FrontappController  : Preparing for calling backapp - message was: Hello
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:21.661Z  INFO 7 --- [nio-8080-exec-2] h.c.c.api.controller.FrontappController  : Calling backapp
cubix-cloudnative-block2-homework-backend-1   | 2023-12-04T10:56:21.835Z  INFO 8 --- [nio-8081-exec-1] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring DispatcherServlet 'dispatcherServlet'
cubix-cloudnative-block2-homework-backend-1   | 2023-12-04T10:56:21.836Z  INFO 8 --- [nio-8081-exec-1] o.s.web.servlet.DispatcherServlet        : Initializing Servlet 'dispatcherServlet'
cubix-cloudnative-block2-homework-backend-1   | 2023-12-04T10:56:21.841Z  INFO 8 --- [nio-8081-exec-1] o.s.web.servlet.DispatcherServlet        : Completed initialization in 4 ms
cubix-cloudnative-block2-homework-backend-1   | 2023-12-04T10:56:21.980Z  INFO 8 --- [nio-8081-exec-1] hu.cubix.cloud.api.BackappController     : Request arrived with message Hello
cubix-cloudnative-block2-homework-backend-1   | 2023-12-04T10:56:21.994Z  INFO 8 --- [nio-8081-exec-1] hu.cubix.cloud.api.BackappController     : Returning response: BackappResponse[time=2023-12-04T10:56:21.984333718, message=Hello, homeworkOwner=MarkgruberF, hostAddress=172.25.0.2, extraImageData=Cubix training]
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:22.636Z  INFO 7 --- [nio-8080-exec-2] h.c.c.api.controller.FrontappController  : Backapp call was successful, response was: BackappResponse[time=2023-12-04T10:56:21.984333718, message=Hello, homeworkOwner=MarkgruberF, hostAddress=172.25.0.2, extraImageData=Cubix training]
cubix-cloudnative-block2-homework-frontend-1  | 2023-12-04T10:56:22.654Z  INFO 7 --- [nio-8080-exec-2] h.c.c.api.controller.FrontappController  : Response will be: FrontappResponse[msForReply=322, backappMessage=Hello, frontappHomeworkOwner=MarkgruberF, frontappHostAddress=172.25.0.3, backappHomeworkOwner=MarkgruberF, backappHostAddress=172.25.0.2, doExtraImageDataMatch=true]
```


